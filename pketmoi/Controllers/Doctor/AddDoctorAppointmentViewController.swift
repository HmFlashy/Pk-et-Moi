//
//  AddDoctorAppointmentViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 19/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class AddDoctorAppointmentViewController: UIViewController {

    private var doctor: Doctor?
    
    @IBOutlet weak var appointmentDatePicker: UIDatePicker!
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var appointmentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        appointmentView.backgroundColor = UIColor.cyan
        appointmentView.layer.cornerRadius = 10
        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func set(forDoctor: Doctor){
        self.doctor = forDoctor
    }

    @IBAction func addAppointmentAction(_ sender: Any) {
        let appointment: Appointment = Appointment.CreateAppointment(date: self.appointmentDatePicker.date, doctor: self.doctor!)!
        NotificationManager.addTimeItemNotification(forDate: self.appointmentDatePicker.date, using: appointment)
        print(appointment.date?.description ?? "")
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
