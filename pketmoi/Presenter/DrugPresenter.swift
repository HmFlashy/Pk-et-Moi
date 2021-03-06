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
    
    fileprivate var drugType: String = ""
    fileprivate var dose: String = ""
    fileprivate var time: String = ""
    
    fileprivate var drug: Drug? = nil {
        didSet {
            if let drug = self.drug {
                if let dtype = drug.typeDrug?.name {
                    self.drugType = dtype
                } else {
                    self.drugType = "unknown"
                }
                if let ddose = drug.dose {
                    self.dose = ddose
                } else {
                    self.dose = "unknown"
                }
                if let time = drug.date {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    formatter.timeZone = TimeZone(abbreviation: "UTC+1")
                    self.time = formatter.string(from: time)
                }
            } else {
                self.drugType = "NIL"
                self.dose = "NIL"
                self.time = "NIL"
            }
        }
    }
    
    /// Confighre the cell with the given drug
    ///
    /// - Parameters:
    ///   - forCollectionCell: the cell to configure
    ///   - drug: the drug linked to the cell
    /// - Returns: the cell configured
    func configureCollectionCell(forCollectionCell: UICollectionViewCell?, drug: Drug) -> DrugCollectionViewCell? {
        self.drug = drug
        guard let cell: DrugCollectionViewCell = forCollectionCell as? DrugCollectionViewCell else {
            return nil
        }
        cell.drugLabel.text = self.drugType
        cell.doseLabel.text = self.dose
        cell.timeLabel.text = self.time
        cell.backgroundColor = UIColor(red: 0.2, green: 0.1, blue: 0.5, alpha: 0.1)
        return cell
    }
    
    /// The cell configured with the given drug
    ///
    /// - Parameters:
    ///   - forTableViewCell: the cell to configure
    ///   - drug: the drug linked to the cell
    /// - Returns: the cell configured
    func configureTableViewCell(forTableViewCell: UITableViewCell?, drug: Drug) -> DrugTableViewCell? {
        self.drug = drug
        guard let cell: DrugTableViewCell = forTableViewCell as? DrugTableViewCell else {
            return nil
        }
        cell.drugNameLabel.text = self.drugType
        cell.doseLabel.text = self.dose
        cell.drugHourLabel.text = self.time
        cell.backgroundColor = UIColor(red: 0.2, green: 0.1, blue: 0.5, alpha: 0.1)
        return cell
    }
}

