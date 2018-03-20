//
//  DoctorExtension.swift
//  pketmoi
//
//  Created by Hugo Maitre on 13/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension Doctor {
    
    static func getNewDoctorDAO() -> Doctor? {
        guard let newDoctor: Doctor = NSEntityDescription.insertNewObject(forEntityName: "Doctor", into: CoreDataManager.context) as? Doctor else {
            fatalError()
        }
        return newDoctor
    }
    
    var fullname: String? {
        get {
            var firstname = self.firstname
            var lastname = self.lastname
            if firstname == nil {
                firstname = "unknown"
            }
            if lastname == nil {
                lastname = "unknown"
            }
            return firstname! + " " + lastname!
        }
        
    }
}
