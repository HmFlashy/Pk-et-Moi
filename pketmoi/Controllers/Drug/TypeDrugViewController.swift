//
//  TypeDrugViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 19/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class TypeDrugViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var minimalDose: UITextField!
    @IBOutlet weak var maximalDose: UITextField!
    @IBOutlet weak var intervalDose: UITextField!
    @IBOutlet weak var maximalFrequency: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var drugDescription: UITextView!
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return checkData()
    }
    
    func checkData() -> Bool{
        guard name.hasText else{return false}
        guard minimalDose.hasText else{return false}
        guard maximalDose.hasText else{return false}
        guard intervalDose.hasText else{return false}
        guard maximalFrequency.hasText else{return false}
        return true
    }
    
    @IBAction func addTypeDrug(_ sender: Any) {
        if checkData(){
            _ = TypeDrug.createTypeDrug(name: name.text!, minimalDose: minimalDose.text!, maximalDose: maximalDose.text!, minimalIntervalDose: intervalDose.text!, maximalFrequency: maximalFrequency.text!, url: url.text, drugDescription: drugDescription.text)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
