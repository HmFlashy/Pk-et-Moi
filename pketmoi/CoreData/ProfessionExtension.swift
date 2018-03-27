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
    
    static func fillDatabase(typeProfessions: [TypeProfession]) -> [Profession] {
        guard let entity = NSEntityDescription.entity(forEntityName: "Profession", in: CoreDataManager.context) else {
            print("Profession does not exist in database")
            fatalError()
        }
        var profession: [Profession] = []
        profession.append(Profession(entity: entity, insertInto: CoreDataManager.context))
        profession.append(Profession(entity: entity, insertInto: CoreDataManager.context))
        profession.append(Profession(entity: entity, insertInto: CoreDataManager.context))
        profession.append(Profession(entity: entity, insertInto: CoreDataManager.context))
        profession.append(Profession(entity: entity, insertInto: CoreDataManager.context))
        profession.append(Profession(entity: entity, insertInto: CoreDataManager.context))
        profession.append(Profession(entity: entity, insertInto: CoreDataManager.context))
        profession.append(Profession(entity: entity, insertInto: CoreDataManager.context))
        profession.append(Profession(entity: entity, insertInto: CoreDataManager.context))
        profession[0].title = "Neurologue"
        profession[0].typeProfession = typeProfessions[0]
        profession[1].title = "Medecin Généraliste"
        profession[1].typeProfession = typeProfessions[0]
        profession[2].title = "Psychiatre"
        profession[2].typeProfession = typeProfessions[0]
        profession[3].title = "Kinésithérapeute"
        profession[3].typeProfession = typeProfessions[1]
        profession[4].title = "Ortophoniste"
        profession[4].typeProfession = typeProfessions[1]
        profession[5].title = "Ergothérapeute"
        profession[5].typeProfession = typeProfessions[2]
        profession[6].title = "Psychomotricien"
        profession[6].typeProfession = typeProfessions[2]
        profession[7].title = "Assistant Service Social"
        profession[7].typeProfession = typeProfessions[3]
        profession[8].title = "Personnels transport sanitaire"
        profession[8].typeProfession = typeProfessions[3]
        return profession
    }
    
}
