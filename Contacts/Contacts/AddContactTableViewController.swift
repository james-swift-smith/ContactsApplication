//
//  AddContactTableViewController.swift
//  Contacts
//
//  Created by James Smith on 2/16/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

struct Section {
    let name: String
    var rows: Int
    let cellReuseIdentifier: [String]
    var header: String?
}

struct SegueInfo {
    let name: String
}

class AddContactTableViewController: UITableViewController {

    var contact: Contact?
    var firstName: String?
    var lastName: String?
    var personalInfo: [String]!
    
    var phoneNumber: String?
    
    var phoneNumbers: [Number]?
    var sections: [Section]!
    
    var doneSegue = SegueInfo(name: "HandleAddContactDoneButton")
    var cancelSegue = SegueInfo(name: "HandleAddContactCancelButton")
    var selectPhoneTypeSegue = SegueInfo(name: "SelectPhoneType")
    
    var editDoneSegue = SegueInfo(name: "HandleEditContactDoneButtonActionSegue")
    var editCancelSegue = SegueInfo(name: "HandleEditContactCancelButtonActionSegue")
    
    var addContactSegue: Bool?
    var addNewNumberInEditMode: Bool?
    
    var indexOfCurrentlyEditingPhoneType: IndexPath?
    
    var textFields: [UITextField]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if addContactSegue! {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
        configureSection()
        
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing = true
        
        phoneNumbers = [Number]()
        textFields = [UITextField]()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if addContactSegue! {
            return constructCellForAddingContact(cellForRowAt: indexPath)
        } else {
            return constructCellForEditingContact(cellForRowAt: indexPath)
        }
    }
    
