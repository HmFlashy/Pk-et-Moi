//
//  AddDoctorViewControllerStepTwo.swift
//  pketmoi
//
//  Created by Hugo Maitre on 12/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class AddDoctorStepOneViewController: UIViewController {
    
    @IBOutlet weak var professionTypePicker: TypeProfessionPickerView!
    
    @IBOutlet weak var professionPicker: ProfessionPickerView!
    
    private var doctor: Doctor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        professionTypePicker.setProfessionPicker(professionPicker: professionPicker)
        professionTypePicker.selectedRow(inComponent: 0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func choseProfessionAction(_ sender: Any) {
        doctor = Doctor.getNewDoctorDAO()
        guard let professions = professionPicker.professionsFetched else { return }
        doctor?.profession = professions[professionPicker.selectedRow(inComponent: 0)]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStepTwo" {
            let stepTwoController: AddDoctorStepTwoViewController = segue.destination as! AddDoctorStepTwoViewController
            guard let doctor = self.doctor else {
                return
            }
            stepTwoController.set(forDoctor: doctor)
        }
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
