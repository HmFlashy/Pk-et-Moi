//
//  AddContactViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 02/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {

    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addContact(_ sender: Any) {
        var errors = false
        if firstnameTextField.text!.isEmpty {
            errors = true
            firstnameTextField.layer.borderWidth = 1
            firstnameTextField.layer.borderColor = UIColor.red.cgColor
        }
        else{
            firstnameTextField.layer.borderWidth = 0
        }
        
        if lastnameTextField.text!.isEmpty {
            errors = true
            lastnameTextField.layer.borderWidth = 1
            lastnameTextField.layer.borderColor = UIColor.red.cgColor
        }
        else{
            lastnameTextField.layer.borderWidth = 0
        }
        
        if statusTextField.text!.isEmpty {
            errors = true
            statusTextField.layer.borderWidth = 1
            statusTextField.layer.borderColor = UIColor.red.cgColor
        }
        else{
            statusTextField.layer.borderWidth = 0
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
        
        guard !errors else {
            return
        }
        
        _ = Contact.createContact(firstname: firstnameTextField.text!, lastname: lastnameTextField.text!, phone: phoneTextField.text!, status: statusTextField.text!, address: addressTextField.text!)
        self.performSegue(withIdentifier: "myContactUnwindSegue", sender: self)
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
