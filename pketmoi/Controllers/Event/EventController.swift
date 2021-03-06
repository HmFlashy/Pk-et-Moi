//
//  EventController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 21/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class EventController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var buttonTriggerEvent: UIButton!
    @IBOutlet weak var buttonAddEvent: UIButton!
    
    @IBOutlet weak var eventTableView: UITableView!
    
    let segueShowEvent = "showEvent"
    
    let eventPresenter = EventPresenter()
    
    fileprivate lazy var eventFetched: NSFetchedResultsController<Event> = {
        let request: NSFetchRequest<Event> = Event.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Event.date), ascending: false)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.dataSource = self
        eventTableView.delegate = self
        do {
            try self.eventFetched.performFetch()
        } catch {
            print("Unable to perform event fetch")
        }
        buttonTriggerEvent.layer.cornerRadius = 8
        buttonAddEvent.layer.cornerRadius = 8
    }
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
    }
    
    // MARK: - UITableViewDataSource required protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let events = eventFetched.fetchedObjects else { return 0 }
        return events.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: EventTableViewCell! = eventTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        cell = eventPresenter.configureCell(forCell: cell, event: eventFetched.object(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let event = eventFetched.object(at: indexPath)
            CoreDataManager.context.delete(event)
            do {
                try CoreDataManager.context.save()
            } catch let error as NSError {
                print("Error saving context after delete: \(error.localizedDescription)")
            }
            break
        default:break
        }
    }
    
    // MARK: - NSFetchResultController delegate protocol -
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                self.eventTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                self.eventTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.eventTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.eventTableView.endUpdates()
    }
    
    // MARK: - Navigation -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueShowEvent{
            if let indexPath = self.eventTableView.indexPathForSelectedRow{
                let showEventViewController = segue.destination as! ShowEventViewController
                showEventViewController.event = self.eventFetched.object(at: indexPath)
                self.eventTableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}
