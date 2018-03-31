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
        if let date = self.summary.appointment?.date {
            self.summaryLabel.text = "Synthèse du " + dateFormatter.string(from: date)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageViewSegue" {
            let vc = segue.destination as! SummaryPageViewController
            vc.summary = self.summary
        }
    }
}
