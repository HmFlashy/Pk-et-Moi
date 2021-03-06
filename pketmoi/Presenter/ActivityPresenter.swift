//
//  ActivityPresenter.swift
//  pketmoi
//
//  Created by Hugo Maitre on 20/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import UIKit

class ActivityPresenter {
    
    fileprivate var typeActivity: String = ""
    fileprivate var duration: String = ""
    fileprivate var time: String = ""
    
    fileprivate var activity: Activity? = nil {
        didSet {
            if let activity = self.activity {
                if let atype = activity.typeActivity?.name {
                    self.typeActivity = atype
                } else {
                    self.typeActivity = "unknown"
                }
                if let duration = activity.duration {
                    self.duration = duration
                } else {
                    self.duration = "unknown"
                }
                if let time = activity.date {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    formatter.timeZone = TimeZone(abbreviation: "UTC+1")
                    self.time = formatter.string(from: time)
                }
            } else {
                self.typeActivity = "NIL"
                self.duration = "NIL"
                self.time = "NIL"
            }
        }
    }
    
    /// Configure the cell with the given activity
    ///
    /// - Parameters:
    ///   - forCollectionCell: the cell to configure
    ///   - activity: the activity linked to the cell
    /// - Returns: the cell configured
    func configureCollectionCell(forCollectionCell: UICollectionViewCell?, activity: Activity) -> ActivityCollectionViewCell? {
        self.activity = activity
        guard let cell: ActivityCollectionViewCell = forCollectionCell as? ActivityCollectionViewCell else {
            return nil
        }
        cell.typeActivityLabel.text = typeActivity
        cell.durationLabel.text = duration + " min"
        cell.timeLabel.text = time
        cell.backgroundColor = UIColor(red: 0.2, green: 0.5, blue: 0.1, alpha: 0.1)
        return cell
    }
    
    /// Configure the TableViewcell with the given activity
    ///
    /// - Parameters:
    ///   - forTableViewCell: the cell to configure
    ///   - activity: the activity linked to the cell
    /// - Returns: the cell configured
    func configureTableViewCell(forTableViewCell: UITableViewCell?, activity: Activity) -> ActivityTableViewCell? {
        self.activity = activity
        guard let cell: ActivityTableViewCell = forTableViewCell as? ActivityTableViewCell else {
            return nil
        }
        cell.activityLabel.text = typeActivity
        cell.durationLabel.text = duration + " min"
        cell.hourLabel.text = time
        cell.backgroundColor = UIColor(red: 0.2, green: 0.5, blue: 0.1, alpha: 0.1)
        return cell
    }
}
