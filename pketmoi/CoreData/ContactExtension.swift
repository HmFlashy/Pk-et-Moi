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
    
    var fullname: String {
        get {
            return self.firstname! + " " + self.lastname!
        }
    }
}
