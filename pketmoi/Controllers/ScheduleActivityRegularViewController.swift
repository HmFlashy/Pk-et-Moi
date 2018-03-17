//
//  ScheduleActivityRegularViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 13/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class ScheduleActivityRegularViewController: UIViewController {
    var typeActivity: TypeActivity?
    
    @IBOutlet weak var dateErrorMessage: UILabel!
    @IBOutlet weak var durationErrorMessage: UILabel!
    @IBOutlet weak var intervalErrorMessage: UILabel!
    @IBOutlet weak var StartDatePicker: UIDatePicker!
    @IBOutlet weak var EndDatePicker: UIDatePicker!
    @IBOutlet weak var Duration: UITextField!
    @IBOutlet weak var HourInterval: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        dateErrorMessage.text = ""
        durationErrorMessage.text = ""
        intervalErrorMessage.text = ""
        guard StartDatePicker.date.compare(EndDatePicker.date).rawValue<1 else{
            self.dateErrorMessage.text = "La date de fin doit être supérieure à la date de début"
            return false
        }
        guard Duration.hasText else{
            self.durationErrorMessage.text = "La durée doit être renseignée"
            return false}
        guard let durationInt = Int(Duration.text!) else{
            self.durationErrorMessage.text = "La durée doit être un entier"
            return false
        }
        guard HourInterval.hasText else{
            self.intervalErrorMessage.text = "L'intervalle heure doit être mentionnée"
            return false
        }
        guard let hourIntervalInt = Int(HourInterval.text!) else{
            self.intervalErrorMessage.text = "L'intervalle doit être un entier"
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "selectDays"){
            let selectDaysViewController = segue.destination as! SelectDaysViewController
            selectDaysViewController.startDate = StartDatePicker.date
            selectDaysViewController.endDate = EndDatePicker.date
            selectDaysViewController.duration = Duration.text!
            selectDaysViewController.duration = HourInterval.text!
            selectDaysViewController.typeActivity = typeActivity
        }
    }
}
