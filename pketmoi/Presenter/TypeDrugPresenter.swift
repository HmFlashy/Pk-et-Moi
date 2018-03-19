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
    
    func configureCell(forCell: TypeDrugTableViewCell?, typeDrug: TypeDrug){
        self.typeDrug = typeDrug
        guard let cell = forCell else { return }
        cell.name.text = self.name
    }
}
