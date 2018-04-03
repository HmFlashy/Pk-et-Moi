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
    
    /// Create an appointment
    ///
    /// - Parameters:
    ///   - date: the date of the appointment
    ///   - doctor: the doctor linked to the appointment
    /// - Returns: an instance of the class Appointment with the given parameters
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
