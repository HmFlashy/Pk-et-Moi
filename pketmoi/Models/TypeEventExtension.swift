//
//  Event+CoreDataProperties.swift
//  pketmoi
//
//  Created by Hugo Maitre on 25/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

/*
 
 Event model class
 
 -------Class methods--------
 **createEvent: String -> Event
 **getAllEvents: -> [Event]
 **getEventById: Integer -> Event
 **deleteEventById: Integer -> Bool
 **deleteEvent: Event -> Bool
 
 -------Instance methods--------
 **name: Event -> String
 
 */

extension TypeEvent {

    static func createEvent(name: String) -> TypeEvent {
        let newTypeEvent = NSEntityDescription.insertNewObject(forEntityName: "TypeEvent", into: CoreDataManager.context) as! TypeEvent
        newTypeEvent.name = name
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newTypeEvent
    }
    
    static func getAllEvents() throws -> [TypeEvent] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TypeEvent")
        
        let fetchResults = try CoreDataManager.context.fetch(fetchRequest) as? [TypeEvent]
        return fetchResults!
    }
    
    static func getEventByKey(key: Int32){
        
    }
}
