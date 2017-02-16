//
//  AddNumberTableViewCell.swift
//  Contacts
//
//  Created by Taras Motyl on 2/16/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

class AddNumberTableViewCell: UITableViewCell {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    var addNumberTableDelegate: AddNumberTableViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func phoneNumberTextFieldEdtitingChanged(_ sender: AnyObject) {
        addNumberTableDelegate?.handleDoneButtonState(textFiled: (phoneNumberTextField?.text?.isEmpty)!)
        addNumberTableDelegate?.phoneNumber = (phoneNumberTextField?.text)!
    }
}
