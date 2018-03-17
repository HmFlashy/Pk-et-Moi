//
//  PersonExtension.swift
//  pketmoi
//
//  Created by Hugo Maitre on 13/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import CoreData
import Foundation

extension Person {
    static func getNewPersonDAO() -> Person? {
        guard let entity = NSEntityDescription.entity(forEntityName: "Person", in: CoreDataManager.context) else {
            return nil
        }
        return Person(entity: entity, insertInto: CoreDataManager.context)
    }
}
