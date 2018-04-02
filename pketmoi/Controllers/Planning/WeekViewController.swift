//
//  WeekViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 24/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class WeekViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var weekTableView: UITableView!
    
    private var week: Int!
    
    private var drugPresenter: DrugPresenter = DrugPresenter()
    private var appointmentPresenter: AppointmentPresenter = AppointmentPresenter()
    private var activityPresenter: ActivityPresenter = ActivityPresenter()
    
    fileprivate var timeItemFetched: NSFetchedResultsController<TimeItem>!
    
    func getFirstDay(weekNumber:Int)->NSDate!{
        let Calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let dayComponent = NSDateComponents()
        dayComponent.weekOfYear = weekNumber
        dayComponent.year = Calendar.component(.year, from: Date())
        dayComponent.weekday = 3
        var date = Calendar.date(from: dayComponent as DateComponents)
        if(weekNumber == 1 && Calendar.components(.month, from: date!).month != 1){
            dayComponent.year = dayComponent.weekOfYear - 1
            date = Calendar.date(from: dayComponent as DateComponents)
        }
        return date! as NSDate
    }
    
    
    func predicateForWeekFromDate(date: NSDate) -> NSPredicate {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        calendar?.timeZone = TimeZone(abbreviation: "UTC")!
        var components = calendar!.components([.year, .month, .day, .hour, .minute, .second], from: date as Date)
        components.hour = 0
        components.minute = 0
        components.second = 0
        let startDate = calendar!.date(from: components)
        components.day = components.day! + 6
        components.hour = 23
        components.minute = 59
        components.second = 59
        let endDate = calendar!.date(from: components)
        return NSPredicate(format: "date >= %@ AND date =< %@", argumentArray: [startDate!, endDate!])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if weekLabel.text == nil {
            weekLabel.text = ""
        }
        weekTableView.delegate = self
        weekTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setWeek(number: Int){
        self.week = number
        let date: Date = Date()
        var dateComponent: DateComponents = DateComponents()
        dateComponent.year = Calendar.current.component(.year, from: date)
        dateComponent.weekday = 2
        dateComponent.weekOfYear = number
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        let lundi = Calendar.current.date(from: dateComponent)
        let lundiString = dateFormatter.string(from: lundi!)
        dateComponent.weekday = 1
        dateComponent.weekOfYear = number + 1
        let dimanche = Calendar.current.date(from: dateComponent)
        let dimancheString = dateFormatter.string(from: dimanche!)
        let text: String! = lundiString + " au " + dimancheString
        self.weekLabel.text = text
        let request: NSFetchRequest<TimeItem> = TimeItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(TimeItem.date), ascending: true)]
        request.predicate = predicateForWeekFromDate(date: getFirstDay(weekNumber: self.week))
        timeItemFetched = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        timeItemFetched!.delegate = self
        do {
            try timeItemFetched.performFetch()
        } catch {
            print("error performing fetched for time items")
        }
        self.weekTableView.reloadData()
        
    }
    
    func getWeek() -> Int {
        return self.week!
    }
    
    // MARK: - WeekTableView
    private let sections = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]
    private var rawForSection: [Int] = [0, 0, 0, 0, 0, 0, 0]
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let timeItems = self.timeItemFetched.fetchedObjects else {
            return 0
        }
        var nbItems = 0
        for timeItem in timeItems {
            let weekday = Calendar.current.component(.weekday, from: timeItem.date!)
            if(weekday == ((section + 1) % 7) + 1){
                nbItems += 1
            }
        }
        rawForSection[section] = nbItems
        return nbItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let timeItems = self.timeItemFetched.fetchedObjects else {
            return UITableViewCell()
        }
        var cell = UITableViewCell()
        var index: Int = indexPath.row
        if(indexPath.section > 0){
            for nb in 0...indexPath.section - 1 {
                index += rawForSection[nb]
            }
        }
        if(timeItems[index].isKind(of: Activity.self)){
            let activity: Activity = timeItems[index] as! Activity
            cell = weekTableView.dequeueReusableCell(withIdentifier: "ActivityTableViewCell", for: indexPath) as! ActivityTableViewCell
            cell = activityPresenter.configureTableViewCell(forTableViewCell: cell, activity: activity)!
        } else if(timeItems[index].isKind(of: Drug.self)){
            let drug: Drug = timeItems[index] as! Drug
            cell = weekTableView.dequeueReusableCell(withIdentifier: "DrugTableViewCell", for: indexPath) as! DrugTableViewCell
            cell = drugPresenter.configureTableViewCell(forTableViewCell: cell, drug: drug)!
        } else if(timeItems[index].isKind(of: Appointment.self)){
            let appointment: Appointment = timeItems[index] as! Appointment
            cell = weekTableView.dequeueReusableCell(withIdentifier: "AppointmentTableViewCell", for: indexPath) as! AppointmentTableViewCell
            cell = appointmentPresenter.configureTableViewCell(forTableViewCell: cell, appointment: appointment)!
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let event = timeItemFetched.object(at: indexPath)
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: - NSFetchResultController delegate protocol
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                self.weekTableView.insertRows(at: [indexPath], with: .fade)
                self.weekTableView.reloadData()
            }
            break
        case .delete:
            if let indexPath = indexPath {
                self.weekTableView.deleteRows(at: [indexPath], with: .automatic)
                self.weekTableView.reloadData()
            }
        default:
            break
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.weekTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.weekTableView.endUpdates()
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
