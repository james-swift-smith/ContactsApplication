//
//  NewContactTableViewController.swift
//  Contacts
//
//  Created by Taras Motyl on 2/7/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

class NewContactTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        if (firstNameTextField.text?.isEmpty)! {
            // Disable DONE button here!
        }
        
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Enable DONE button here!
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
}
