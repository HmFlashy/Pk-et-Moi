//
//  ScheduleActivityNotRegularViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 15/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class ScheduleActivityNotRegularViewController: UIViewController, UITextViewDelegate {

    var typeActivity: TypeActivity?
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var dateErrorMessage: UILabel!
    @IBOutlet weak var durationErrorMessage: UILabel!
    @IBOutlet weak var descriptionActivity: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionActivity.delegate = self
    }
    
    func addActivity(){
        guard let typeActivity = self.typeActivity else{
            return
        }
        Activity.createActivity(itemDescription: "", date: datePicker.date, duration: duration.text!, typeActivity: typeActivity)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        self.dateErrorMessage.text = ""
        self.durationErrorMessage.text = ""
        // The current date is 2 hours before the real one, need to fix it
        guard Date().compare(datePicker.date).rawValue>0 else{
            self.dateErrorMessage.text = "La date ne peut pas être plus tôt qu'aujourd'hui"
            return false
        }
        guard duration.hasText else{
            self.durationErrorMessage.text = "La durée doit être renseignée"
            return false
        }
        guard let durationInt = Int(duration.text!) else{
            self.durationErrorMessage.text = "La durée doit être un entier"
            return false
        }
        self.addActivity()
        return true
    }
    
    // MARK : - TextViewDelegate
    
    // Start Editing The Text Field
    func textViewDidBeginEditing(_ textView: UITextView) {
        moveTextView(textView, moveDistance: -250, up: true)
    }
    
    // Finish Editing The Text Field
    func textViewDidEndEditing(_ textView: UITextView) {
        moveTextView(textView, moveDistance: -250, up: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        descriptionActivity.resignFirstResponder()
    }
    
    private func moveTextView(_ textView: UITextView, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
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
