//
//  NeurologistAnswerExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 01/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension NeurologistAnswer{
    
    /// Create a neurologistAnswer
    ///
    /// - Parameters:
    ///   - status: the status of the answer of the neurologist (true corresponding to Yes, false to No)
    ///   - comment: a comment
    ///   - summary: the summary linked to
    ///   - neurologistQuestion: the question of the neurologist related to this answer
    /// - Returns: an instance of the class NeurologistAnswer
    static func createNeurologistAnswer(status: Bool, comment: String?, summary: Summary, neurologistQuestion: NeurologistQuestion) -> NeurologistAnswer {
        guard let newNeurologistAnswer = NSEntityDescription.insertNewObject(forEntityName: "NeurologistAnswer", into: CoreDataManager.context) as? NeurologistAnswer else{
            print("NeurologistAnswer does not exists in the database")
            fatalError()
        }
        newNeurologistAnswer.status = status
        newNeurologistAnswer.comment = comment
        newNeurologistAnswer.summary = summary
        newNeurologistAnswer.neurologistQuestion = neurologistQuestion
        
        CoreDataManager.save()
        return newNeurologistAnswer
    }
}
