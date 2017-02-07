//
//  Number.swift
//  Contacts
//
//  Created by Taras Motyl on 2/6/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import Foundation

enum NumberType {
    case mobile
    case work
    case home
}

class Number {
    var numberString: String?
    var numberType: NumberType
    unowned var contact: Contact
    
    init?(numberString: String? = "", contact: Contact, numberType: NumberType = .mobile) {
        guard numberString != "" else {
            return nil
        }
        self.numberString = numberString
        self.contact = contact
        self.numberType = numberType
    }
}

extension Number: CustomStringConvertible {
    var description: String {
        return numberString!
    }
}
