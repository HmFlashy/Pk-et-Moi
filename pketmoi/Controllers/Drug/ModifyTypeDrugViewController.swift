//
//  ModifyTypeDrugViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 19/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class ModifyTypeDrugViewController: UIViewController {

    var typeDrug: TypeDrug!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var minimalDose: UITextField!
    @IBOutlet weak var maximalDose: UITextField!
    @IBOutlet weak var minimalIntervalDose: UITextField!
    @IBOutlet weak var maximumFrequency: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var drugDescription: UITextView!
    
    @IBAction func validateModifications(_ sender: Any) {
        typeDrug.name = name.text
        typeDrug.minimalDose = minimalDose.text
        typeDrug.maximalDose = maximalDose.text
        typeDrug.minimalIntervalDose = minimalIntervalDose.text
        typeDrug.maximalFrequency = maximumFrequency.text
        typeDrug.url = url.text
        typeDrug.drugDescription = drugDescription.text
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            print(error)
        }
        self.performSegue(withIdentifier: "validateModifSegue", sender: self)
        /*let test = self.navigationController?.parent as! ShowTypeDrugViewController
        test.typeDrug = self.typeDrug*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text = typeDrug.name
        self.minimalDose.text = typeDrug.minimalDose
        self.maximalDose.text = typeDrug.maximalDose
        self.minimalIntervalDose.text = typeDrug.minimalIntervalDose
        self.maximumFrequency.text = typeDrug.maximalFrequency
        self.url.text = typeDrug.url
        self.drugDescription.text = typeDrug.drugDescription
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
