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
    @IBOutlet weak var dateErrorMessage: UILabel!
    @IBOutlet weak var descriptionActivity: UITextView!
    @IBOutlet weak var durationDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionActivity.delegate = self
    }
    
    func addActivity(){
        guard let typeActivity = self.typeActivity else{
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "fr_FR")
        guard let date = dateFormatter.date(from: dateFormatter.string(from: datePicker.date)) else{return}
        dateFormatter.dateFormat = "HH:mm"
        let durationString = dateFormatter.string(from: durationDatePicker.date)
        print(Activity.createActivity(itemDescription: "", date: date, duration: durationString, typeActivity: typeActivity))
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        self.dateErrorMessage.text = ""
        /*guard Date().compare(datePicker.date).rawValue>0 else{
            self.dateErrorMessage.text = "La date ne peut pas être plus tôt qu'aujourd'hui"
            return false
        }*/
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
