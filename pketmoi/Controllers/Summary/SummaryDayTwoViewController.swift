//
//  SummaryDayTwoViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 26/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class SummaryDayTwoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var summary: Summary!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var dayTwoTableView: UITableView!
    
    let values: [[String]] = [["8h","ON"],["9h","ON"],["10h","ON"],["11h","ON"],["12h","ON"],["13h","ON"],["14h","ON"],["15h","ON"],["16h","ON"],["17h","ON"],["18h","ON"],["19h","Dyskynésie"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayTwoTableView.dataSource = self
        dayTwoTableView.delegate = self
        self.dateLabel.text = "Mardi 10 mars"
        self.answerLabel.text = "J'ai oublié 5 prises"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*guard let summaries = summaryFetched.fetchedObjects else { return 0 }
         return summaries.count*/
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dayTwoTableView.dequeueReusableCell(withIdentifier: "DayTwoCell", for: indexPath) as! SummaryDayTwoTableViewCell
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

