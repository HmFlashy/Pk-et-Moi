//
//  SelectDaysViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 15/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class SelectDaysViewController: UIViewController {
    
    @IBOutlet weak var MondaySwitch: UISwitch!
    @IBOutlet weak var TuesdaySwitch: UISwitch!
    @IBOutlet weak var WednesdaySwitch: UISwitch!
    @IBOutlet weak var ThursdaySwitch: UISwitch!
    @IBOutlet weak var FridaySwitch: UISwitch!
    @IBOutlet weak var SaturdaySwitch: UISwitch!
    @IBOutlet weak var SundaySwitch: UISwitch!
    var startDate: Date!
    var endDate: Date!
    var duration: Date!
    var startTime: Date!
    var HoursInterval: String!
    var typeActivity: TypeActivity!
    var descriptionActivity: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func AddActivities(_ sender: Any) {
        var days: [String]=[]
        if MondaySwitch.isOn{
            days.append("lundi")
        }
        if TuesdaySwitch.isOn{
            days.append("mardi")
        }
        if WednesdaySwitch.isOn{
            days.append("mercredi")
        }
        if ThursdaySwitch.isOn{
            days.append("jeudi")
        }
        if FridaySwitch.isOn{
            days.append("vendredi")
        }
        if SaturdaySwitch.isOn{
            days.append("samedi")
        }
        if SundaySwitch.isOn{
            days.append("dimanche")
        }
        let hour = Calendar.current.component(.hour, from: startTime)
        let min = Calendar.current.component(.minute, from: startTime)
        let durationFormatter = DateFormatter()
        durationFormatter.dateFormat = "HH:mm"
        let durationString = durationFormatter.string(from: duration)
        
        // Deletion of the seconds
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "fr_FR")
        guard var tomorrow = dateFormatter.date(from: dateFormatter.string(from: startDate)) else{return}
        
        // Adding the startTime to the startDate
        let gregorian = Calendar(identifier: .gregorian)
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute], from: tomorrow)
        components.hour = hour
        components.minute = min
        tomorrow = gregorian.date(from: components)!
        tomorrow = Calendar.current.date(byAdding: .hour, value: 1, to: tomorrow)!
        print(tomorrow)
        
        // Adding the startTime to the endDate
        components = gregorian.dateComponents([.year, .month, .day, .hour, .minute], from: endDate)
        components.hour = hour
        components.minute = min
        endDate = gregorian.date(from: components)!
        endDate = Calendar.current.date(byAdding: .hour, value: 1, to: endDate)!
        print(endDate)
        while tomorrow.compare(endDate).rawValue<1 {
            // Getting the day in letter
            dateFormatter.dateFormat  = "EEEE"
            let dayInWeek = dateFormatter.string(from: tomorrow)
            print(dayInWeek)
            if days.contains(dayInWeek){
                print(tomorrow)
                print(Activity.createActivity(itemDescription: descriptionActivity, date: tomorrow, duration: durationString, typeActivity: typeActivity))
            }
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
