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
        if self.doctor?.profession?.title == "Neurologue" {
            self.createSummary(appointment: appointment)
        }
        print(appointment.date?.description ?? "")
        self.dismiss(animated: true, completion: nil)
    }
    
    private func createSummary(appointment: Appointment){
        let date = appointment.date!
        var startDate = Calendar.current.date(byAdding: .day, value: -5, to: date)
        let endDate = Calendar.current.date(byAdding: .day, value: -1, to: date)
        let summary = Summary.createSummary(askingInterval: "1", endDate: endDate!, startDate: startDate!, appointment: appointment)
        print(summary)
        
        // Creating BeStates for all the days and rigorousAnswers
        for _ in 1...5 {
            let gregorian = Calendar(identifier: .gregorian)
            var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute], from: startDate!)
            components.hour = 7
            components.minute = 0
            var startDateState = gregorian.date(from: components)!
            var beState: BeState?
            var notif: Bool = false
            for _ in 1...14 {
                beState = BeState.createBeState(date: startDateState, state: nil, summary: summary)
                print(beState!)
                startDateState = Calendar.current.date(byAdding: .hour, value: 1, to: startDateState)!
                if !notif {
                    NotificationManager.addSummaryNotifications(forBeState: beState!)
                    notif = true
                }
            }
            let rigorousAnswer = RigorousAnswer.createRigorousAnswer(date: startDate!, nbOversight: nil, summary: summary, answer: nil)
            print(rigorousAnswer)
            startDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate!)
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
