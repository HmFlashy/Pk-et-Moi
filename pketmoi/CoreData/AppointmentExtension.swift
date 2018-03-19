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
        guard let appointment = NSEntityDescription.insertNewObject(forEntityName: "Appointment", into: CoreDataManager.context) as? Appointment else{
            return nil
        }
        appointment.doctor = doctor
        appointment.date = date
        do {
            try CoreDataManager.context.save()
        } catch {
            print("Problem during the insertion of an appointment")
        }
        return appointment
    }
}
