//
//  TypeEventExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 02/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension TypeEvent{
    
    /// Create a typeEvent
    ///
    /// - Parameter name: the name of the type of event
    /// - Returns: an instance of the class TypeEvent with the given parameters
    static func createTypeEvent(name: String) -> TypeEvent {
        guard let newTypeEvent = NSEntityDescription.insertNewObject(forEntityName: "TypeEvent", into: CoreDataManager.context) as? TypeEvent else{
            print("TypeEvent does not exists in the database")
            fatalError()
        }
        newTypeEvent.name = name
        
        CoreDataManager.save()
        return newTypeEvent
    }
    
    /// Fill the database with some types of event
    static func fillDatabase() -> [TypeEvent]{
        var typeEvents: [TypeEvent] = []
        typeEvents.append(TypeEvent.createTypeEvent(name: "Somnolence"))
        typeEvents.append(TypeEvent.createTypeEvent(name: "Chute"))
        typeEvents.append(TypeEvent.createTypeEvent(name: "Hallucination"))
        typeEvents.append(TypeEvent.createTypeEvent(name: "Prise de dispersible"))
        typeEvents.append(TypeEvent.createTypeEvent(name: "Clic / bolus d'Apokinon"))
        return typeEvents
    }
}
