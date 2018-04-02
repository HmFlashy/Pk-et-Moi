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

class NotificationManager {
    
    private static var notificationNumber = 0
    
    public static func resetBadge(){
        notificationNumber = 0
        UIApplication.shared.applicationIconBadgeNumber = notificationNumber
    }
    
    public static func addTimeItemNotification(forDate: Date, using: TimeItem) {
        let content = UNMutableNotificationContent()
        var identifier = ""
        var date: Date = forDate
        if(using.isKind(of: Activity.self)) {
            
        } else if (using.isKind(of: Appointment.self)) {
            let appointment = using as! Appointment
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let hours = dateFormatter.string(from: appointment.date!)
            content.title = "Rendez-vous " + (appointment.doctor?.profession?.title)!
            content.body = "Commencez à vous préparer pour votre rendez-vous à " + hours
            identifier = "appointment" + (appointment.date?.description)!
            let time = Int(UserDefaults.standard.float(forKey: "PreparationTime")) + Int((appointment.doctor?.travelTime)!)
            print(time)
            date = Calendar.current.date(byAdding: .minute,value: (-time), to: date)!
        } else if (using.isKind(of: Drug.self)) {
            
        }
        notificationNumber += 1
        content.badge = notificationNumber as NSNumber
        
        // add notification for Mondays at 11:00 a.m.
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
    
    public static func removeNotification(){
        
    }
}
