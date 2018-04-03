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
    
    /// Create a state
    ///
    /// - Parameter name: the name of the state
    /// - Returns: an instance of the class State with the given paramaters
    static func createState(name: String) -> State {
        guard let newState = NSEntityDescription.insertNewObject(forEntityName: "State", into: CoreDataManager.context) as? State else{
            print("State does not exists in the database")
            fatalError()
        }
        newState.name = name
        
        CoreDataManager.save()
        return newState
    }
    
    /// Fill the database with some states
    static func fillDatabase(){
        _ = State.createState(name: "DYSKINESIES")
        _ = State.createState(name: "ON")
        _ = State.createState(name: "OFF")
    }
}
