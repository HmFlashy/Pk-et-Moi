//
//  ActivityController.swift
//  pketmoi
//
//  Created by Loris Zirah on 09/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class ActivityController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate{
    
    @IBOutlet weak var activityTableView: UITableView!
    @IBOutlet weak var buttonAddActivity: UIButton!
    
    fileprivate lazy var activityFetched: NSFetchedResultsController<Activity> = {
        let request: NSFetchRequest<Activity> = Activity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Activity.name), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try self.activityFetched.performFetch()
        } catch {
            print("Problem")
        }
        buttonAddActivity.layer.cornerRadius = 8
    }
    
    // MARK: - UITableViewDataSource required protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let activities = activityFetched.fetchedObjects else { return 0 }
        return activities.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = activityTableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
        activityPresenter.configureCell(forCell: cell, event: activityFetched.object(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let activity = activityFetched.object(at: indexPath)
            CoreDataManager.context.delete(activity)
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
                self.activityTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                self.activityTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.activityTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.activityTableView.endUpdates()
    }
}
