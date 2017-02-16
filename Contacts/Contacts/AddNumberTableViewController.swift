//
//  AddNumberTableViewController.swift
//  Contacts
//
//  Created by Taras Motyl on 2/16/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

class AddNumberTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var sections: [Section]?
    var phoneNumberTypePicker: UIPickerView?
    var phoneTypes: [String]?
    var doneSegue = SegueInfo(name: "HandleAddNumberDoneButton")
    
    var phoneNumber: String?
    var phoneNumberType: NumberType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem?.isEnabled = false
        sections = [Section(name: "Phone number", rows: 1, cellReuseIdentifier: "PhoneNumberCell", header: nil), Section(name: "Phone type", rows: 1, cellReuseIdentifier: "PhoneNumberTypeCell", header: "Phone Type")]
        
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return (sections?.count)!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sections?[section].rows)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: (sections?[0].cellReuseIdentifier)!, for: indexPath) as! AddNumberTableViewCell
            cell.addNumberTableDelegate = self
            //cell.phoneNumberTextField.becomeFirstResponder()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: (sections?[1].cellReuseIdentifier)!, for: indexPath)
            
            phoneNumberTypePicker = UIPickerView(frame: CGRect(x: cell.contentView.frame.origin.x, y: cell.contentView.frame.origin.y, width: cell.contentView.frame.width, height: cell.contentView.frame.height))
            // Set the dataSource and Delegate for this picker to be the Controller
            phoneNumberTypePicker?.dataSource = self
            phoneNumberTypePicker?.delegate = self
            phoneNumberTypePicker?.showsSelectionIndicator = true
            
            cell.contentView.addSubview(phoneNumberTypePicker!)
            cell.contentView.bringSubview(toFront: phoneNumberTypePicker!)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44
        } else {
            return 88
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return sections?[0].header
        } else {
            return sections?[1].header
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return NumberType.allValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        phoneTypes = [String]()

        for value in NumberType.allValues {
            phoneTypes?.append(value.rawValue)
        }
        return phoneTypes?[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == doneSegue.name {
            view.endEditing(true)
            let currentPnoneType = phoneNumberTypePicker?.selectedRow(inComponent: 0)
            phoneNumberType = NumberType(id: currentPnoneType!)
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
}
