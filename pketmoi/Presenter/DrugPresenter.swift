//
//  DrugPresenter.swift
//  pketmoi
//
//  Created by Hugo Maitre on 20/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import UIKit

class DrugPresenter {
    
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
    
    func configureCollectionCell(forCollectionCell: UICollectionViewCell?, drug: Drug) -> UICollectionViewCell? {
        guard let cell: DrugCollectionViewCell = forCollectionCell as? DrugCollectionViewCell else {
            return nil
        }
        cell.backgroundColor = UIColor.blue
        return cell
    }
}

