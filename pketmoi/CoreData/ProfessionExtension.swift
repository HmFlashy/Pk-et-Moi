//
//  ProfessionExtension.swift
//  pketmoi
//
//  Created by Hugo Maitre on 14/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData


extension Profession {
    
    static func getProfession(forTitle: String) -> Profession? {
        let professionFetched: NSFetchRequest<Profession> = Profession.fetchRequest()
        professionFetched.predicate = NSPredicate(format: "title == %@", forTitle)
        
        let fetchedResultController = NSFetchedResultsController(fetchRequest: professionFetched, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultController.performFetch()
        } catch {
            return nil
        }
        return fetchedResultController.object(at: IndexPath(row: 0, section: 0))
    }
    
    static func fillDatabase() -> [Profession] {
        guard let entity = NSEntityDescription.entity(forEntityName: "Profession", in: CoreDataManager.context) else {
            print("Profession does not exist in database")
            fatalError()
        }
        var profession: [Profession] = []
        profession.append(Profession(entity: entity, insertInto: CoreDataManager.context))
        profession.append(Profession(entity: entity, insertInto: CoreDataManager.context))
        profession[0].title = "Cardiologue"
        profession[1].title = "Ginéco"
        return profession
    }
    
}
