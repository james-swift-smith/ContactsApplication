//
//  AddContactTableViewCell.swift
//  Contacts
//
//  Created by Taras Motyl on 2/16/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

class AddContactTableViewCell: UITableViewCell {    
    @IBOutlet weak var customTextField: UITextField?
    var addContactTableViewControllerDelegate: AddContactTableViewController?
    var isFirstNameFiled: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    @IBAction func customTextFiledEditingChanged(_ sender: UITextField) {
        addContactTableViewControllerDelegate?.watchOverAllTextFields()
        if !(customTextField?.text?.isEmpty)! {
            if isFirstNameFiled! == true {
                addContactTableViewControllerDelegate?.firstName = (customTextField?.text)!
            } else {
                addContactTableViewControllerDelegate?.lastName = (customTextField?.text)!
            }
        } else {
            if isFirstNameFiled! == true {
                addContactTableViewControllerDelegate?.firstName = nil
            } else {
                addContactTableViewControllerDelegate?.lastName = nil
            }
        }
    }
    
    func setCustomTextFieldText(text: String) {
        customTextField?.text = text
    }
    
    func registerTextField() {
        addContactTableViewControllerDelegate?.textFields?.append(customTextField!)
    }
}
