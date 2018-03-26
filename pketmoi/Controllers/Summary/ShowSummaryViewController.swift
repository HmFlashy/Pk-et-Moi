//
//  ShowSummaryViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 25/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class ShowSummaryViewController: UIViewController {
    
    @IBOutlet weak var summaryLabel: UILabel!
    var summary: Summary!
    var date: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "fr_FR")
        /*if let date = self.summary.appointment?.date {
            self.dateLabel.text = dateFormatter.string(from: date)
        }*/
        self.summaryLabel.text = "Synthèse du " + date
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
