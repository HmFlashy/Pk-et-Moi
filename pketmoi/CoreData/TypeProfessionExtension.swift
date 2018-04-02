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
    
    static func createTypeProfession(title: String) -> TypeProfession{
        guard let newTypeProfession = NSEntityDescription.insertNewObject(forEntityName: "TypeProfession", into: CoreDataManager.context) as? TypeProfession else{
            print("TypeProfession does not exists in the database")
            fatalError()
        }
        newTypeProfession.title = title
        
        CoreDataManager.save()
        return newTypeProfession
    }
    
    static func fillDatabase(){
        _ = TypeProfession.createTypeProfession(title: "Medicaux")
        _ = TypeProfession.createTypeProfession(title: "Para-Médicaux")
        _ = TypeProfession.createTypeProfession(title: "Autres Para-Médicaux")
        _ = TypeProfession.createTypeProfession(title: "Autres")
    }
}
