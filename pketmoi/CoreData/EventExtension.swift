//
//  EventExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 02/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension Event{
    
    /// Create an event
    ///
    /// - Parameters:
    ///   - itemDescription: the description of the event
    ///   - date: the date of the event
    ///   - typeEvent: the type of event of the event
    /// - Returns: an instance of the class Event with the given parameters
    static func createEvent(itemDescription: String, date: Date, typeEvent: TypeEvent) -> Event {
        guard let newEvent = NSEntityDescription.insertNewObject(forEntityName: "Event", into: CoreDataManager.context) as? Event else{
            print("Event does not exists in the database")
            fatalError()
        }
        newEvent.itemDescription = itemDescription
        newEvent.date = date
        newEvent.typeEvent = typeEvent
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newEvent
    }
}
