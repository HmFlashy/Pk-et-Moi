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
    
    @IBAction func showPopup(_ sender: Any) {
        let popoverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addTypeActivitySb") as! TypeActivityController
        self.addChildViewController(popoverVC)
        popoverVC.view.frame = self.view.frame
        self.view.addSubview((popoverVC.view))
        popoverVC.didMove(toParentViewController: self)
    }
    
    
    /*@IBAction func showPopup(_ sender: Any) {
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundButton.alpha = 0.5
        })
    }
    
    @IBAction func closePopup(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0
        })
    }*/
    
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
        cell.typeActivityName.text = "salut"
            //typeActivityFetched.object(at: indexPath).name
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
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.typeActivityTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.typeActivityTableView.endUpdates()
    }
}
