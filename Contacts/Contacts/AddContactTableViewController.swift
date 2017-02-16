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
    let cellReuseIdentifier: String
    var header: String?
}

struct SegueInfo {
    let name: String
}

class AddContactTableViewController: UITableViewController {

    var contact: Contact?
    var firstName: String?
    var lastName: String?
    var phoneNumbers: [Number]?
    //var tableStructure: TableStructure?
    var sections: [Section]?
    var doneSegue = SegueInfo(name: "HandleAddContactDoneButton")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        sections = [Section(name: "Name", rows: 2, cellReuseIdentifier: "AddContactCell", header: "Personal Information"), Section(name: "Number", rows: 1, cellReuseIdentifier: "AddNumberCell", header: "Number")]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func handleDoneButtonState(textFiled isEmpty: Bool) {
        if isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return (sections?.count)!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sections?[section].rows)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: (sections?[0].cellReuseIdentifier)!, for: indexPath) as? AddContactTableViewCell)!
            let cellCustomTextFieldConfig = configureCellCustomTextField(forRow: indexPath.row)
        
            cell.addContactTableDelegate = self
            cell.customTextField?.font = UIFont(name: "System", size: 17)
            cell.customTextField?.placeholder = cellCustomTextFieldConfig.placeholderText
            cell.isFirstNameFiled = cellCustomTextFieldConfig.isFirstNameField
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: (sections?[1].cellReuseIdentifier)!, for: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return sections?[0].header
        } else {
            return sections?[1].header
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == doneSegue.name {
            view.endEditing(true)
            contact = Contact(firstName: firstName, lastName: lastName)
        }
    }
    
    @IBAction func handleAddNumberCancelButtonAction(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func handleAddNumberDoneButtonAction(segue: UIStoryboardSegue) {
        if let addNumberViewController = segue.source as? AddNumberTableViewController {
            let number = Number(numberString: addNumberViewController.phoneNumber, numberType: addNumberViewController.phoneNumberType!)
            phoneNumbers?.append(number!)
            print("number: \(number!.numberString)")
            print("type: \(number!.numberType)")
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
