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

extension Contact: Hashable {
    var hashValue: Int {
        var hash = 0
        if let fristNameHasValue = firstName?.hashValue {
            hash = hash ^ fristNameHasValue
        }
        if let lastNameHashValue = lastName?.hashValue {
            hash = hash ^ lastNameHashValue
        }
        if !(numbers.isEmpty) {
            for number in numbers {
                hash = hash ^ number.hashValue
            }
        }
        return hash
    }
}

extension Contact: Comparable {
    static func < (lhs: Contact, rhs: Contact) -> Bool {        
        if let lhsFirstName = lhs.firstName, let rhsFirstName = rhs.firstName {
            return lhsFirstName < rhsFirstName
        }
        if let lhsLastName = lhs.lastName, let rhsLastName = rhs.lastName {
            return lhsLastName < rhsLastName
        }
        if let lhsNumber = lhs.numbers[0].numberString, let rhsNumber = rhs.numbers[0].numberString {
            return lhsNumber < rhsNumber
        }
        return false
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
