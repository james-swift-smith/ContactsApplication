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
    var addContactTableDelegate: AddContactTableViewController?
    var isFirstNameFiled: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func customTextFiledEditingChanged(_ sender: AnyObject) {
        addContactTableDelegate?.handleDoneButtonState(textFiled: (customTextField?.text?.isEmpty)!)
        
        if isFirstNameFiled! == true {
            addContactTableDelegate?.firstName = (customTextField?.text)!
        } else {
            addContactTableDelegate?.lastName = (customTextField?.text)!
        }
    }
    
    func setCustomTextFieldText(text: String) {
        customTextField?.text = text
    }
}
