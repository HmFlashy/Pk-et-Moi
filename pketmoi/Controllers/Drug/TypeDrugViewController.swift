//
//  TypeDrugViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 19/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class TypeDrugViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var minimalDose: UITextField!
    @IBOutlet weak var maximalDose: UITextField!
    @IBOutlet weak var intervalDose: UITextField!
    @IBOutlet weak var maximalFrequency: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var drugDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drugDescription.delegate = self
    }
    
    @IBAction func addTypeDrug(_ sender: Any) {
        name.layer.borderWidth = 0
        if (name.text?.isEmpty)! {
            name.layer.borderWidth = 1
            name.layer.borderColor = UIColor.red.cgColor
        }
        else{
            _ = TypeDrug.createTypeDrug(name: name.text!, minimalDose: minimalDose.text!, maximalDose: maximalDose.text!, minimalIntervalDose: intervalDose.text!, maximalFrequency: maximalFrequency.text!, url: url.text, drugDescription: drugDescription.text)
            self.performSegue(withIdentifier: "drugUnwindSegue", sender: self)
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
