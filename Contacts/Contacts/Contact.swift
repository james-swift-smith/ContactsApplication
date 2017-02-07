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
    var lastName: String
    var number: [Number]
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        number = [Number]()
    }
}

extension Contact: CustomStringConvertible {
    var description: String {
        return [firstName, lastName].joined(separator: " ")
    }
}