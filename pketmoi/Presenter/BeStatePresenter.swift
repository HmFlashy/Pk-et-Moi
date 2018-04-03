//
//  BeStatePresenter.swift
//  pketmoi
//
//  Created by Loris Zirah on 03/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import UIKit

class BeStatePresenter: NSObject {
    
    fileprivate var date: String = ""
    fileprivate var name: String = ""
    
    fileprivate var beState: BeState? = nil {
        didSet {
            if let beState = self.beState {
                if let sdate = beState.date{
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH"
                    dateFormatter.locale = Locale(identifier: "fr_FR")
                    date = dateFormatter.string(from: sdate) + "h"
                } else {
                    self.date = "unknown"
                }
                if let state = beState.state{
                    if let sname = state.name{
                        name = sname
                    }
                    else{
                        name = "unknown"
                    }
                }
                else{
                    name = "NIL"
                }
            }
            else{
                self.date = "NIL"
                self.name = "NIL"
            }
        }
    }
    
    /// Configure the cell with the given beState
    ///
    /// - Parameters:
    ///   - forCell: the cell to configure
    ///   - beState: the beState linked to the cell
    /// - Returns: the cell configured
    func configureCell(forCell: SummaryDayTableViewCell?, beState: BeState) -> SummaryDayTableViewCell? {
        self.beState = beState
        guard let cell = forCell else { return nil }
        cell.hourLabel.text = self.date
        cell.beState = self.beState
        switch self.name {
        case "ON":
            cell.stateLabel.text = self.name
            cell.stateLabel.backgroundColor = .green
            break
        case "OFF":
            cell.stateLabel.text = self.name
            cell.stateLabel.backgroundColor = .red
            break
        case "DYSKINESIES":
            cell.stateLabel.text = self.name
            cell.stateLabel.backgroundColor = .yellow
            break
        default:
            if (self.beState?.date)! <= Date() {
                cell.stateLabel.text = "A Faire"
                cell.stateLabel.backgroundColor = .cyan
            }
            else{
                cell.stateLabel.text = ""
                cell.stateLabel.backgroundColor = .white
            }
        }
        return cell
    }
}

