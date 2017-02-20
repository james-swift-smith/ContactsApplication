//
//  Contact.swift
//  Contacts
//
//  Created by James Smith on 2/6/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

class Contact {
    var firstName: String?
    var lastName: String?
    var numbers: [Number]
    
    init?(firstName: String?, lastName: String?) {
        if firstName == nil && lastName == nil {
            return nil
        }
        if let firstName = firstName {
            self.firstName = firstName
        }
        if let lastName = lastName {
            self.lastName = lastName
        }
        numbers = [Number]()
    }
    
    init(firstName: String?, lastName: String?, number: Number) {
        if let firstName = firstName {
            self.firstName = firstName
        }
        if let lastName = lastName {
            self.lastName = lastName
        }
        numbers = [Number]()
        numbers.append(number)
    }
    
    init(firstName: String?, lastName: String?, numbers: [Number]) {
        if let firstName = firstName {
            self.firstName = firstName
        }
        if let lastName = lastName {
            self.lastName = lastName
        }
        self.numbers = numbers
    }
}

extension Contact: CustomStringConvertible {
    var description: String {
        var fullName = [String]()
        if let firstName = firstName {
            fullName.append(firstName)
        }
        if let lastName = lastName {
            fullName.append(lastName)
        }
        if !numbers.isEmpty && fullName.isEmpty {
            fullName.append(numbers.first!.description)
        }
        return fullName.joined(separator: " ")
    }
}
