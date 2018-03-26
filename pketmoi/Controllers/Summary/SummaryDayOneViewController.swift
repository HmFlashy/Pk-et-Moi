//
//  SummaryDayOneViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 26/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class SummaryDayOneViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    var summary: Summary!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var dayOneTableView: UITableView!
    
    let values: [[String]] = [["8h","OFF"],["9h","ON"],["10h","ON"],["11h","ON"],["12h","OFF"],["13h","ON"],["14h","Dyskynésie"],["15h","ON"],["16h","ON"],["17h","ON"],["18h","ON"],["19h","ON"]]
    
    fileprivate lazy var summaryDayOneFetched: NSFetchedResultsController<Summary> = {
        let request: NSFetchRequest<Summary> = Summary.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Summary.appointment.date), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayOneTableView.dataSource = self
        dayOneTableView.delegate = self
        self.dateLabel.text = "Lundi 9 mars"
        self.answerLabel.text = "La plupart des prises"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*guard let summaries = summaryFetched.fetchedObjects else { return 0 }
         return summaries.count*/
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dayOneTableView.dequeueReusableCell(withIdentifier: "DayOneCell", for: indexPath) as! SummaryDayOneTableViewCell
        //let summary: Summary = summaryFetched.object(at: indexPath)
        //self.summaryPresenter.configureCell(forCell: cell, summary: summary)
        cell.hourLabel.text = self.values[indexPath.row][0]
        cell.stateLabel.text = self.values[indexPath.row][1]
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
