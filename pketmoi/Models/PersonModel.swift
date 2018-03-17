//
//  Personne.swift
//  pketmoi
//
//  Created by Hugo Maitre on 20/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

/**
 Person type
 
 *lastname*: Person -> String
 *firstname*: Person -> String
 *fullname*: Person -> String
 *address*: Person -> String?
 *postalCode*: Person -> String
 *phoneNumber*: Person -> String
 *email*: Person -> String
 
 */
class PersonModel{
    
    private var dao : Person
    
    var firstname : String?{
        get{
            return self.dao.firstname
        }
        set{
            self.dao.firstname = newValue
        }
    }
    var lastname  : String? {
        get{
            return self.dao.lastname
        }
        set{
            self.dao.lastname = newValue
        }
    }
    var address : String? {
        get{
            return self.dao.address
        }
        set{
            self.dao.address = newValue
        }
    }
    var zip : String? {
        get{
            return self.dao.zip
        }
        set{
            self.dao.zip = newValue
        }
    }
    var phone : String? {
        get{
            return self.dao.phone
        }
        set{
            self.dao.phone = newValue
        }
    }
    var email : String? {
        get{
            return self.dao.email
        }
        set{
            self.dao.email = newValue
        }
    }
    
    /// initialize a Person
    ///
    /// - Parameters:
    ///   - firstname: String first name of Person
    ///   - lastname:  String last name of Person
    init(firstname: String, lastname: String, address: String, postalCode: String, phoneNumber: String, email: String){
        guard let dao = Person.getNewPersonDAO() else{
            fatalError()
        }
        self.dao = dao
        self.firstname = firstname
        self.lastname  = lastname
        self.address = address
        self.zip = postalCode
        self.phone = phoneNumber
        self.email = email
    }
    
    /// fullname property: String firstname lastname (read-only)
    var fullname: String? {
        guard let firstname = self.dao.firstname, let lastname = self.dao.lastname
            else {
            return nil
        }
        return firstname + " " + lastname
    }
}
