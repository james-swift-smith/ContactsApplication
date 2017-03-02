//
//  Number.swift
//  Contacts
//
//  Created by James Smith on 2/6/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import Foundation

enum NumberType: String {
    case mobile
    case home
    case work
    
    static let allValues = [mobile, home, work]
    
    init?(id : Int) {
        switch id {
        case 0:
            self = .mobile
        case 1:
            self = .home
        case 2:
            self = .work
        default:
            return nil
        }
    }
}

struct Number {
    var numberString: String?
    var numberType: NumberType
    
    init?(numberString: String?, numberType: NumberType = .mobile) {
        guard numberString != nil else {
            return nil
        }
        self.numberString = numberString
        self.numberType = numberType
    }
}

extension Number: CustomStringConvertible {
    var description: String {
        return numberString!
    }
}

extension Number: Equatable {
    static func == (lhs: Number, rhs: Number) -> Bool {
        return (lhs.numberString == rhs.numberString) && (lhs.numberType == rhs.numberType)
    }
}

extension Number: Hashable {
    var hashValue: Int {
        return (numberString?.hashValue)! ^ numberType.hashValue
    }
}
