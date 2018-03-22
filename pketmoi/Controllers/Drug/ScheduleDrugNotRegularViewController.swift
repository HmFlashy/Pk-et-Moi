//
//  ScheduleDrugNotRegularViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 20/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class ScheduleDrugNotRegularViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var drugDescription: UITextView!
    @IBOutlet weak var drugDose: UITextField!
    var typeDrug: TypeDrug!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drugDescription.delegate = self
    }
    
    func addDrug(){
        print(Drug.createDrug(itemDescription: drugDescription.text, date: date.date, dose: drugDose.text!, typeDrug: typeDrug))
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // Perform some tests before the segue
        self.addDrug()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
