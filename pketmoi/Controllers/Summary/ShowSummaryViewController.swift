//
//  ShowSummaryViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 25/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class ShowSummaryViewController: UIViewController {
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var verifiedSummary: UIButton!
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
        
        if self.summary.verified {
            if let image = UIImage(named: "icons8-ok-48"){
                verifiedSummary.setImage(image, for: .normal)
            }
        }
        else{
            if let image = UIImage(named: "icons8-annuler-48"){
                verifiedSummary.setImage(image, for: .normal)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingToParentViewController {
            let parent = self.parent as! SummariesViewController
            parent.refreshFetched()
        }
    }
    
    @IBAction func unwindToShowSummaryViewController(segue: UIStoryboardSegue) {
        if self.summary.verified {
            if let image = UIImage(named: "icons8-ok-48"){
                verifiedSummary.setImage(image, for: .normal)
            }
        }
        else{
            if let image = UIImage(named: "icons8-annuler-48"){
                verifiedSummary.setImage(image, for: .normal)
            }
        }
    }
    
    // MARK: - Navigation -

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageViewSegue" {
            let vc = segue.destination as! SummaryPageViewController
            vc.summary = self.summary
        }
        else if segue.identifier == "neurologistSummarySegue" {
            let vc = segue.destination as! NeurologistQuestionnaireViewController
            vc.summary = self.summary
        }
    }
}
