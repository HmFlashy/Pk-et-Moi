//
//  MyDataViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 18/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class MyDataViewController: UIViewController {

    
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var preparationTime: UILabel!
    @IBOutlet weak var preparationTimeSlider: UISlider!
    @IBOutlet weak var birthDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        lastName.text = defaults.string(forKey: "LastName")
        firstName.text = defaults.string(forKey: "FirstName")
        birthDate.date = defaults.object(forKey: "BirthDate") as! Date
        address.text = defaults.string(forKey: "Address")
        city.text = defaults.string(forKey: "City")
        postalCode.text = defaults.string(forKey: "postalCode")
        preparationTimeSlider.value = defaults.float(forKey: "PreparationTime")
        preparationTime.text = String(Int(defaults.float(forKey: "PreparationTime"))) + " min"
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        preparationTime.text = String(currentValue) + " min"
    }
    
    
    func saveData(){
        let defaults = UserDefaults.standard
        defaults.set(lastName.text, forKey: "LastName")
        defaults.set(firstName.text, forKey: "FirstName")
        defaults.set(birthDate.date, forKey: "BirthDate")
        defaults.set(address.text, forKey: "Address")
        defaults.set(city.text, forKey: "City")
        defaults.set(postalCode.text, forKey: "PostalCode")
        defaults.set(preparationTime.text, forKey: "PreparationTime")
    }
    
    @IBAction func saveButton(_ sender: Any) {
        saveData()
    }
    
    @IBAction func nextButton(_ sender: Any) {
        saveData()
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
