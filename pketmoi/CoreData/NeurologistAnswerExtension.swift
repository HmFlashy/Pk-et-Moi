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
    static func createNeurologistAnswer(status: Bool, comment: String?, summary: Summary, neurologistQuestion: NeurologistQuestion) -> NeurologistAnswer {
        let newNeurologistAnswer = NSEntityDescription.insertNewObject(forEntityName: "NeurologistAnswer", into: CoreDataManager.context) as! NeurologistAnswer
        newNeurologistAnswer.status = status
        newNeurologistAnswer.comment = comment
        newNeurologistAnswer.summary = summary
        newNeurologistAnswer.neurologistQuestion = neurologistQuestion
        
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newNeurologistAnswer
    }
}
