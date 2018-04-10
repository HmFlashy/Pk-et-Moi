//
//  ContactExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 02/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension Contact{
    
    /// Create a contact
    ///
    /// - Parameters:
    ///   - firstname: the fisrt name of the contact
    ///   - lastname: the last name of the contact
    ///   - phone: the phone of the contact
    ///   - status: the contact's relatives
    ///   - address: the address of the contact
    /// - Returns: an instance of the class Contact with the given parameters
    static func createContact(firstname: String, lastname: String, phone: String, status: String, address: String?) -> Contact {
        guard let newContact = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: CoreDataManager.context) as? Contact else{
            print("Contact does not exists in the database")
            fatalError()
        }
        newContact.firstname = firstname
        newContact.lastname = lastname
        newContact.phone = phone
        newContact.status = status
        newContact.address = address
        
        CoreDataManager.save()
        return newContact
    }
    
    /// The fullname of the contact
    var fullname: String {
        get {
            return self.firstname! + " " + self.lastname!
        }
    }
    
    static func fillDatabase(){
        _ = createContact(firstname: "Loris", lastname: "Zirah", phone: "0623565258", status: "ami", address: "8 avenue du pont juvenal")
        _ = createContact(firstname: "Hugo", lastname: "Maitre", phone: "0652568596", status: "frère", address: "5 rue boussairolles")
        _ = createContact(firstname: "Pharmacie", lastname: "du Triolet", phone: "0652458574", status: "pharmacie", address: "1 rue de Gascogne")
    }
}
