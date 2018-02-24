//
//  Patient.swift
//  pketmoi
//
//  Created by Hugo Maitre on 24/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation

/**
 Patient type
 
 **birthDate**: Patient -> NSDate
 **informations**: Patient -> String
 **preparationTime**: Patient -> String
 **age**: Patient -> Int
 
 */
class Patient: Person {
    
    var birthDate : Date?
    var information : String?
    var preparationTime : Int?
    
    override init(firstname: String, lastname: String){
        super.init(firstname: firstname, lastname: lastname)
    }
    
}