    func constructPersonalInfoCell(cellForRowAt indexPath: IndexPath) -> AddContactTableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section].cellReuseIdentifier[0], for: indexPath) as? AddContactTableViewCell)!
        let cellCustomTextFieldConfig = configureCellCustomTextField(forRow: indexPath.row)
        cell.isFirstNameFiled = cellCustomTextFieldConfig.isFirstNameField
        cell.addContactTableViewControllerDelegate = self
        cell.registerTextField()
        return cell
    }
    
    func constructPhoneNumberCell(cellForRowAt indexPath: IndexPath) -> AddPhoneWithTypeTableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section].cellReuseIdentifier[1], for: indexPath) as? AddPhoneWithTypeTableViewCell)!
        
        cell.addContactTableViewControllerDelegate = self
        cell.setButtonTag(tag: indexPath.row)
        cell.registerTextField()
        return cell
    }
    
    func constructAddPhoneNumberCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section].cellReuseIdentifier[0], for: indexPath)
        return cell
    }
    
    func constructCellForAddingContact(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = constructPersonalInfoCell(cellForRowAt: indexPath)
            let cellCustomTextFieldConfig = configureCellCustomTextField(forRow: indexPath.row)
            cell.customTextField?.placeholder = cellCustomTextFieldConfig.placeholderText
            
            return cell
            
        } else {
            if indexPath.row == (sections?[indexPath.section].rows)! - 1 {
                return constructAddPhoneNumberCell(cellForRowAt: indexPath)
            } else {
                let cell = constructPhoneNumberCell(cellForRowAt: indexPath)
                cell.setPhoneTypeButtonTitle(phoneType: NumberType.mobile.rawValue)
                
                return cell
            }
        }
    }
    
    func constructCellForEditingContact(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !personalInfo.isEmpty {
            if indexPath.section == 0 {
                let cell = constructPersonalInfoCell(cellForRowAt: indexPath)
                cell.setCustomTextFieldText(text: personalInfo[indexPath.row])
                
                return cell
                
            }
        }
        if indexPath.row == (sections?[indexPath.section].rows)! - 1 {
            return constructAddPhoneNumberCell(cellForRowAt: indexPath)
        } else {
            let cell = constructPhoneNumberCell(cellForRowAt: indexPath)
            if let addNewNumberInEditMode = addNewNumberInEditMode {
                if addNewNumberInEditMode {
                    cell.setPhoneTypeButtonTitle(phoneType: NumberType.mobile.rawValue)
                }
            } else {
                cell.setPnoneNumberTextFieldText(text: (contact?.numbers[indexPath.row].numberString)!)
                cell.setPhoneTypeButtonTitle(phoneType: (contact?.numbers[indexPath.row].numberType.rawValue)!)
            }
            
            return cell
        }
    }
    
    func configureCellCustomTextField(forRow row: Int) -> (placeholderText: String, isFirstNameField: Bool) {
        var placeholder: String
        var isFitstName: Bool
        if row == 0 {
            placeholder = "First name"
            isFitstName = true
        } else {
            placeholder = "Last name"
            isFitstName = false
        }
        
        return (placeholder, isFitstName)
    }
    
    func configureSection() {
        sections = [Section]()
        personalInfo = [String]()
        
        if let contact = contact {
            if let firstName = contact.firstName {
                personalInfo.append(firstName)
                self.firstName = firstName
            }
            if let lastName = contact.lastName {
                personalInfo.append(lastName)
                self.lastName = lastName
            }
            
            if !personalInfo.isEmpty {
                sections.append(Section(name: "Name", rows: personalInfo.count, cellReuseIdentifier: ["AddContactCell"], header: "Personal Information"))
            }
            
            if !contact.numbers.isEmpty  {
                var header: String
                if contact.numbers.count > 1 {
                    header = "Phone Numbers"
                } else {
                    header = "Phone Number"
                }
                sections.append(Section(name: "Phone Numbers", rows: contact.numbers.count + 1, cellReuseIdentifier: ["AddNumberCell", "AddPhoneWithTypeCell"], header: header))
            }
        } else {
            sections = [Section(name: "Name", rows: 2, cellReuseIdentifier: ["AddContactCell"], header: "Personal Information"), Section(name: "Number", rows: 1, cellReuseIdentifier: ["AddNumberCell", "AddPhoneWithTypeCell"], header: "Phone Number")]
        }
    }
    
    // MARK: Table view editing configuration

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.section == 0 {
            return UITableViewCellEditingStyle.none
        }
        if indexPath.section == 1 && indexPath.row == sections[1].rows - 1 {
            return UITableViewCellEditingStyle.insert
        }
        return UITableViewCellEditingStyle.delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Decrement number of rows in Number Section
            sections[1].rows -= 1
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Increment number of rows in Number Section and insert new row
            addNewNumberInEditMode = addContactSegue! ? false : true
            sections[1].rows += 1
            let indexForNewRow = IndexPath(row: tableView.numberOfRows(inSection: 1) - 1, section: 1)
            tableView.insertRows(at: [indexForNewRow], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == sections[indexPath.section].rows - 1 {
            addNewNumberInEditMode = addContactSegue! ? false : true
            sections[indexPath.section].rows += 1
            let indexForNewRow = IndexPath(row: tableView.numberOfRows(inSection: indexPath.section) - 1, section: indexPath.section)
            tableView.insertRows(at: [indexForNewRow], with: .automatic)
            let indexForAddRow = IndexPath(row: sections[indexPath.section].rows - 1, section: indexPath.section)
            tableView.deselectRow(at: indexForAddRow, animated: true)
        }
    }
    
    // MARK: Table view helper methods
    
    func collectAllNumbers() {
        for row in 0..<sections[1].rows - 1 {
            let indexPath = IndexPath(row: row, section: 1)
            let cell = tableView.cellForRow(at: indexPath) as! AddPhoneWithTypeTableViewCell
            if let number = cell.composeNumber() {
                phoneNumbers?.append(number)
            }
        }
    }
    
    // MARK: Navigation
    
    func watchOverAllTextFields() {
        print("in watchOverAllTextFields")
        print("textfields count: \(textFields?.count)")
        
        var allEmpty = true
        for textField in textFields! {
            if !(textField.text?.isEmpty)! {
                allEmpty = false
            }
        }
        handleDoneButtonState(textFiled: allEmpty)
    }
    
    func handleDoneButtonState(textFiled isEmpty: Bool) {
        if isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    
    @IBAction func unwindSegueForDoneButton(_ sender: UIBarButtonItem) {
        if addContactSegue! {
            performSegue(withIdentifier: doneSegue.name, sender: self)
        } else {
            performSegue(withIdentifier: editDoneSegue.name, sender: self)
        }
    }
    
    @IBAction func unwindSegueForCancelButton(_ sender: UIBarButtonItem) {
        if addContactSegue! {
            performSegue(withIdentifier: cancelSegue.name, sender: self)
        } else {
            performSegue(withIdentifier: editCancelSegue.name, sender: self)
        }
    }
    
    
    @IBAction func handlePhoneTypeCancelButtonAction(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func handlePhoneTypeDoneButtonAction(segue: UIStoryboardSegue) {
        if let phoneTypeTableViewController = segue.source as? PhoneTypeTableViewController {
            let cell = (tableView.cellForRow(at: indexOfCurrentlyEditingPhoneType!) as? AddPhoneWithTypeTableViewCell)!
            cell.setPhoneTypeButtonTitle(phoneType: phoneTypeTableViewController.selectedPhoneType!)
        }
    }
    
    @IBAction func handlePhoneTypeCellSelectedAction(segue: UIStoryboardSegue) {
        if let phoneTypeTableViewController = segue.source as? PhoneTypeTableViewController {
            let cell = (tableView.cellForRow(at: indexOfCurrentlyEditingPhoneType!) as? AddPhoneWithTypeTableViewCell)!
            cell.setPhoneTypeButtonTitle(phoneType: phoneTypeTableViewController.selectedPhoneType!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case doneSegue.name, editDoneSegue.name:
            collectAllNumbers()
            view.endEditing(true)
            contact = Contact(firstName: firstName, lastName: lastName, numbers: phoneNumbers!)
        case cancelSegue.name, editCancelSegue.name:
            view.endEditing(true)
        case selectPhoneTypeSegue.name:
            if let navigationController = segue.destination as? UINavigationController {
                if let phoneTypeTableViewController = navigationController.topViewController as? PhoneTypeTableViewController {
                    let cell = (tableView.cellForRow(at: indexOfCurrentlyEditingPhoneType!) as? AddPhoneWithTypeTableViewCell)!
                    phoneTypeTableViewController.initializePhoneTypes()
                    phoneTypeTableViewController.selectedPhoneType = cell.getPhoneTypeButtonTitle()
                }
            }
        default:
            break
        }
    }
}
