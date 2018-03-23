//
//  ModifyDoctorViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 23/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class ModifyDoctorViewController: UIViewController {
    
    private var doctor: Doctor?

    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var travelTimeLabel: UILabel!
    @IBOutlet weak var travelTimeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(doctor?.fullname ?? "Mdr")
        if doctor != nil {
            lastnameTextField.text = doctor?.lastname
            firstnameTextField.text = doctor?.firstname
            addressTextField.text = doctor?.address
            cityTextField.text = doctor?.city
            zipTextField.text = doctor?.zip
            phoneTextField.text = doctor?.phone
            travelTimeSlider.value = Float((doctor?.travelTime)!)
            travelTimeLabel.text = String(travelTimeSlider.value) + " min"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func set(forDoctor: Doctor){
        self.doctor = forDoctor
    }

    @IBAction func valueChanged(_ sender: Any) {
        travelTimeLabel.text = String(travelTimeSlider.value) + " min"
    }
    @IBAction func ModifyDoctorAction(_ sender: Any) {
        doctor?.lastname = lastnameTextField.text
        doctor?.firstname = firstnameTextField.text
        doctor?.address = addressTextField.text
        doctor?.phone = phoneTextField.text
        doctor?.city = cityTextField.text
        doctor?.zip = zipTextField.text
        doctor?.travelTime = Int16(travelTimeSlider.value)
        do {
            try CoreDataManager.context.save()
        } catch {
            print("Failing modifying the doctor")
            return
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func BackDoctorAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
