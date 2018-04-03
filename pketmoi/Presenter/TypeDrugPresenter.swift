//
//  typeDrugPresenter.swift
//  pketmoi
//
//  Created by Loris Zirah on 19/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import UIKit

class TypeDrugPresenter: NSObject {
    
    fileprivate var name: String = ""
    
    fileprivate var typeDrug: TypeDrug? = nil {
        didSet {
            if let typeDrug = self.typeDrug {
                if let tdname = typeDrug.name {
                    self.name = tdname
                } else {
                    self.name = "unknown"
                }
            } else {
                self.name = ""
            }
        }
    }
    
    /// Configure the cell with the given typeDrug and the given indexPath
    ///
    /// - Parameters:
    ///   - forCell: the cell to configure
    ///   - typeDrug: the typeDrug linked to the cell
    ///   - indexPath: the indexPath of the cell
    /// - Returns: the cell configured
    func configureCell(forCell: TypeDrugTableViewCell?, typeDrug: TypeDrug, indexPath: IndexPath) -> TypeDrugTableViewCell? {
        self.typeDrug = typeDrug
        guard let cell = forCell else { return nil }
        cell.name.text = self.name
        cell.button.tag = indexPath.row
        return cell
    }
}
