//
//  AddPhoneWithTypeTableViewCell.swift
//  Contacts
//
//  Created by Taras Motyl on 2/19/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

class AddPhoneWithTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneTypeButton: UIButton!
    var pType: String?
    var addContactTableViewControllerDelegate: AddContactTableViewController?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        phoneTypeButton.titleLabel?.minimumScaleFactor = 0.1
        phoneTypeButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func phoneNumberTextFieldEditingDidChanged(_ sender: AnyObject) {
        addContactTableViewControllerDelegate?.handleDoneButtonState(textFiled: (phoneNumberTextField?.text?.isEmpty)!)
        addContactTableViewControllerDelegate?.phoneNumber = (phoneNumberTextField?.text)!
    }
    
    @IBAction func phoneTypeButtonTouchedDown(_ sender: UIButton) {
        addContactTableViewControllerDelegate?.indexOfCurrentlyEditingPhoneType = IndexPath(row: sender.tag, section: 1)
    }
    func setPhoneTypeButtonTitle(phoneType type: String) {
        phoneTypeButton.setTitle(type, for: .normal)
        pType = type
    }
    
    func getPhoneTypeButtonTitle() -> String? {
        return phoneTypeButton.currentTitle
    }
    
    func setButtonTag(tag: Int) {
        phoneTypeButton.tag = tag
    }
    
    func composeNumber() -> Number? {
        if (phoneNumberTextField.text?.isEmpty)! {
            return nil
        }
        return Number(numberString: phoneNumberTextField.text, numberType: NumberType(rawValue: phoneTypeButton.currentTitle!)!)
    }
}
