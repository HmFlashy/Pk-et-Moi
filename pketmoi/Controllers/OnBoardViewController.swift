//
//  OnBoardViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 17/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class OnBoardViewController: UIViewController {

    @IBOutlet weak var nameOutlet: UITextField!
    @IBOutlet weak var firstnameOutlet: UITextField!
    @IBOutlet weak var birthDateOutlet: UIDatePicker!
    @IBOutlet weak var preparationTimeOutlet: UISlider!
    
    @IBOutlet weak var preparationTimeDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        preparationTimeDisplay.text = String(currentValue) + " min"
    }
    @IBAction func validateFirstTimeAction(_ sender: Any) {
        let typeProfessions = TypeProfession.fillDatabase()
        _ = Profession.fillDatabase(typeProfessions: typeProfessions)
        CoreDataManager.save()
        UserDefaults.standard.set("false", forKey: "firstLaunch")
        UserDefaults.standard.set(nameOutlet.text, forKey: "LastName")
        UserDefaults.standard.set(firstnameOutlet.text, forKey: "FirstName")
        UserDefaults.standard.set(birthDateOutlet.date, forKey: "BirthDate")
        UserDefaults.standard.set(preparationTimeOutlet.value, forKey: "PreparationTime")
        performSegue(withIdentifier: "toMainView", sender: sender)
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
