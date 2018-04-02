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
    
    static func createTypeEvent(name: String) -> TypeEvent {
        guard let newTypeEvent = NSEntityDescription.insertNewObject(forEntityName: "TypeEvent", into: CoreDataManager.context) as? TypeEvent else{
            print("TypeEvent does not exists in the database")
            fatalError()
        }
        newTypeEvent.name = name
        
        CoreDataManager.save()
        return newTypeEvent
    }
    
    static func fillDatabase(){
        _ = TypeEvent.createTypeEvent(name: "Somnolence")
        _ = TypeEvent.createTypeEvent(name: "Chute")
        _ = TypeEvent.createTypeEvent(name: "Hallucination")
        _ = TypeEvent.createTypeEvent(name: "Prise de dispersible")
        _ = TypeEvent.createTypeEvent(name: "Clic / bolus d'Apokinon")
    }
}
