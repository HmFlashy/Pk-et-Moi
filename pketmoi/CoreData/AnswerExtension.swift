//
//  AnswerExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 27/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension Answer{
    static func createAnswer(name: String) -> Answer {
        let newAnswer = NSEntityDescription.insertNewObject(forEntityName: "Answer", into: CoreDataManager.context) as! Answer
        newAnswer.name = name
        
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newAnswer
    }
}
