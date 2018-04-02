//
//  RigorousAnswerExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 27/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension RigorousAnswer{
    static func createRigorousAnswer(date: Date, nbOversight: String?, summary: Summary, answer: Answer) -> RigorousAnswer {
        guard let newRigorousAnswer = NSEntityDescription.insertNewObject(forEntityName: "RigorousAnswer", into: CoreDataManager.context) as? RigorousAnswer else{
            print("RigorousAnswer does not exists in the database")
            fatalError()
        }
        newRigorousAnswer.date = date
        newRigorousAnswer.nbOversight = nbOversight
        newRigorousAnswer.summary = summary
        newRigorousAnswer.answer = answer
        
       CoreDataManager.save()
        return newRigorousAnswer
    }
}
