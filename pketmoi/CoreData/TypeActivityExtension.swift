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
    
    /// Create a typeActivity
    ///
    /// - Parameters:
    ///   - name: the name of the type of activity
    ///   - description: the description of the type of activity
    /// - Returns: an instance of the class TypeActivity with the given parameters
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
    
    /// Fill the database with some types of activity
    static func fillDatabase() -> [TypeActivity]{
        var typesActivity : [TypeActivity] = []
        typesActivity.append(TypeActivity.createTypeActivity(name: "Gymnastique", description: ""))
        _ = TypeActivity.createTypeActivity(name: "Natation", description: "")
        _ = TypeActivity.createTypeActivity(name: "Course", description: "")
        _ = TypeActivity.createTypeActivity(name: "Marche", description: "")
        return typesActivity
    }
}
