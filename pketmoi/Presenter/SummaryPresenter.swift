//
//  SummaryPresenter.swift
//  pketmoi
//
//  Created by Loris Zirah on 25/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import UIKit

class SummaryPresenter: NSObject {
    
    fileprivate var date: String = ""
    fileprivate var name: String = ""
    
    fileprivate var summary: Summary? = nil {
        didSet {
            if let summary = self.summary {
                if let sdate = summary.appointment?.date {
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "fr_FR")
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    self.date = dateFormatter.string(from: sdate)
                } else {
                    self.date = "unknown"
                }
            }
        }
    }
    
    func configureCell(forCell: SummaryTableViewCell?, summary: Summary){
        self.summary = summary
        guard let cell = forCell else { return }
        cell.nameLabel.text = "Synthèse"
        cell.dateLabel.text = self.date
    }
}

