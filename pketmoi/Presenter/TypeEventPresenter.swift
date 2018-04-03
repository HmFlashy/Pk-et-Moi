//
//  TypeEventPresenter.swift
//  pketmoi
//
//  Created by Hugo Maitre on 28/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import UIKit

class TypeEventPresenter: NSObject {
    
    fileprivate var name: String = ""
    
    fileprivate var typeEvent: TypeEvent? = nil {
        didSet {
            if let typeEvent = self.typeEvent {
                if let tename = typeEvent.name {
                    self.name = tename
                } else {
                    self.name = "unknown"
                }
            } else {
                self.name = ""
            }
        }
    }
    
    
    /// Configure the cell with the given typeEvent
    ///
    /// - Parameters:
    ///   - forCell: the cell to configure
    ///   - typeEvent: the typeEvent linked to the cell
    /// - Returns: the cell configured
    func configureCell(forCell: UITableViewCell?, typeEvent: TypeEvent) -> UITableViewCell? {
        self.typeEvent = typeEvent
        guard let cell = forCell else { return nil }
        cell.textLabel?.text = self.name
        return cell
    }
}
