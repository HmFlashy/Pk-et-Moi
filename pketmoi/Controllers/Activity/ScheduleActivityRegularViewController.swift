//
//  ScheduleActivityRegularViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 13/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class ScheduleActivityRegularViewController: UIViewController, UITextViewDelegate {
    var typeActivity: TypeActivity?
    
    @IBOutlet weak var dateErrorMessage: UILabel!
    @IBOutlet weak var StartDatePicker: UIDatePicker!
    @IBOutlet weak var EndDatePicker: UIDatePicker!
    @IBOutlet weak var descriptionActivity: UITextView!
    @IBOutlet weak var durationDatePicker: UIDatePicker!
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionActivity.delegate = self
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "selectDays"){
            dateErrorMessage.text = ""
            guard StartDatePicker.date.compare(EndDatePicker.date).rawValue<1 else{
                self.dateErrorMessage.text = "La date de fin doit être supérieure à la date de début"
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "selectDays"){
            let selectDaysViewController = segue.destination as! SelectDaysViewController
            selectDaysViewController.startDate = StartDatePicker.date
            selectDaysViewController.endDate = EndDatePicker.date
            selectDaysViewController.typeActivity = typeActivity
            selectDaysViewController.descriptionActivity = descriptionActivity.text
            selectDaysViewController.startTime = startTimeDatePicker.date
            selectDaysViewController.duration = durationDatePicker.date
        }
    }
    
    // MARK : - TextView Delegate protocol -
    
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
}
