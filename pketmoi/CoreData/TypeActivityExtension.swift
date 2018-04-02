//
//  TypeActivityExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 02/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension TypeActivity{
    
    static func createTypeActivity(name: String, description: String) -> TypeActivity {
        guard let newTypeActivity = NSEntityDescription.insertNewObject(forEntityName: "TypeActivity", into: CoreDataManager.context) as? TypeActivity else{
            print("TypeActivity does not exists in the database")
            fatalError()
        }
        newTypeActivity.name = name
        newTypeActivity.descriptionTypeActivity = description
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newTypeActivity
    }
    
    static func fillDatabase(){
        _ = TypeActivity.createTypeActivity(name: "Gymnastique", description: "")
        _ = TypeActivity.createTypeActivity(name: "Natation", description: "")
        _ = TypeActivity.createTypeActivity(name: "Course", description: "")
        _ = TypeActivity.createTypeActivity(name: "Marche", description: "")
    }
}
