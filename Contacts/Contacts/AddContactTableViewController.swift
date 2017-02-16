//
//  AddContactTableViewController.swift
//  Contacts
//
//  Created by James Smith on 2/16/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

struct TableStructure {
    let sections: Int
    let nameSectionID: Int
    let rowsInNameSection: Int
    let numberSectionID: Int
    var rowsInNumberSections: Int
    let cellReuseIdentifier: String
}

struct SegueInfo {
    let name: String
}

class AddContactTableViewController: UITableViewController {

    var contact: Contact?
    var firstName: String?
    var lastName: String?
    var phoneNumbers: [String]?
    var tableStructure: TableStructure?
    var doneSegue: SegueInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem?.isEnabled = false
        tableStructure = TableStructure(sections: 2, nameSectionID: 0, rowsInNameSection: 2, numberSectionID: 1, rowsInNumberSections: 1, cellReuseIdentifier: "AddContactCell")
        
        doneSegue = SegueInfo(name: "HandleAddContactDoneButton")
        
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
        return (tableStructure?.sections)!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == tableStructure?.nameSectionID) {
            return (tableStructure?.rowsInNameSection)!
        }
        return (tableStructure?.rowsInNumberSections)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == tableStructure?.nameSectionID {
            let cell = (tableView.dequeueReusableCell(withIdentifier: (tableStructure?.cellReuseIdentifier)!, for: indexPath) as? AddContactTableViewCell)!
            let cellCustomTextFieldConfig = configureCellCustomTextField(forRow: indexPath.row)
        
            cell.addContactTableDelegate = self
            cell.customTextField?.font = UIFont(name: "System", size: 17)
            cell.customTextField?.placeholder = cellCustomTextFieldConfig.placeholderText
            cell.isFirstNameFiled = cellCustomTextFieldConfig.isFirstNameField
            
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: (tableStructure?.cellReuseIdentifier)!)
            cell.textLabel?.text = "Add number"
            return cell
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == doneSegue?.name {
            view.endEditing(true)
            contact = Contact(firstName: firstName, lastName: lastName)
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
