//
//  TypeDrugExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 19/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension TypeDrug{
    
    /// Create a type of drug
    ///
    /// - Parameters:
    ///   - name: the name of the type of drug
    ///   - minimalDose: the minimal dose of the type of drug
    ///   - maximalDose: the maximal dose of the type of drug
    ///   - minimalIntervalDose: the minimal interval between two doses of the type of drug
    ///   - maximalFrequency: the maximal frequency of the type of drug
    ///   - url: an url to have more informations about the type of drug
    ///   - drugDescription: the description of the type of drug
    /// - Returns: an instance of the class TypeDrug with the given parameters
    static func createTypeDrug(name: String, minimalDose: String?, maximalDose: String?, minimalIntervalDose: String?, maximalFrequency: String?, url: String?, drugDescription: String?) -> TypeDrug {
        guard let newTypeDrug = NSEntityDescription.insertNewObject(forEntityName: "TypeDrug", into: CoreDataManager.context) as? TypeDrug else{
            print("TypeDrug does not exists in the database")
            fatalError()
        }
        newTypeDrug.name = name
        newTypeDrug.minimalDose = minimalDose
        newTypeDrug.maximalDose = maximalDose
        newTypeDrug.minimalIntervalDose = minimalIntervalDose
        newTypeDrug.maximalFrequency = maximalFrequency
        newTypeDrug.url = url
        newTypeDrug.drugDescription = drugDescription
        
        CoreDataManager.save()
        return newTypeDrug
    }
    
    /// Get a typeDrug
    ///
    /// - Parameter forName: the name of the type of drug
    /// - Returns: an instance of the class TypeDrug with the given name
    static func getTypeDrug(forName: String) -> TypeDrug? {
        let typeDrugFetched: NSFetchRequest<TypeDrug> = TypeDrug.fetchRequest()
        typeDrugFetched.predicate = NSPredicate(format: "name == %@", forName)
        typeDrugFetched.sortDescriptors = [NSSortDescriptor(key:#keyPath(TypeDrug.name), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: typeDrugFetched, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultController.performFetch()
        } catch {
            return nil
        }
        return fetchedResultController.object(at: IndexPath(row: 0, section: 0))
    }
    
    /// Fill the database with some types of drug
    static func fillDatabase(){
        _ = TypeDrug.createTypeDrug(name: "Doliprane", minimalDose: "1", maximalDose: "1", minimalIntervalDose: "4", maximalFrequency: "2", url: "http://base-donnees-publique.medicaments.gouv.fr/affichageDoc.php?typedoc=N&specid=69309629", drugDescription: "Paracétamol")
        _ = TypeDrug.createTypeDrug(name: "Levodopa", minimalDose: "400", maximalDose: "1600", minimalIntervalDose: "4", maximalFrequency: "3", url: "http://base-donnees-publique.medicaments.gouv.fr/affichageDoc.php?specid=64573354&typedoc=R", drugDescription: "Comprimé à libération prolongée")
    }
}
