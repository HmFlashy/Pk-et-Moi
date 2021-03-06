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
    
    /// Get a profession
    ///
    /// - Parameter forTitle: the title of thes profession
    /// - Returns: an instance of the class Profession with the given title
    static func getProfession(forTitle: String) -> Profession? {
        let professionFetched: NSFetchRequest<Profession> = Profession.fetchRequest()
        professionFetched.predicate = NSPredicate(format: "title == %@", forTitle)
        professionFetched.sortDescriptors = [NSSortDescriptor(key:#keyPath(Profession.title), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: professionFetched, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultController.performFetch()
        } catch {
            return nil
        }
        return fetchedResultController.object(at: IndexPath(row: 0, section: 0))
    }
    
    /// Create a profession
    ///
    /// - Parameters:
    ///   - title: the title of the prossefion
    ///   - typeProfession: the type of the profession
    /// - Returns: the profession with the given parameters
    static func createProfession(title: String, typeProfession: TypeProfession) -> Profession{
        guard let newProfession = NSEntityDescription.insertNewObject(forEntityName: "Profession", into: CoreDataManager.context) as? Profession else{
            print("Profession does not exists in the database")
            fatalError()
        }
        newProfession.title = title
        newProfession.typeProfession = typeProfession
        
        CoreDataManager.save()
        return newProfession
    }
    
    /// Fill the database with some professions
    ///
    /// - Parameter typeProfessions: an array of typeProfession
    static func fillDatabase(typeProfessions: [TypeProfession]) {
        _ = Profession.createProfession(title: "Neurologue", typeProfession: typeProfessions[0])
        _ = Profession.createProfession(title: "Medecin Généraliste", typeProfession: typeProfessions[0])
        _ = Profession.createProfession(title: "Psychiatre", typeProfession: typeProfessions[0])
        _ = Profession.createProfession(title: "Kinésithérapeute", typeProfession: typeProfessions[1])
        _ = Profession.createProfession(title: "Ortophoniste", typeProfession: typeProfessions[1])
        _ = Profession.createProfession(title: "Ergothérapeute", typeProfession: typeProfessions[2])
        _ = Profession.createProfession(title: "Psychomotricien", typeProfession: typeProfessions[2])
        _ = Profession.createProfession(title: "Assistant Service Social", typeProfession: typeProfessions[3])
        _ = Profession.createProfession(title: "Personnels transport sanitaire", typeProfession: typeProfessions[3])
    }
}
