//
//  DoctorCollectionViewCell.swift
//  pketmoi
//
//  Created by Hugo Maitre on 20/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class AppointmentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var rdvLabel: UILabel!
    
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 8
    }
    
}
