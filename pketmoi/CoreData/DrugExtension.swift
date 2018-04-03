//
//  DrugExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 20/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension Drug{
    
    /// Create a drug
    ///
    /// - Parameters:
    ///   - itemDescription: the description of the drug
    ///   - date: the date where the drug should be taken
    ///   - dose: the dose to take
    ///   - typeDrug: the type of drug of this drug
    /// - Returns: an instance of the class Drug with the given parameters
    static func createDrug(itemDescription: String?, date: Date, dose: String, typeDrug: TypeDrug) -> Drug {
        guard let newDrug = NSEntityDescription.insertNewObject(forEntityName: "Drug", into: CoreDataManager.context) as? Drug else{
            print("Drug does not exists in the database")
            fatalError()
        }
        newDrug.itemDescription = itemDescription
        newDrug.date = date
        newDrug.dose = dose
        newDrug.typeDrug = typeDrug
        
        CoreDataManager.save()
        return newDrug
    }
}
