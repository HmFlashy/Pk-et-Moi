//
//  NeurologistQuestionExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 01/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension NeurologistQuestion{
    
    /// Create a neurologistQuestion
    ///
    /// - Parameters:
    ///   - name: the name of the question of the neurologist
    ///   - number: the number corresponding
    /// - Returns: an instance of the class NeurologistQuestion with the given parameters
    static func createNeurologistQuestion(name: String, number: Int16) -> NeurologistQuestion {
        guard let newNeurologistQuestion = NSEntityDescription.insertNewObject(forEntityName: "NeurologistQuestion", into: CoreDataManager.context) as? NeurologistQuestion else{
            print("NeurologistQuestion does not exists in the database")
            fatalError()
        }
        newNeurologistQuestion.name = name
        newNeurologistQuestion.number = number
        
        CoreDataManager.save()
        return newNeurologistQuestion
    }
    
    static func fillDatabase(){
        _ = NeurologistQuestion.createNeurologistQuestion(name: "Akinésies de début de dose", number: 1)
        _ = NeurologistQuestion.createNeurologistQuestion(name: "Akinésies de fin de dose", number: 2)
        _ = NeurologistQuestion.createNeurologistQuestion(name: "Dystonie du gros orteil", number: 3)
        _ = NeurologistQuestion.createNeurologistQuestion(name: "Dyskinésies invalidantes", number: 4)
        _ = NeurologistQuestion.createNeurologistQuestion(name: "Effet On/Off", number: 5)
        _ = NeurologistQuestion.createNeurologistQuestion(name: "Fluctuations non motrices", number: 6)
        _ = NeurologistQuestion.createNeurologistQuestion(name: "Hallucinations", number: 7)
        _ = NeurologistQuestion.createNeurologistQuestion(name: "Freezing", number: 8)

    }
}
