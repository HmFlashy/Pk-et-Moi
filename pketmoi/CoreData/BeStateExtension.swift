//
//  BeStateExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 27/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension BeState{
    
    /// Create a BeState
    ///
    /// - Parameters:
    ///   - date: the date where the state should be specified
    ///   - state: the state of the patient
    ///   - summary: the summary related
    /// - Returns: an instane of the class BeState related to the given parameters
    static func createBeState(date: Date, state: State?, summary: Summary) -> BeState {
        guard let newBeState = NSEntityDescription.insertNewObject(forEntityName: "BeState", into: CoreDataManager.context) as? BeState else{
            print("BeState does not exists in the database")
            fatalError()
        }
        newBeState.date = date
        newBeState.state = state
        newBeState.summary = summary
        
        CoreDataManager.save()
        return newBeState
    }
}
