//
//  ContactDetailsViewController.swift
//  Contacts
//
//  Created by Taras Motyl on 2/7/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    var contact: Contact!

    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameLabel.text = contact.firstName
        lastNameLabel.text = contact.lastName
        if !contact.numbers.isEmpty {
            phoneNumber.text = contact.numbers[0].numberString
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
