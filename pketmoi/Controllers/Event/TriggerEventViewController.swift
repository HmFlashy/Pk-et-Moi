//
//  TriggerEventViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 24/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class TriggerEventViewController: UIViewController, NSFetchedResultsControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var typeEventPickerView: TypeEventPickerViewController!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var descriptionTextArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextArea.delegate = self
    }
    
    @IBAction func addTriggerEvent(_ sender: Any) {
        guard let typeEvent = typeEventPickerView.selectedTypeEvent else {return}
        _ = Event.createEvent(itemDescription: descriptionTextArea.text, date: datePicker.date, typeEvent: typeEvent)
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
        descriptionTextArea.resignFirstResponder()
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
    
    // MARK: - Navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addEvent"{
            guard let typeEvent = typeEventPickerView.selectedTypeEvent else {return}
            Event.createEvent(itemDescription: descriptionTextArea.text, date: datePicker.date, typeEvent: typeEvent)
        }
    }*/
}
