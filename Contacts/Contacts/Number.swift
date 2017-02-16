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
