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
    static func createDrug(itemDescription: String?, date: Date, dose: String, typeDrug: TypeDrug) -> Drug {
        let newDrug = NSEntityDescription.insertNewObject(forEntityName: "Drug", into: CoreDataManager.context) as! Drug
        newDrug.itemDescription = itemDescription
        newDrug.date = date
        newDrug.dose = dose
        newDrug.typeDrug = typeDrug
        
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newDrug
    }
}