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
    
    
    /// Create a doctor
    ///
    /// - Parameters:
    ///   - lastname: the lastname of the doctor
    ///   - firstname: the firstname of the doctor
    ///   - phone: the phone of the doctor
    ///   - email: the email of the doctor
    ///   - address: the address of the doctor
    ///   - city: the city of the doctor
    ///   - zip: the cip of the doctor
    ///   - travelTime: the travelTime to the doctor
    ///   - profession: the profession of the doctor
    /// - Returns: an instance of the class Doctor with the given paremeters
    static func createDoctor(lastname: String, firstname: String, phone: String?, email: String?, address: String?, city: String?, zip: String?, travelTime: Int16, profession: Profession) -> Doctor {
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
        newDoctor.profession = profession
        
        CoreDataManager.save()
        return newDoctor
    }
    
    
    /// The fullname of the doctor
    var fullname: String {
        get {
            return self.firstname! + " " + self.lastname!
        }
    }
    
    static func fillDatabase(){
        let profession = Profession.getProfession(forTitle: "Neurologue")
        _ = Doctor.createDoctor(lastname: "Depaillat", firstname: "Marc", phone: nil, email: nil, address: nil, city: nil, zip: nil, travelTime: 0, profession: profession!)
    }
}
