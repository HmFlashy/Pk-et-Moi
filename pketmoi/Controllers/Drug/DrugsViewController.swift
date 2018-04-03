//
//  DrugsViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 18/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class DrugsViewController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var typeDrugTableView: UITableView!
    
    let typeDrugPresenter = TypeDrugPresenter()
    
    fileprivate lazy var typeDrugFetched: NSFetchedResultsController<TypeDrug> = {
        let request: NSFetchRequest<TypeDrug> = TypeDrug.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(TypeDrug.name), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    
    override func viewDidLoad() {
        typeDrugTableView.delegate = self
        typeDrugTableView.dataSource = self
        super.viewDidLoad()
        do {
            try self.typeDrugFetched.performFetch()
        } catch {
            print("")
        }
    }
    
    // MARK: - TableView DataSource protocol -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let typeDrugs = typeDrugFetched.fetchedObjects else { return 0 }
        return typeDrugs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = typeDrugTableView.dequeueReusableCell(withIdentifier: "typeDrugCell", for: indexPath) as! TypeDrugTableViewCell
        typeDrugPresenter.configureCell(forCell: cell, typeDrug: typeDrugFetched.object(at: indexPath), indexPath: indexPath)
        return cell
    }
    
    // MARK: - TableView delegate protocol -
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let event = typeDrugFetched.object(at: indexPath)
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
                self.typeDrugTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                self.typeDrugTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.typeDrugTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.typeDrugTableView.endUpdates()
    }

    // MARK: - Navigation -
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTypeDrug"{
            if let indexPath = self.typeDrugTableView.indexPathForSelectedRow{
                let destinationVC = segue.destination as! ShowTypeDrugViewController
                destinationVC.typeDrug = self.typeDrugFetched.object(at: indexPath)
                self.typeDrugTableView.deselectRow(at: indexPath, animated: true)
            }
        }
        else if segue.identifier == "scheduleDrug"{
            if let button = sender as? UIButton{
                let indexPath = IndexPath(row: button.tag, section: 0)
                let destinationVC = segue.destination as! ScheduleDrugViewController
                destinationVC.typeDrug = self.typeDrugFetched.object(at: indexPath)
                self.typeDrugTableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}
