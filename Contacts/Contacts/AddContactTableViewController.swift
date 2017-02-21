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
    
    var phoneNumber: String?
    
    var phoneNumbers: [Number]?
    var sections: [Section]!
    
    var doneSegue = SegueInfo(name: "HandleAddContactDoneButton")
    var selectPhoneTypeSegue = SegueInfo(name: "SelectPhoneType")
    
    var indexOfCurrentlyEditingPhoneType: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        sections = [Section(name: "Name", rows: 2, cellReuseIdentifier: ["AddContactCell"], header: "Personal Information"), Section(name: "Number", rows: 1, cellReuseIdentifier: ["AddNumberCell", "AddPhoneWithTypeCell"], header: "Number")]
        
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing = true
        
        phoneNumbers = [Number]()
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
        if indexPath.section == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: sections[0].cellReuseIdentifier[0], for: indexPath) as? AddContactTableViewCell)!
            let cellCustomTextFieldConfig = configureCellCustomTextField(forRow: indexPath.row)
        
            cell.addContactTableDelegate = self
            cell.customTextField?.font = UIFont(name: "System", size: 17)
            cell.customTextField?.placeholder = cellCustomTextFieldConfig.placeholderText
            cell.isFirstNameFiled = cellCustomTextFieldConfig.isFirstNameField
            
            return cell
        } else {
            if indexPath.row == (sections?[1].rows)! - 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: sections[1].cellReuseIdentifier[0], for: indexPath)
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: sections[1].cellReuseIdentifier[1], for: indexPath) as? AddPhoneWithTypeTableViewCell)!
                    
                cell.addContactTableViewControllerDelegate = self
                cell.setPhoneTypeButtonTitle(phoneType: NumberType.mobile.rawValue)
                cell.setButtonTag(tag: indexPath.row)
                
                return cell
            }
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
            sections[1].rows += 1
            let indexForNewRow = IndexPath(row: tableView.numberOfRows(inSection: 1) - 1, section: 1)
            tableView.insertRows(at: [indexForNewRow], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == sections[1].rows - 1 {
            sections[1].rows += 1
            let indexForNewRow = IndexPath(row: tableView.numberOfRows(inSection: 1) - 1, section: 1)
            tableView.insertRows(at: [indexForNewRow], with: .automatic)
            let indexForAddRow = IndexPath(row: sections[1].rows - 1, section: 1)
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
    
    func handleDoneButtonState(textFiled isEmpty: Bool) {
        if isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
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
        if segue.identifier == doneSegue.name {
            collectAllNumbers()
            view.endEditing(true)
            contact = Contact(firstName: firstName, lastName: lastName, numbers: phoneNumbers!)
        }
        if segue.identifier == selectPhoneTypeSegue.name {
            if let navigationController = segue.destination as? UINavigationController {
                if let phoneTypeTableViewController = navigationController.topViewController as? PhoneTypeTableViewController {
                    let cell = (tableView.cellForRow(at: indexOfCurrentlyEditingPhoneType!) as? AddPhoneWithTypeTableViewCell)!
                    phoneTypeTableViewController.initializePhoneTypes()
                    phoneTypeTableViewController.selectedPhoneType = cell.getPhoneTypeButtonTitle()
                }
            }
        }
    }
}
