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

    @IBOutlet weak var typeActivityTableView: UITableView!

    fileprivate lazy var typeActivityFetched: NSFetchedResultsController<TypeActivity> = {
        let request: NSFetchRequest<TypeActivity> = TypeActivity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(TypeActivity.name), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeActivityTableView.dataSource = self
        typeActivityTableView.delegate = self
	
        do{
            try self.typeActivityFetched.performFetch()
        } catch {
            print("Problem")
        }
    }
    
    // MARK: - UITableViewDataSource required protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let typesActivities = typeActivityFetched.fetchedObjects else { return 0 }
        return typesActivities.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = typeActivityTableView.dequeueReusableCell(withIdentifier: "TypeActivityPlanifierCell", for: indexPath) as! TypeActivityTableViewCell
        cell.typeActivityName.text = typeActivityFetched.object(at: indexPath).name
        cell.button.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let typeActivity = typeActivityFetched.object(at: indexPath)
            CoreDataManager.context.delete(typeActivity)
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
                self.typeActivityTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                self.typeActivityTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.typeActivityTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.typeActivityTableView.endUpdates()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScheduleActivity" {
            if let button = sender as? UIButton{
                let indexPath = IndexPath(row: button.tag, section: 0)
                    let ScheduleActivityVC: ScheduleActivityViewController = segue.destination as! ScheduleActivityViewController
                    ScheduleActivityVC.typeActivity = self.typeActivityFetched.object(at: indexPath)
                    self.typeActivityTableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}
