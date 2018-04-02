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
    
    fileprivate lazy var summaryFetched: NSFetchedResultsController<Summary> = {
        let request: NSFetchRequest<Summary> = Summary.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Summary.appointment.date), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    
    // Adding a summary manually
    fileprivate lazy var stateFetched: NSFetchedResultsController<State> = {
        let request: NSFetchRequest<State> = State.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(State.name), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }()
    
    fileprivate lazy var appointmentFetched: NSFetchedResultsController<Appointment> = {
        let request: NSFetchRequest<Appointment> = Appointment.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Appointment.date), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }()
    
    fileprivate lazy var answerFetched: NSFetchedResultsController<Answer> = {
        let request: NSFetchRequest<Answer> = Answer.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Answer.name), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            try stateFetched.performFetch()
            try appointmentFetched.performFetch()
            try answerFetched.performFetch()
        }catch {
            print("Unable to perform fetch")
        }
        
        let stateDyski = stateFetched.object(at: IndexPath(row: 0, section: 0))
        let stateOff = stateFetched.object(at: IndexPath(row: 1, section: 0))
        let stateOn = stateFetched.object(at: IndexPath(row: 2, section: 0))
        
        do{
            try summaryFetched.performFetch()
        } catch {
            print("Unable to perfom Summary fetch")
        }

        print("creating summary")
        // Creating summary
        let appointment = appointmentFetched.object(at: IndexPath(row: 0, section: 0))
        print(appointment)
        let date = appointment.date!
        var startDate = Calendar.current.date(byAdding: .day, value: -5, to: date)
        let endDate = Calendar.current.date(byAdding: .day, value: -1, to: date)
        let summary = Summary.createSummary(askingInterval: "1", endDate: endDate!, startDate: startDate!, appointment: appointment)
        //var endDate = summary.endDate
       // var startDate = summary.startDate
        
        
        print("creating rigorous answers")
        // Creating rigorousAnswers
        let answer = answerFetched.object(at: IndexPath(row: 0, section: 0))
        let answer2 = answerFetched.object(at: IndexPath(row: 1, section: 0))
        let rigorousAnswer = RigorousAnswer.createRigorousAnswer(date: startDate!, nbOversight: "0", summary: summary, answer: answer)
        print(rigorousAnswer)
        let startDatePlus = Calendar.current.date(byAdding: .day, value: 1, to: startDate!)
        let rigorousAnswer2 = RigorousAnswer.createRigorousAnswer(date: startDatePlus!, nbOversight: "0", summary: summary, answer: answer2)
        print(rigorousAnswer2)
        
        // Creating BeStates for the first day
        var gregorian = Calendar(identifier: .gregorian)
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute], from: startDate!)
        components.hour = 8
        components.minute = 0
        var startDateState = gregorian.date(from: components)!
        var beState: BeState?
        for _ in 1...10 {
            beState = BeState.createBeState(date: startDateState, state: stateOn, summary: summary)
            print(beState!)
            startDateState = Calendar.current.date(byAdding: .hour, value: 1, to: startDateState)!
        }
        
        // Creating BeStates for the second day
        gregorian = Calendar(identifier: .gregorian)
        startDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate!)
        components = gregorian.dateComponents([.year, .month, .day, .hour, .minute], from: startDate!)
        components.hour = 8
        components.minute = 0
        startDateState = gregorian.date(from: components)!
        
        for _ in 1...10 {
            beState = BeState.createBeState(date: startDateState, state: stateDyski, summary: summary)
            print(beState!)
            startDateState = Calendar.current.date(byAdding: .hour, value: 1, to: startDateState)!
        }
        
        summaryTableView.dataSource = self
        summaryTableView.delegate = self
    }
    
    func refreshFetched(){
        do{
            try summaryFetched.performFetch()
        } catch {
            print("Unable to perfom Summary fetch")
        }
        self.summaryTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let summaries = summaryFetched.fetchedObjects else { return 0 }
        return summaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = summaryTableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as! SummaryTableViewCell
        let summary: Summary = summaryFetched.object(at: indexPath)
        self.summaryPresenter.configureCell(forCell: cell, summary: summary, row: indexPath.row)
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
    
    // MARK: - NSFetchResultController delegate protocol -
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

    // MARK: - Navigation -

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSummarySegue"{
            if let indexPath = summaryTableView.indexPathForSelectedRow {
                let vc = segue.destination as! ShowSummaryViewController
                vc.summary = self.summaryFetched.object(at: indexPath)
            }
        }
    }
}
