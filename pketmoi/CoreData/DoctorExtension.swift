//
//  DoctorExtension.swift
//  pketmoi
//
//  Created by Hugo Maitre on 20/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension Doctor {
    
    static func createDoctor(lastname: String, firstname: String, phone: String?, email: String?, address: String?, city: String?, zip: String?, travelTime: Int16) -> Doctor {
        guard let newDoctor = NSEntityDescription.insertNewObject(forEntityName: "Doctor", into: CoreDataManager.context) as? Doctor else{
            print("Doctor does not exists in the database")
            fatalError()
        }
        newDoctor.lastname = lastname
        newDoctor.firstname = firstname
        newDoctor.phone = phone
        newDoctor.email = email
        newDoctor.address = address
        newDoctor.city = city
        newDoctor.zip = zip
        newDoctor.travelTime = travelTime
        
        CoreDataManager.save()
        return newDoctor
    }
    
    var fullname: String {
        get {
            return self.firstname! + " " + self.lastname!
        }
    }
}
