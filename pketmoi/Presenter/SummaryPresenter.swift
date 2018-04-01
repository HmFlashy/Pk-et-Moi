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
    
    func configureCell(forCell: SummaryTableViewCell?, summary: Summary, row: Int){
        self.summary = summary
        guard let cell = forCell else { return }
        if let summary = self.summary{
            if summary.verified {
                if let image = UIImage(named: "icons8-ok-24"){
                    cell.questionnaireImageView.image = image
                }
            }
            else{
                if let image = UIImage(named: "icons8-annuler-24"){
                    cell.questionnaireImageView.image = image
                }
            }
        }
        cell.nameLabel.text = "Synthèse " + String(row+1)
        cell.dateLabel.text = self.date
    }
}

