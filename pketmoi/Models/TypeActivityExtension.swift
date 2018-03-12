//
//  TypeActivityExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 11/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

extension TypeActivity {
    
    static func createActivity(name: String, description: String) -> TypeActivity {
        let newTypeActivity = NSEntityDescription.insertNewObject(forEntityName: "TypeActivity", into: CoreDataManager.context) as! TypeActivity
        newTypeActivity.name = name
        newTypeActivity.descriptionActivity = description
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newTypeActivity
    }
}

