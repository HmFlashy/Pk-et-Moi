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
    
    /// Get a state
    ///
    /// - Parameter forName: the name of the state
    /// - Returns: an instance of the class State with the given name
    static func getState(forName: String) -> State? {
        let stateFetched: NSFetchRequest<State> = State.fetchRequest()
        stateFetched.predicate = NSPredicate(format: "name == %@", forName)
        stateFetched.sortDescriptors = [NSSortDescriptor(key:#keyPath(State.name), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: stateFetched, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultController.performFetch()
        } catch {
            return nil
        }
        return fetchedResultController.object(at: IndexPath(row: 0, section: 0))
    }
    
    
    /// Fill the database with some states
    static func fillDatabase(){
        _ = State.createState(name: "DYSKINESIES")
        _ = State.createState(name: "ON")
        _ = State.createState(name: "OFF")
    }
}
