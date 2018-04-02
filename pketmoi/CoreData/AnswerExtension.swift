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
        guard let newAnswer = NSEntityDescription.insertNewObject(forEntityName: "Answer", into: CoreDataManager.context) as? Answer else{
            print("Answer does not exists in the database")
            fatalError()
        }
        newAnswer.name = name
        
        CoreDataManager.save()
        return newAnswer
    }
    
    static func fillDatabase(){
        _ = Answer.createAnswer(name: "Toutes les prises")
        _ = Answer.createAnswer(name: "La plupart des prises")
        _ = Answer.createAnswer(name: "Quelques prises")
        _ = Answer.createAnswer(name: "Aucune des prises")
        _ = Answer.createAnswer(name: "J'ai oublié x prises")
    }
}
