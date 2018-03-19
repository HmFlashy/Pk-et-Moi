//
//  DoctorTableViewCell.swift
//  pketmoi
//
//  Created by Hugo Maitre on 12/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var doctorFullName: UILabel!
    @IBOutlet weak var doctorProfession: UILabel!
    @IBOutlet weak var appointmentButton: UIButton!
    
    var parent: UIViewController?
    var doctor: Doctor?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func callButtonAction(_ sender: Any) {
        guard let phoneNumber = self.doctor?.phone else { return }
        if let url = URL(string: "telprompt://\(phoneNumber)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func appointmentButtonAction(_ sender: UIButton) {
    }
}
