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
    
    fileprivate var date: String = ""
    fileprivate var descTimeItem: String = ""
    
    fileprivate var timeItem: TimeItem? = nil {
        didSet {
            if let timeItem = self.timeItem {
                if let tiDate = timeItem.date {
                    self.date = tiDate.description
                } else {
                    self.date = "unknown"
                }
            } else {
                self.date = "NIL"
                self.descTimeItem = "NIL"
            }
        }
    }
    
    func configureCell(forCell: TimeItemCollectionViewCell?, timeItem: TimeItem){
        self.timeItem = timeItem
        guard let cell = forCell else { return }
        let date: Date! = timeItem.date
        print(date.description)
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        formatter.timeZone = TimeZone(abbreviation: "UTC+1")
        cell.descItemDate.text = self.descTimeItem
        cell.timeItemDate.text = formatter.string(from: date)
    }
}
