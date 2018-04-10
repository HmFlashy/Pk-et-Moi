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
        print(newActivity)
        CoreDataManager.save()
        return newActivity
    }
    
    static func fillDatabase(typesActivity: [TypeActivity]){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        _ = Activity.createActivity(itemDescription: "", date: dateFormatter.date(from: "2018-04-10 17:00")!, duration: "1:00", typeActivity: typesActivity[0])
    }
}
