//
//  Contact.swift
//  Contacts
//
//  Created by James Smith on 2/6/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

class Contact {
    var firstName: String
    var lastName: String?
    var numbers: [Number]
    
    init(firstName: String, lastName: String?) {
        self.firstName = firstName
        self.lastName = lastName
        numbers = [Number]()
    }
}

extension Contact: CustomStringConvertible {
    var description: String {
        guard lastName != nil else {
            return firstName
        }
        return [firstName, lastName!].joined(separator: " ")
    }
}
