//
//  SummaryDayViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 26/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class SummaryDayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    var summary: Summary!
    var day: Int!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var dayTableView: UITableView!
    @IBOutlet weak var dayLabel: UILabel!
    
    var beStates: [BeState] = []
    var beStatePresenter = BeStatePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view Did Load " + String(self.day))
        dayTableView.dataSource = self
        dayTableView.delegate = self
        self.dayLabel.text = "Jour " + String(self.day)
        guard let appointment = summary.appointment else{return}
        guard let summaryDay = appointment.date else{return}
        let date = Calendar.current.date(byAdding: .day, value: -(5-day+1), to: summaryDay)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd MMMM"
        dateFormatter.locale = Locale(identifier: "fr_FR")
        self.dateLabel.text = dateFormatter.string(from: date!)
        for beState in (summary.beStates?.allObjects)! as! [BeState]{
            let beStateDate = dateFormatter.string(from: beState.date!)
            let summaryDate = dateFormatter.string(from: date!)
            if beStateDate == summaryDate{
                beStates.append(beState)
            }
        }
        beStates = beStates.sorted(by: { $0.date! < $1.date!})
        let rigorousAnswers = (summary.rigorousAnswers)?.allObjects
        var i = 0
        var found = false
        while i<(rigorousAnswers?.count)! && !found {
            let rigorousAnswer = rigorousAnswers![i] as! RigorousAnswer
            if rigorousAnswer.date == date {
                found = true
                answerLabel.text = rigorousAnswer.answer?.name
            }
            i+=1
        }
    }
    
    func setDay(day: Int){
        self.day = day
    }
    
    // MARK: - TableView Data Source protocol - 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return beStates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dayTableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as! SummaryDayTableViewCell
        let beState: BeState = beStates[indexPath.row]
        beStatePresenter.configureCell(forCell: cell, beState: beState)
        return cell
    }
    
    // MARK: - NSFetchResultController delegate protocol -
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                self.dayTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            self.dayTableView.reloadData()
            break
        case .delete:
            if let indexPath = indexPath {
                self.dayTableView.deleteRows(at: [indexPath], with: .automatic)
            }
            break
        default:
            break
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.dayTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.dayTableView.endUpdates()
    }
    
    @IBAction func unwindToSummaryDayViewController(segue: UIStoryboardSegue) {
        self.dayTableView.reloadData()
    }

    // MARK: - Navigation -
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "addBeStateSegue"{
            let cell = sender as! SummaryDayTableViewCell
            if let stateName = cell.beState.state?.name{
                return true
            }
            else{
                if cell.beState.date! <= Date() {
                    return true
                }
                else{
                    return false
                }
            }
        }
        else{
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addBeStateSegue" {
            if let indexPath = self.dayTableView.indexPathForSelectedRow{
                let vc = segue.destination as! AddBeStateViewController
                vc.beState = beStates[indexPath.row]
            }
        }
    }
}
