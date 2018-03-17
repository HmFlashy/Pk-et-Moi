//
//  TypeProfessionExtension.swift
//  pketmoi
//
//  Created by Hugo Maitre on 13/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension TypeProfession {
    
    static func getNewTypeProfessionDAO() -> TypeProfession? {
        guard let entity = NSEntityDescription.entity(forEntityName: "TypeProfession", in: CoreDataManager.context) else {
            return nil
        }
        return TypeProfession(entity: entity, insertInto: CoreDataManager.context)
    }
    
    static func fillDatabase() -> TypeProfession? {
        guard let entity = NSEntityDescription.entity(forEntityName: "TypeProfession", in: CoreDataManager.context) else {
            print("TypeProfession does not exist in database")
            fatalError()
        }
        let typeProfession = TypeProfession(entity: entity, insertInto: CoreDataManager.context)
        typeProfession.title = "Test"
        return typeProfession
    }
}
