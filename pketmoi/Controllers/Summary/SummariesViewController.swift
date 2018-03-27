//
//  SummariesViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 23/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class SummariesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var summaryTableView: UITableView!
    let summaryPresenter = SummaryPresenter()
    let summary: [String] = ["2018-03-15","2018-01-12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try summaryFetched.performFetch()
        }catch {
            print("Unable to perfom Summary fetch")
        }
        summaryTableView.dataSource = self
        summaryTableView.delegate = self
    }
    
    fileprivate lazy var summaryFetched: NSFetchedResultsController<Summary> = {
        let request: NSFetchRequest<Summary> = Summary.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Summary.appointment.date), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*guard let summaries = summaryFetched.fetchedObjects else { return 0 }
        return summaries.count*/
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = summaryTableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as! SummaryTableViewCell
        //let summary: Summary = summaryFetched.object(at: indexPath)
       //self.summaryPresenter.configureCell(forCell: cell, summary: summary)
        cell.dateLabel.text = self.summary[indexPath.row]
        cell.nameLabel.text = "Synthèse " + String(indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let event = summaryFetched.object(at: indexPath)
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
    
    // MARK: - NSFetchResultController delegate protocol
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                self.summaryTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                self.summaryTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.summaryTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.summaryTableView.endUpdates()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSummarySegue"{
            if let indexPath = summaryTableView.indexPathForSelectedRow {
                let vc = segue.destination as! ShowSummaryViewController
                vc.date = summary[indexPath.row]
                //vc.summary = self.summaryFetched.object(at: indexPath)
            }
        }
    }
}
