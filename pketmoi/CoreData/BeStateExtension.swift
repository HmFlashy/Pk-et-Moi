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
    static func createBeState(date: Date?, state: State, summary: Summary) -> BeState {
        let newBeState = NSEntityDescription.insertNewObject(forEntityName: "BeState", into: CoreDataManager.context) as! BeState
        newBeState.date = date
        newBeState.state = state
        newBeState.summary = summary
        
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newBeState
    }
}
