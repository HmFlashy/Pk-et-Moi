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
    
    public static let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}
