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
    
    /// Create a sumamry
    ///
    /// - Parameters:
    ///   - askingInterval: the interval between two ask of the state
    ///   - endDate: the date where the summary should end
    ///   - startDate: the date where the summary should start
    ///   - appointment: the appointement linked to this summary
    /// - Returns: an instance of the class Summary with the given parameters
    static func createSummary(askingInterval: String?, endDate: Date, startDate: Date, appointment: Appointment) -> Summary {
        guard let newSummary = NSEntityDescription.insertNewObject(forEntityName: "Summary", into: CoreDataManager.context) as? Summary else{
            print("Summary does not exists in the database")
            fatalError()
        }
        newSummary.askingInterval = askingInterval
        newSummary.endDate = endDate
        newSummary.startDate = startDate
        newSummary.appointment = appointment
        
        CoreDataManager.save()
        return newSummary
    }
}
