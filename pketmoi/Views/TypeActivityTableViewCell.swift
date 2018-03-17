//
//  TypeActivityTableViewCell.swift
//  pketmoi
//
//  Created by Loris Zirah on 11/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class TypeActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeActivityName: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
