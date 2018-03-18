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
    var startDate: Date?
    var endDate: Date?
    var duration: String!
    var HoursInterval: String!
    var typeActivity: TypeActivity!
    var descriptionActivity: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func AddActivities(_ sender: Any) {
        var days: [String]=[]
        if MondaySwitch.isOn{
            days.append("Monday")
        }
        if TuesdaySwitch.isOn{
            days.append("Tuesday")
        }
        if WednesdaySwitch.isOn{
            days.append("Wednesday")
        }
        if ThursdaySwitch.isOn{
            days.append("Thursday")
        }
        if FridaySwitch.isOn{
            days.append("Friday")
        }
        if SaturdaySwitch.isOn{
            days.append("Saturday")
        }
        if SundaySwitch.isOn{
            days.append("Sunday")
        }
        var tomorrow: Date = startDate!
        while tomorrow.compare(endDate!).rawValue<0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat  = "EEEE"
            let dayInWeek = dateFormatter.string(from: tomorrow)
            if days.contains(dayInWeek){
                print(Activity.createActivity(itemDescription: descriptionActivity, date: tomorrow, duration: duration, typeActivity: typeActivity))
            }
            tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: tomorrow)!
        }
        // We add one more activity because the compare() is not displaying 0 when
        // the dates are equal but 1
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EEEE"
        let dayInWeek = dateFormatter.string(from: tomorrow)
        if days.contains(dayInWeek){
            print(Activity.createActivity(itemDescription: descriptionActivity, date: tomorrow, duration: duration, typeActivity: typeActivity))
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
