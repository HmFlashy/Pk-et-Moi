//
//  TypeEventModel.swift
//  pketmoi
//
//  Created by Loris Zirah on 13/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

class TypeEventModel {
    private var dao: TypeEvent
    
    var nom: String?{
        get{
            return self.dao.name
        }
        set{
            self.dao.name = newValue
        }
    }
    
    init(nom: String) {
        guard let dao = TypeEvent.getNewTypeEventDao() else{
            fatalError()
        }
        self.dao = dao
        self.dao.name = nom
    }
}

extension TypeEvent{
    static func getNewTypeEventDao() -> TypeEvent?{
        guard let entity = NSEntityDescription.entity(forEntityName: "TypeEvent", in: CoreDataManager.context) else{
            return nil
        }
        return TypeEvent(entity: entity, insertInto: CoreDataManager.context)
    }
    
    static func getTypeEventDao(forName: String) -> TypeEvent{
        let request: NSFetchRequest<TypeEvent> = TypeEvent.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(TypeEvent.name), ascending: false)]
        request.predicate = NSPredicate(format: "name == %@",forName)
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        do{
            try fetchedResultController.performFetch()
        }catch{
            print("error")
        }
        return fetchedResultController.object(at: IndexPath(row: 0, section: 0))
    }
    
    static func createTypeEvent(name: String) -> TypeEvent {
        let newTypeEvent = NSEntityDescription.insertNewObject(forEntityName: "TypeEvent", into: CoreDataManager.context) as! TypeEvent
        newTypeEvent.name = name
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newTypeEvent
    }
}

