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
    
    static func fillDatabase(){
        _ = TypeDrug.createTypeDrug(name: "Doliprane", minimalDose: "1", maximalDose: "1", minimalIntervalDose: "4", maximalFrequency: "2", url: "http://base-donnees-publique.medicaments.gouv.fr/affichageDoc.php?typedoc=N&specid=69309629", drugDescription: "Paracétamol")
        _ = TypeDrug.createTypeDrug(name: "Levodopa", minimalDose: "400", maximalDose: "1600", minimalIntervalDose: "4", maximalFrequency: "3", url: "http://base-donnees-publique.medicaments.gouv.fr/affichageDoc.php?specid=64573354&typedoc=R", drugDescription: "Comprimé à libération prolongée")
    }
}
