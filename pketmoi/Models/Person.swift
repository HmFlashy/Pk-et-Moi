//
//  Personne.swift
//  pketmoi
//
//  Created by Hugo Maitre on 20/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation

/**
 Person type
 
 **lastname**: Person -> String
 **firstname**: Person -> String
 **fullname**: Person -> String
 **address**: Person -> String?
 **postalCode**: Person -> String
 **phoneNumber**: Person -> String
 **email**: Person -> String
 
 */
class Person{
    
    var firstname : String?
    var lastname  : String?
    var address : String?
    var postalCode : String?
    var phoneNumber : String?
    var email : String?
    
    /// initialize a `Person`
    ///
    /// - Parameters:
    ///   - firstname: `String` first name of `Person`
    ///   - lastname:  `String` last name of `Person`
    init(firstname: String, lastname: String, address: String, postalCode: String, phoneNumber: String, email: String){
        self.firstname = firstname
        self.lastname  = lastname
        self.address = address
        self.postalCode = postalCode
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    init(firstname: String, lastname: String){
        self.firstname = firstname
        self.lastname = lastname
    }
    
    /// fullname property: `String` firstname lastname (read-only)
    var fullname: String {
        return self.firstname! + " " + self.lastname!
    }
}

