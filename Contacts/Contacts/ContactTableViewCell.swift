//
//  ContactTableViewCell.swift
//  Contacts
//
//  Created by Taras Motyl on 2/7/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    var contact: Contact! {
        didSet {
            textLabel?.text = contact.description
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
