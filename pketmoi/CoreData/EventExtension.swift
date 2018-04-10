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
    
    static func fillDatabase(typesEvent: [TypeEvent]){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        _ = createEvent(itemDescription: "Très grande fatigue", date: Date(), typeEvent: typesEvent[0])
        _ = createEvent(itemDescription: "Apparition dans la journée", date: Date(), typeEvent: typesEvent[0])
        _ = createEvent(itemDescription: "Chute de l'escalier de mon immeuble", date: Date(), typeEvent: typesEvent[1])
        _ = createEvent(itemDescription: "", date: dateFormatter.date(from: "2018-04-08 11:00")!, typeEvent: typesEvent[2])
        _ = createEvent(itemDescription: "", date: dateFormatter.date(from: "2018-02-12 15:00")!, typeEvent: typesEvent[3])
        _ = createEvent(itemDescription: "", date: dateFormatter.date(from: "2018-03-08 21:30")!, typeEvent: typesEvent[3])
        _ = createEvent(itemDescription: "", date: dateFormatter.date(from: "2018-01-21 09:00")!, typeEvent: typesEvent[4])
    }
}
