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
    
    fileprivate var timeItemFetched: NSFetchedResultsController<TimeItem>!
    
    func getFirstDay(weekNumber:Int)->NSDate!{
        let Calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let dayComponent = NSDateComponents()
        print(dayComponent.year)
        dayComponent.weekOfYear = weekNumber
        dayComponent.year = Calendar.component(.year, from: Date())
        dayComponent.weekday = 3
        var date = Calendar.date(from: dayComponent as DateComponents)
        print(date ?? "")
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
        let text: String! = "Semaine " + String(self.week)
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
    
    // Mark: - WeekTableView
    let sections = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]
    
    // Mark: - TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
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
            if(weekday == section + 1){
                nbItems += 1
            }
        }
        return nbItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let timeItems = self.timeItemFetched.fetchedObjects else {
            return UITableViewCell()
        }
        var cell = UITableViewCell()
        if(timeItems[indexPath.row].isKind(of: Activity.self)){
            var activity: Activity = timeItems[indexPath.row] as! Activity
            cell.backgroundColor = UIColor.brown
            var label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label.text = activity.typeActivity?.name
            cell.addSubview(label)
        } else if(timeItems[indexPath.row].isKind(of: Drug.self)){
            var drug: Drug = timeItems[indexPath.row] as! Drug
            cell.backgroundColor = UIColor.brown
            var label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label.text = drug.typeDrug?.name
            cell.addSubview(label)
            cell.backgroundColor = UIColor.green
        } else if(timeItems[indexPath.row].isKind(of: Appointment.self)){
            var appointment: Appointment = timeItems[indexPath.row] as! Appointment
            cell.backgroundColor = UIColor.brown
            var label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label.text = appointment.doctor?.profession?.title
            cell.addSubview(label)
            cell.backgroundColor = UIColor.blue
        }
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
