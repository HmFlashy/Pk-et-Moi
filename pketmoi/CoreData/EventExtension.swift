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
