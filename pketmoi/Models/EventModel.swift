//
//  EventModel.swift
//  pketmoi
//
//  Created by Loris Zirah on 13/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

/*class EventModel: TimeItemModel {
    privateinternal var dao: Event
    var TypeEventName: String{
        get{
            guard let name = self.dao.typeEvent?.name else{
                fatalError()
            }
            return name
        }
        set{
            self.TypeEventName = newValue
        }
    }
    
    init(itemDescription: String, date: Date, typeEventName: String){
        guard let dao = Event.getNewEventDao() else{
            fatalError()
        }
        super.init(itemDescription: itemDescription, date: date)
        self.dao = dao
        self.dao.typeEvent = TypeEvent.getTypeEventDao(forName: typeEventName)
    }
}
*/
extension Event{
    static func getNewEventDao() -> Event?{
        guard let entity = NSEntityDescription.entity(forEntityName: "Event", in: CoreDataManager.context) else{
            return nil
        }
        return Event(entity: entity, insertInto: CoreDataManager.context)
    }
    
    static func createEvent(itemDescription: String, date: Date, typeEvent: TypeEvent) -> Event {
        let newEvent = NSEntityDescription.insertNewObject(forEntityName: "Event", into: CoreDataManager.context) as! Event
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

