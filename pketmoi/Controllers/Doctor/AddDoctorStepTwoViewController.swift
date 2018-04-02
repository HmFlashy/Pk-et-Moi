//
//  AddDoctorStepTwoViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 12/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class AddDoctorStepTwoViewController: UIViewController {
    
    
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var streetNameTextField: UITextField!
    
    private var profession: Profession!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func set(forProfession: Profession){
        self.profession = forProfession
    }

    
    @IBAction func addDoctorAction(_ sender: Any) {
        _ = Doctor.createDoctor(lastname: lastnameTextField.text!, firstname: firstnameTextField.text!, phone: phoneTextField.text, email: mailTextField.text, address: streetNameTextField.text, city: cityTextField.text, zip: zipTextField.text, travelTime: 0)
        performSegue(withIdentifier: "unwindToDoctorsView", sender: sender)
        
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
