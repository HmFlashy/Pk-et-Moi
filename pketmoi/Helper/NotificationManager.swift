//
//  NotificationManager.swift
//  pketmoi
//
//  Created by Hugo Maitre on 27/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

/// A class that helps to manage notification
class NotificationManager {
    
    
    private static var notificationNumber = 0
    
    /// Reset the notification badge
    public static func resetBadge(){
        notificationNumber = 0
        UIApplication.shared.applicationIconBadgeNumber = notificationNumber
    }
    
    /// Add time item notifications
    ///
    /// - Parameters:
    ///   - forDate: The date of the timeItem
    ///   - using: The timeItem created
    public static func addTimeItemNotification(forDate: Date, using: TimeItem) {
        let content = UNMutableNotificationContent()
        var identifier = ""
        var date: Date = forDate
        if(using.isKind(of: Activity.self)) {
            let activity = using as! Activity
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let hours = dateFormatter.string(from: activity.date!)
            content.title = "Activité " + (activity.typeActivity?.name)!
            content.body = "Cette activité commence dans 5 minutes à " + hours
            identifier = "activity" + (activity.date?.description)!
            date = Calendar.current.date(byAdding: .minute,value: -5, to: date)!
        } else if (using.isKind(of: Appointment.self)) {
            let appointment = using as! Appointment
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let hours = dateFormatter.string(from: appointment.date!)
            content.title = "Rendez-vous " + (appointment.doctor?.profession?.title)!
            content.body = "Commencez à vous préparer pour votre rendez-vous à " + hours
            identifier = "appointment" + (appointment.date?.description)!
            let time = Int(UserDefaults.standard.float(forKey: "PreparationTime")) + Int((appointment.doctor?.travelTime)!)
            let calendar = Calendar.current
            var dateComponents = DateComponents()
            date = Calendar.current.date(byAdding: .minute,value: (-Int((appointment.doctor?.travelTime)!)), to: date)!
            dateComponents.month = calendar.component(.month, from: date)
            dateComponents.day =  calendar.component(.day, from: date)
            dateComponents.hour =  calendar.component(.hour, from: date)
            dateComponents.minute = calendar.component(.minute, from: date)
            let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: notificationTrigger)
            print(request.description)
            UNUserNotificationCenter.current().delegate = UIApplication.shared.delegate as! AppDelegate
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            print(time)
            date = Calendar.current.date(byAdding: .minute,value: (-time), to: date)!
        } else if (using.isKind(of: Drug.self)) {
            let drug = using as! Drug
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let hours = dateFormatter.string(from: drug.date!)
            content.title = hours + ": Médicament " + (drug.typeDrug?.name)!
            content.body = "Prenez vos " + drug.dose! + " doses"
            identifier = "drug" + (drug.date?.description)!
            date = drug.date!
        }
        notificationNumber += 1
        content.badge = notificationNumber as NSNumber
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = calendar.component(.month, from: date)
        dateComponents.day =  calendar.component(.day, from: date)
        dateComponents.hour =  calendar.component(.hour, from: date)
        dateComponents.minute = calendar.component(.minute, from: date)
        print(dateComponents.description)
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: notificationTrigger)
        print(request.description)
        UNUserNotificationCenter.current().delegate = UIApplication.shared.delegate as! AppDelegate
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    public static func addSummaryNotifications(forBeState: BeState){
        let content = UNMutableNotificationContent()
        let date = forBeState.date!
        content.title = "Pensez à renseigner vos états aujourd'hui"
        var identifier = "beState1" + BeState.description()
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = calendar.component(.month, from: date)
        dateComponents.day =  calendar.component(.day, from: date)
        dateComponents.hour =  8
        dateComponents.minute = 0
        var notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        var request = UNNotificationRequest(identifier: identifier, content: content, trigger: notificationTrigger)
        print(request.description)
        UNUserNotificationCenter.current().delegate = UIApplication.shared.delegate as! AppDelegate
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        identifier = "beState2" + BeState.description()
        dateComponents.hour =  12
        notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        request = UNNotificationRequest(identifier: identifier, content: content, trigger: notificationTrigger)
        print(request.description)
        UNUserNotificationCenter.current().delegate = UIApplication.shared.delegate as! AppDelegate
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        identifier = "beState3" + BeState.description()
        dateComponents.hour =  16
        notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        request = UNNotificationRequest(identifier: identifier, content: content, trigger: notificationTrigger)
        print(request.description)
        UNUserNotificationCenter.current().delegate = UIApplication.shared.delegate as! AppDelegate
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        content.title = "Pensez à renseigner vos états aujourd'hui et de répondre à la question"
        identifier = "beState4" + BeState.description()
        dateComponents.hour =  20
        notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        request = UNNotificationRequest(identifier: identifier, content: content, trigger: notificationTrigger)
        print(request.description)
        UNUserNotificationCenter.current().delegate = UIApplication.shared.delegate as! AppDelegate
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
