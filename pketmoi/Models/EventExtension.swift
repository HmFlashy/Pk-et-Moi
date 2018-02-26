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


extension Event {


    static func createEvent(moc: NSManagedObjectContext, name: String) -> Event {
        let newEvent = NSEntityDescription.insertNewObject(forEntityName: "Event", into: moc) as! Event
        newEvent.name = name
        do {
            try moc.save()
        } catch let error as NSError {
            print(error)
            
        }
        return newEvent
    }
    
    static func getAllEvents(moc: NSManagedObjectContext) throws -> [Event] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        
        let fetchResults = try moc.fetch(fetchRequest) as? [Event]
        return fetchResults!
    }
}
