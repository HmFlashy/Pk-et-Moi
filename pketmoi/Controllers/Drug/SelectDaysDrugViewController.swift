//
//  SelectDaysDrugViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 20/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class SelectDaysDrugViewController: UIViewController {

    @IBOutlet weak var MondaySwitch: UISwitch!
    @IBOutlet weak var TuesdaySwitch: UISwitch!
    @IBOutlet weak var WednesdaySwitch: UISwitch!
    @IBOutlet weak var ThursdaySwitch: UISwitch!
    @IBOutlet weak var FridaySwitch: UISwitch!
    @IBOutlet weak var SaturdaySwitch: UISwitch!
    @IBOutlet weak var SundaySwitch: UISwitch!
    
    var startDate: Date!
    var endDate: Date!
    var typeDrug: TypeDrug!
    var drugDescription: String?
    var drugDose: String!
    var startHour: Date!
    var frequency: String!
    var interval: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func AddDrugs(_ sender: Any) {
        var days: [String]=[]
        if MondaySwitch.isOn{
            days.append("lundi")
            days.append("Monday")
        }
        if TuesdaySwitch.isOn{
            days.append("mardi")
            days.append("Tuesday")
        }
        if WednesdaySwitch.isOn{
            days.append("mercredi")
            days.append("Wednesday")
        }
        if ThursdaySwitch.isOn{
            days.append("jeudi")
            days.append("Thursday")
        }
        if FridaySwitch.isOn{
            days.append("vendredi")
            days.append("Friday")
        }
        if SaturdaySwitch.isOn{
            days.append("samedi")
            days.append("Saturday")
        }
        if SundaySwitch.isOn{
            days.append("dimanche")
            days.append("Sunday")
        }
        // Deletion of the seconds
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard var tomorrow = dateFormatter.date(from: dateFormatter.string(from: startDate)) else{return}
        guard let endDate = dateFormatter.date(from: dateFormatter.string(from: self.endDate)) else{return}
        
        // Shaping the variables
        let intFrequency = Int(frequency)!
        print(intFrequency)
        let hourDep = Calendar.current.component(.hour, from: startHour)
        print("hour depart" + String(hourDep))
        let minDep = Calendar.current.component(.minute, from: startHour)
        print("min depart" + String(minDep))
        let hourInterval = Calendar.current.component(.hour, from: interval)
        print("hour interval" + String(hourInterval))
        let minInterval = Calendar.current.component(.minute, from: interval)
        print("min interval" + String(minInterval))
        print("date depart")
        print(tomorrow)
        while tomorrow.compare(endDate).rawValue<1 {
            print("jour incrémenté")
            print(tomorrow)
            // Recuperation of the day in letter
            dateFormatter.dateFormat  = "EEEE"
            let dayInWeek = dateFormatter.string(from: tomorrow)
            if days.contains(dayInWeek){
                // Adding the startDate to the date
                let gregorian = Calendar(identifier: .gregorian)
                var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute], from: tomorrow)
                components.hour = hourDep
                components.minute = minDep
                var tomorrowHour = gregorian.date(from: components)!
                print("date avec date début")
                print(tomorrowHour)
                for _ in 1...intFrequency{
                    print("date avec heure incrémenté")
                    print(tomorrowHour)
                    print(Drug.createDrug(itemDescription: drugDescription, date: tomorrowHour, dose: drugDose, typeDrug: typeDrug))
                    // Addind the interval to the date
                    tomorrowHour = Calendar.current.date(byAdding: .hour, value: hourInterval, to: tomorrowHour)!
                    tomorrowHour = Calendar.current.date(byAdding: .minute, value: minInterval, to: tomorrowHour)!
                }
            }
            // Adding a day
            tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: tomorrow)!
        }
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
