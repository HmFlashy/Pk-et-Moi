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
    static func createNeurologistQuestion(name: String, number: Int16) -> NeurologistQuestion {
        let newNeurologistQuestion = NSEntityDescription.insertNewObject(forEntityName: "NeurologistQuestion", into: CoreDataManager.context) as! NeurologistQuestion
        newNeurologistQuestion.name = name
        newNeurologistQuestion.number = number
        
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newNeurologistQuestion
    }
}
