//
//  NewContactTableViewController.swift
//  Contacts
//
//  Created by Taras Motyl on 2/7/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

class NewContactTableViewController: UITableViewController{

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBAction func firstNameTextiFieldEditingChanged(_ sender: UITextField) {
        if (firstNameTextField.text?.isEmpty)! {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }    
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveNewContactSegue" {
            contact = Contact(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!)
            if let number = Number(numberString: phoneNumberTextField.text!, contact: contact!) {
                contact?.numbers.append(number)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 1 {
            print("HERE!")
            print("Hello")
        }
    }
}
