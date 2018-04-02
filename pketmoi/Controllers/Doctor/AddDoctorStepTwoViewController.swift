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
        var errors = false
        if lastnameTextField.text!.isEmpty {
            errors = true
            lastnameTextField.layer.borderWidth = 1
            lastnameTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            lastnameTextField.layer.borderWidth = 0
        }
        if firstnameTextField.text!.isEmpty {
            errors = true
            firstnameTextField.layer.borderWidth = 1
            firstnameTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            firstnameTextField.layer.borderWidth = 0
        }
        
        let zipRegEx = "[0-9]{5}"
        let zipTest = NSPredicate(format:"SELF MATCHES %@", zipRegEx)
        if !zipTextField.text!.isEmpty && !zipTest.evaluate(with: zipTextField.text!) {
            errors = true
            zipTextField.layer.borderWidth = 1
            zipTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            zipTextField.layer.borderWidth = 0
        }
        
        let phoneRegEx = "[0-9]{10}"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        if !phoneTextField.text!.isEmpty && !phoneTest.evaluate(with: phoneTextField.text!) {
            errors = true
            phoneTextField.layer.borderWidth = 1
            phoneTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            phoneTextField.layer.borderWidth = 0
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !mailTextField.text!.isEmpty && !emailTest.evaluate(with: mailTextField.text!) {
            errors = true
            mailTextField.layer.borderWidth = 1
            mailTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            mailTextField.layer.borderWidth = 0
        }
        guard !errors else {
            return
        }
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
