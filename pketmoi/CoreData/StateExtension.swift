//
//  StateExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 28/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension State{
    static func createState(name: String) -> State {
        let newState = NSEntityDescription.insertNewObject(forEntityName: "State", into: CoreDataManager.context) as! State
        newState.name = name
        
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        return newState
    }
}
