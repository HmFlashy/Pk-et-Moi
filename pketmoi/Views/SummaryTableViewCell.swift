//
//  SummaryTableViewCell.swift
//  pketmoi
//
//  Created by Loris Zirah on 25/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
