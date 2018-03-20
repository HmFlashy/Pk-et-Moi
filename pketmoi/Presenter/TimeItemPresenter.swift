//
//  TimeEventPresenter.swift
//  pketmoi
//
//  Created by Hugo Maitre on 19/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import UIKit

class TimeItemPresenter: NSObject {
    
    private var drugPresenter: DrugPresenter = DrugPresenter()
    private var appointmentPresenter: AppointmentPresenter = AppointmentPresenter()
    private var activityPresenter: ActivityPresenter = ActivityPresenter()
    
    func configureCell(forCell: UICollectionViewCell?, timeItem: TimeItem) -> UICollectionViewCell? {
        var cell = forCell
        if(cell == nil) {
            return nil
        }
        let date: Date! = timeItem.date
        print(date.description)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        if(timeItem.isKind(of: Activity.self)) {
            cell = activityPresenter.configureCollectionCell(forCollectionCell: cell, activity: timeItem as! Activity)!
        } else if(timeItem.isKind(of: Drug.self)) {
            cell = drugPresenter.configureCollectionCell(forCollectionCell: cell, drug: timeItem as! Drug)!
        }else if(timeItem.isKind(of: Appointment.self)) {
            cell = appointmentPresenter.configureCollectionCell(forCollectionCell: cell, appointement: timeItem as! Appointment)!
        }
        return cell
    }
}
