//
//  DrugCollectionViewCell.swift
//  pketmoi
//
//  Created by Hugo Maitre on 20/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class DrugCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var drugLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 8
    }
}
