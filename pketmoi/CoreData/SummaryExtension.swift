//
//  SummaryExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 27/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension Summary{
    static func createSummary(askingInterval: String?, endDate: Date, startDate: Date, appointment: Appointment) -> Summary {
        let newSummary = NSEntityDescription.insertNewObject(forEntityName: "Summary", into: CoreDataManager.context) as! Summary
        newSummary.askingInterval = askingInterval
        newSummary.endDate = endDate
        newSummary.startDate = startDate
        newSummary.appointment = appointment
        appointment.summary = newSummary
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newSummary
    }
}
