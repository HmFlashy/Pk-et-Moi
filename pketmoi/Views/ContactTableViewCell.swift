//
//  ContactTableViewCell.swift
//  pketmoi
//
//  Created by Loris Zirah on 02/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    var contact: Contact!
    
    @IBAction func CallButton(_ sender: Any) {
        guard let phoneNumber = self.contact?.phone else { return }
        if let url = URL(string: "telprompt://\(phoneNumber)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
