//
//  ActivityExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 02/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension Activity{
    
    /// Create an activity
    ///
    /// - Parameters:
    ///   - itemDescription: the description of the activity
    ///   - date: the date of the activity
    ///   - duration: the duration of the activity
    ///   - typeActivity: the type of the activty
    /// - Returns: an instance of the class Activity with the given parameters
    static func createActivity(itemDescription: String?, date: Date, duration: String, typeActivity: TypeActivity) -> Activity {
        guard let newActivity = NSEntityDescription.insertNewObject(forEntityName: "Activity", into: CoreDataManager.context) as? Activity else{
            print("Activity does not exists in the database")
            fatalError()
        }
        newActivity.itemDescription = itemDescription
        newActivity.date = date
        newActivity.duration = duration
        newActivity.typeActivity = typeActivity
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newActivity
    }
}
