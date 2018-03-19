//
//  ShowTypeDrugViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 19/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class ShowTypeDrugViewController: UIViewController {

    var typeDrug: TypeDrug!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var minimalDose: UILabel!
    @IBOutlet weak var maximalDose: UILabel!
    @IBOutlet weak var minimalIntervalDose: UILabel!
    @IBOutlet weak var maximumFrequency: UILabel!
    @IBOutlet weak var drugDescription: UITextView!
    
    @IBAction func sendToDrugUrl(_ sender: Any) {
        if let urlString = typeDrug.url{
            let url = URL(string: urlString)!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameButton.setTitle(typeDrug.name, for: UIControlState.normal)
        minimalDose.text = self.typeDrug.minimalDose
        maximalDose.text = self.typeDrug.maximalDose
        minimalIntervalDose.text = self.typeDrug.minimalIntervalDose
        maximumFrequency.text = self.typeDrug.maximalFrequency
        drugDescription.text = self.typeDrug.drugDescription
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modifyTypeDrug"{
            let destinationVC = segue.destination as! ModifyTypeDrugViewController
            destinationVC.typeDrug = self.typeDrug
        }
    }
}
