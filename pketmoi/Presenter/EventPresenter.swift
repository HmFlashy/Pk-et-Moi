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
    
    
    /// Configure the cell with the given event
    ///
    /// - Parameters:
    ///   - forCell: the cell to configure
    ///   - event: the event linked to the cell
    /// - Returns: the cell configured
    func configureCell(forCell: EventTableViewCell?, event: Event) -> EventTableViewCell? {
        self.event = event
        guard let cell: EventTableViewCell = forCell else { return nil }
        cell.dateEvent.text = self.date
        cell.typeEventTitle.text = self.typeEventName
        return cell
    }
    
    
}

