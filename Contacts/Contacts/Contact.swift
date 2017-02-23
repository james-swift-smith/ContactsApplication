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

extension Contact: Comparable {
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        if let lhsFirstnName = lhs.firstName {
            if let rhsFirstName = rhs.firstName {
                return lhsFirstnName < rhsFirstName
            } else {
                if let rhsLastName = rhs.lastName {
                    return lhsFirstnName < rhsLastName
                } else {
                    return lhs.numbers[0].numberString! < rhs.numbers[0].numberString!
                }
            }
        } else {
            if let lhsLastName = lhs.lastName {
                if let rhsFirstName = rhs.firstName {
                    return lhsLastName < rhsFirstName
                } else {
                    if let rhsLastName = rhs.lastName {
                        return lhsLastName < rhsLastName
                    } else {
                        return lhs.numbers[0].numberString! < rhs.numbers[0].numberString!
                    }
                }
            } else {
                return lhs.numbers[0].numberString! < rhs.numbers[0].numberString!
            }
        }
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        var equal = false        
        
        if let lhsFirstName = lhs.firstName {
            if let rhsFirstName = rhs.firstName {
                if lhsFirstName == rhsFirstName {
                    equal = true
                } else {
                    return false
                }
            } else {
                return false
            }
        }
        if let lhsLastName = lhs.lastName {
            if let rhsLastName = rhs.lastName {
                if lhsLastName == rhsLastName {
                    equal = true
                } else {
                    return false
                }
            } else {
                return false
            }
        }
        if lhs.numbers.count == rhs.numbers.count {
            for i in 0 ..< lhs.numbers.count {
                if lhs.numbers[i] == rhs.numbers[i] {
                    equal = true
                } else {
                    return false
                }
            }
        } else {
            return false
        }
        return equal
    }
}
