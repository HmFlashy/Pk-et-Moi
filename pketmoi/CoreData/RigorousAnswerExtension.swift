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
    
    /// Create a rigorousAnswer
    ///
    /// - Parameters:
    ///   - date: the date corresponding to the week of the answer
    ///   - nbOversight: the number of oversight that the patient did this week
    ///   - summary: the summary linked to this rigorous answer
    ///   - answer: the answer of the patient
    /// - Returns: an instance of the class RigorousAnswer with the given parameters
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
