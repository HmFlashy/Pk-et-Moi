//
//  AppointmentTableViewCell.swift
//  pketmoi
//
//  Created by Hugo Maitre on 26/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {

    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
