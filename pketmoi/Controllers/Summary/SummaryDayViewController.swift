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
    
    var valuesBis: [BeState]?
    let values: [[String]] = [["8h","OFF"],["9h","ON"],["10h","ON"],["11h","ON"],["12h","OFF"],["13h","ON"],["14h","Dyskynésie"],["15h","ON"],["16h","ON"],["17h","ON"],["18h","ON"],["19h","ON"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayTableView.dataSource = self
        dayTableView.delegate = self
        //self.dateLabel.text = "Lundi 9 mars"
        //self.answerLabel.text = "La plupart des prises"
    }
    
    func setDay(day: Int){
        //self.dayLabel.text = self.day
        self.day = day
        guard let summaryDay = summary.appointment?.date else{return}
        let date = Calendar.current.date(byAdding: .day, value: -(5-day+1), to: summaryDay)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd MM"
        dateFormatter.locale = Locale(identifier: "fr_FR")
        self.dateLabel.text = dateFormatter.string(from: date!)
        for beState in (summary.beStates?.allObjects)! as! [BeState]{
            let beStateDate = dateFormatter.string(from: beState.date!)
            let summaryDate = dateFormatter.string(from: summaryDay)
            if beStateDate == summaryDate{
                valuesBis?.append(beState)
            }
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let values = valuesBis else { return 0 }
         return values.count
        //return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dayTableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as! SummaryDayTableViewCell
        guard let values = valuesBis else {return cell}
        let beState: BeState = values[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.locale = Locale(identifier: "fr_FR")
        cell.hourLabel.text = dateFormatter.string(from: beState.date!)
        cell.stateLabel.text = beState.state?.name
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
