//
//  ScheduleDrugRegularViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 20/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class ScheduleDrugRegularViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var drugDescription: UITextView!
    @IBOutlet weak var drugDose: UITextField!
    var typeDrug: TypeDrug!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drugDescription.delegate = self
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "selectDays"){
            //Perform some test before the segue
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "setTimeTable"){
            let setDrugTimeTableViewController = segue.destination as! SetDrugTimeTableViewController
            setDrugTimeTableViewController.startDate = startDate.date
            setDrugTimeTableViewController.endDate = endDate.date
            setDrugTimeTableViewController.typeDrug = self.typeDrug
            setDrugTimeTableViewController.drugDose = self.drugDose.text
            setDrugTimeTableViewController.drugDescription = drugDescription.text
        }
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
        drugDescription.resignFirstResponder()
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
