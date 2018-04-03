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
    static func fillDatabase(){
        _ = TypeEvent.createTypeEvent(name: "Somnolence")
        _ = TypeEvent.createTypeEvent(name: "Chute")
        _ = TypeEvent.createTypeEvent(name: "Hallucination")
        _ = TypeEvent.createTypeEvent(name: "Prise de dispersible")
        _ = TypeEvent.createTypeEvent(name: "Clic / bolus d'Apokinon")
    }
}
