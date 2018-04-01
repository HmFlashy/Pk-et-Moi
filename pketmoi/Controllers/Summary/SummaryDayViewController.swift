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
    
    var valuesBis: [BeState] = []
    
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
                valuesBis.append(beState)
            }
        }
        valuesBis = valuesBis.sorted(by: { $0.date! < $1.date!})
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return valuesBis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dayTableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as! SummaryDayTableViewCell
        guard valuesBis.count>0 else {return cell}
        let beState: BeState = valuesBis[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.locale = Locale(identifier: "fr_FR")
        cell.hourLabel.text = dateFormatter.string(from: beState.date!) + "h"
        guard let stateName = beState.state?.name else{return cell}
        cell.stateLabel.text = stateName
        switch stateName {
        case "ON":
            cell.stateLabel.backgroundColor = .green
            break
        case "OFF":
            cell.stateLabel.backgroundColor = .red
            break
        case "DYSKINESIES":
            cell.stateLabel.backgroundColor = .yellow
            break
        default:
            cell.stateLabel.backgroundColor = .white
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
