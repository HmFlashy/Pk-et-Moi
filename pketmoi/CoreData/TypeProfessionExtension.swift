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
    
    /// Create a type of profression
    ///
    /// - Parameter title: the title of the type of the profression
    /// - Returns: an instance of the class TypeProfession with the given parameters
    static func createTypeProfession(title: String) -> TypeProfession{
        guard let newTypeProfession = NSEntityDescription.insertNewObject(forEntityName: "TypeProfession", into: CoreDataManager.context) as? TypeProfession else{
            print("TypeProfession does not exists in the database")
            fatalError()
        }
        newTypeProfession.title = title
        
        CoreDataManager.save()
        return newTypeProfession
    }
    
    /// Fill the database with some types of profession
    ///
    /// - Returns: an array with all the types of profression that have been added to the database
    static func fillDatabase() -> [TypeProfession]{
        var typeProfessions: [TypeProfession] = []
        typeProfessions.append(TypeProfession.createTypeProfession(title: "Medicaux"))
        typeProfessions.append(TypeProfession.createTypeProfession(title: "Para-Médicaux"))
        typeProfessions.append(TypeProfession.createTypeProfession(title: "Autres Para-Médicaux"))
        typeProfessions.append(TypeProfession.createTypeProfession(title: "Autres"))
        return typeProfessions
    }
}
