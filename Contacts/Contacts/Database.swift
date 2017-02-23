//
//  Database.swift
//  Contacts
//
//  Created by James Smith on 2/7/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import Foundation

// A simple application storage class for our app.
class Database {
    static var sharedInstance = Database()
    lazy var contacts: [Contact] =
        [("Steven",  "Gerrard",  "0032654321"),
         ("Jef", "Le Roy", "0052123456"),
         ("Phill", "Ivry", "0088098765"),
         ("Oscar", "O'Neil", "0032567890"),
         ("Penny", "Le Roy", "0052135792"),
         ("Maxime", "Defauw", "0088246801"),
         ("Ray", "Wenderlich", "0032114527"),
         ("Violette", "Le Roy", "0052562283"),
         ("John", "Bentham", "0088778467"),
         ("Sebastian", "Bommer", "0043978786"),
         ("Charlotte", "Sky", "0052123444"),
         ("Thomas", "Valette", "0088946733"),
         ("Claire", "Graham", "0088090987"),
         ("Valeria", "Flower", "0088655473"),
         ("Jullie", "Closs", "0074128876"),
         ("Junior", "Resp", "0074145836"),
         ("Eddie", "Broe", "0022673698"),
         ("Charise", "Ivry", "00220936798"),
         ("Sal", "Addis", "0022783940"),
         ("Bebe", "Cashwell", "0032264826"),
         ("Allan", "Germaine", "0038936627"),
         ("Hipolito", "Churchill", "0032115468"),
         ("Danita", "Tseng", "0032904728"),
         ("Shelia", "Musson", "0083367289"),
         ("Arnold", "Nail", "0033647830"),
         ("Kimiko", "Patin", "0052543794"),
         ("Hattie", "Steffes", "0078647730"),
         ("Evia", "Harkleroad", "0078894003"),
         ("Murray", "Marasco", "0078667468"),
         ("Albertina", "Landy", "0065478204"),
         ("Efren", "Earle", "0089647390") ].map {
            (firstName, lastName, numberString) -> Contact in
            return Contact(firstName: firstName, lastName: lastName, number: Number(numberString: numberString)!)
    }
    
    func updateContact(with contact: Contact, atIndex index: Int) {
        if index >= 0 && index <= contacts.count {
            contacts[index] = contact
        }
        sortContacts()
    }
    
    func sortContacts() {
        contacts.sort(by: <)
    }
}

