//
//  TypeEventTableViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 26/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class TypeEventTableViewController : UITableView, UITableViewDataSource, NSFetchedResultsControllerDelegate  {
    
    fileprivate var typeEventPresenter: TypeEventPresenter
    
    fileprivate lazy var typeEventFetched: NSFetchedResultsController<TypeEvent> = {
        let request: NSFetchRequest<TypeEvent> = TypeEvent.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(TypeEvent.name), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    
    required init?(coder aDecoder: NSCoder) {
        self.typeEventPresenter = TypeEventPresenter()
        super.init(coder: aDecoder)
        self.dataSource = self
        do {
            try self.typeEventFetched.performFetch()
        } catch {
            print("Problem")
        }
    }
    
    // MARK: - UITableViewDataSource required protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         guard let typeEvents = typeEventFetched.fetchedObjects else { return 0 }
        return typeEvents.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: "TypeEventCell", for: indexPath)
        typeEventPresenter.configureCell(forCell: cell, typeEvent: typeEventFetched.object(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
            case .delete:
                let typeEvent = typeEventFetched.object(at: indexPath)
                CoreDataManager.context.delete(typeEvent)
                do {
                    try CoreDataManager.context.save()
                } catch let error as NSError {
                    print("Error saving context after delete: \(error.localizedDescription)")
                }
                break
            default:break
        }
    }
    
    // MARK: - NSFetchResultController delegate protocol
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                self.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                self.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
        
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.endUpdates()
    }
    
    // MARK: - Action Handler
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        let typeEvent = self.typeEventFetched.object(at: indexPath)
        CoreDataManager.context.delete(typeEvent)
    }
    
}
