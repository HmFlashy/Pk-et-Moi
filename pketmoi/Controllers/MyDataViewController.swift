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
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var preparationTime: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func saveData(){
        let defaults = UserDefaults.standard
        defaults.set(lastName.text, forKey: "LastName")
        defaults.set(firstName.text, forKey: "FirstName")
        defaults.set(birthDate.text, forKey: "BirthDate")
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
