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
}
