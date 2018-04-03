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
    
    /// Create an answer
    ///
    /// - Parameter name: the name of the answer
    /// - Returns: an instance of the class Answer with the given parameters
    static func createAnswer(name: String) -> Answer {
        guard let newAnswer = NSEntityDescription.insertNewObject(forEntityName: "Answer", into: CoreDataManager.context) as? Answer else{
            print("Answer does not exists in the database")
            fatalError()
        }
        newAnswer.name = name
        
        CoreDataManager.save()
        return newAnswer
    }
    
    /// Get answer
    ///
    /// - Parameter forName: the name of the answer
    /// - Returns: an instance of the class Answer with the given name
    static func getAnswer(forName: String) -> Answer? {
        let answerFetched: NSFetchRequest<Answer> = Answer.fetchRequest()
        answerFetched.predicate = NSPredicate(format: "name == %@", forName)
        answerFetched.sortDescriptors = [NSSortDescriptor(key:#keyPath(Answer.name), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: answerFetched, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultController.performFetch()
        } catch {
            return nil
        }
        return fetchedResultController.object(at: IndexPath(row: 0, section: 0))
    }
    
    
    /// Fill the database with some answers
    static func fillDatabase(){
        _ = Answer.createAnswer(name: "Toutes les prises")
        _ = Answer.createAnswer(name: "La plupart des prises")
        _ = Answer.createAnswer(name: "Quelques prises")
        _ = Answer.createAnswer(name: "Aucune des prises")
        _ = Answer.createAnswer(name: "J'ai oublié x prise(s)")
    }
}
