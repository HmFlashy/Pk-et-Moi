//
//  AppointmentExtension.swift
//  pketmoi
//
//  Created by Hugo Maitre on 19/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension Appointment {
    static func CreateAppointment(date: Date, doctor: Doctor) -> Appointment? {
        guard let newAppointment = NSEntityDescription.insertNewObject(forEntityName: "Appointment", into: CoreDataManager.context) as? Appointment else{
            print("AppoAppointment does not exists in the database")
            fatalError()
        }
        newAppointment.doctor = doctor
        newAppointment.date = date
        
        CoreDataManager.save()
        return newAppointment
    }
}
