//
//  ActivityCollectionViewCell.swift
//  pketmoi
//
//  Created by Hugo Maitre on 20/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class ActivityCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var typeActivityLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 8
    }
}
