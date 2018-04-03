//
//  CoreDataManager.swift
//  pketmoi
//
//  Created by Hugo Maitre on 03/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import CoreData
import UIKit

class CoreDataManager {
    
    /// The current context of the application
    public static let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    /// Save the context of the application
    public static func save(){
        do{
            try CoreDataManager.context.save()
        }
        catch let err as NSError{
            print(err)
            print("error while performing the save")
        }
    }
}
