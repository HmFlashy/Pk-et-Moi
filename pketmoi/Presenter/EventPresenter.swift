//
//  TypeEventPresenter.swift
//  pketmoi
//
//  Created by Hugo Maitre on 28/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import UIKit

class EventPresenter: NSObject {
    
    fileprivate var typeEventName: String = ""
    fileprivate var date: String = ""
    
    
    fileprivate var event: Event? = nil {
        didSet {
            if let event = self.event {
                if let date = event.date {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm"
                    self.date = formatter.string(from: date)
                } else {
                    self.date = "unknown"
                }
                if let tename = event.typeEvent?.name {
                    self.typeEventName = tename
                } else {
                    self.typeEventName = "unknown"
                }
            } else {
                self.typeEventName = ""
                self.date = ""
            }
        }
    }
    
    func configureCell(forCell: UITableViewCell?, event: Event){
        self.event = event
        guard let cell: EventTableViewCell = forCell as? EventTableViewCell else { return }
        cell.dateEvent.text = self.date
        cell.typeEventTitle.text = self.typeEventName
    }
    
}

