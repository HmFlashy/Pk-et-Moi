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
    static func createTypeDrug(name: String, minimalDose: String, maximalDose: String, minimalIntervalDose: String, maximalFrequency: String, url: String?, drugDescription: String?) -> TypeDrug {
        let newTypeDrug = NSEntityDescription.insertNewObject(forEntityName: "TypeDrug", into: CoreDataManager.context) as! TypeDrug
        newTypeDrug.name = name
        newTypeDrug.minimalDose = minimalDose
        newTypeDrug.maximalDose = maximalDose
        newTypeDrug.minimalIntervalDose = minimalIntervalDose
        newTypeDrug.maximalFrequency = maximalFrequency
        newTypeDrug.url = url
        newTypeDrug.drugDescription = drugDescription
        
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newTypeDrug
    }
}
