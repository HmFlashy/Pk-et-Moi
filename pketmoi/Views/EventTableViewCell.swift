//
//  EventTableViewCell.swift
//  pketmoi
//
//  Created by Hugo Maitre on 05/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var dateEvent: UILabel!
    @IBOutlet weak var typeEventTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func openEventInformation(_ sender: Any) {
    }
}
