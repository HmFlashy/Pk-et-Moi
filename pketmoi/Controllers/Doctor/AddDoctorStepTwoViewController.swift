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
    
    private var doctor: Doctor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func set(forDoctor: Doctor){
        self.doctor = forDoctor
    }

    
    @IBAction func addDoctorAction(_ sender: Any) {
        self.doctor?.lastname = lastnameTextField.text
        self.doctor?.firstname = firstnameTextField.text
        self.doctor?.email = mailTextField.text
        self.doctor?.phone = phoneTextField.text
        self.doctor?.city = cityTextField.text
        self.doctor?.zip = zipTextField.text
        self.doctor?.address = streetNameTextField.text
        do {
            try CoreDataManager.context.save()
        } catch {
            print("Erreur lors de l'ajout")
        }
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
