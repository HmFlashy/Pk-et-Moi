//
//  NeurologistLastQuestionViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 01/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class NeurologistLastQuestionViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var questionName: UILabel!
    @IBOutlet weak var yesButton: CustomRadioButton!
    @IBOutlet weak var noButton: CustomRadioButton!
    @IBOutlet weak var comment: UITextView!
    var summary: Summary!
    var neurologistQuestion: NeurologistQuestion!
    var neurologistAnswer: NeurologistAnswer?
    
    fileprivate lazy var neurologistAnswerFetched: NSFetchedResultsController<NeurologistAnswer> = {
        let request: NSFetchRequest<NeurologistAnswer> = NeurologistAnswer.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(NeurologistAnswer.neurologistQuestion.name), ascending: true)]
        request.predicate = NSPredicate(format: "summary = %@ AND neurologistQuestion = %@", argumentArray: [self.summary, self.neurologistQuestion])
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }()
    
    fileprivate lazy var neurologistAnswerVerifiedFetched: NSFetchedResultsController<NeurologistAnswer> = {
        let request: NSFetchRequest<NeurologistAnswer> = NeurologistAnswer.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(NeurologistAnswer.neurologistQuestion.name), ascending: true)]
        request.predicate = NSPredicate(format: "summary = %@", self.summary)
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try neurologistAnswerFetched.performFetch()
        } catch{
            print("Unable to perfom neurologist Answer fetch")
        }
        if let fetchedObjects = neurologistAnswerFetched.fetchedObjects{
            if fetchedObjects.count > 0 {
                neurologistAnswer = fetchedObjects[0]
                if neurologistAnswer!.status {
                    self.yesPressed(self)
                }
                else{
                    self.noPressed(self)
                }
                self.comment.text = neurologistAnswer!.comment
            }
        }
        
        questionNumber.text = String(self.neurologistQuestion.number) + "/8"
        questionName.text = neurologistQuestion.name
        comment.delegate = self
    }

    @IBAction func yesPressed(_ sender: Any) {
        yesButton.isSelected = true
        noButton.isSelected = false
    }
    
    @IBAction func noPressed(_ sender: Any) {
        noButton.isSelected = true
        yesButton.isSelected = false
    }
    
    @IBAction func previousPressed(_ sender: Any) {
        if yesButton.isSelected || noButton.isSelected {
            if let neurologistAnswerNotNull = self.neurologistAnswer {
                neurologistAnswerNotNull.comment = self.comment.text
                neurologistAnswerNotNull.status = self.yesButton.isSelected
                CoreDataManager.save()
            }
            else{
                self.neurologistAnswer = NeurologistAnswer.createNeurologistAnswer(status: yesButton.isSelected, comment: self.comment.text, summary: self.summary, neurologistQuestion: self.neurologistQuestion)
            }
        }
        let parentVC = self.parent as! NeurologistQuestionPageViewController
        parentVC.previousPage()
    }
    
    @IBAction func validatePressed(_ sender: Any) {
        if yesButton.isSelected || noButton.isSelected {
            if let neurologistAnswerNotNull = self.neurologistAnswer {
                neurologistAnswerNotNull.comment = self.comment.text
                neurologistAnswerNotNull.status = self.yesButton.isSelected
            }
            else{
                self.neurologistAnswer = NeurologistAnswer.createNeurologistAnswer(status: yesButton.isSelected, comment: self.comment.text, summary: self.summary, neurologistQuestion: self.neurologistQuestion)
            }
        }
        
        do{
            try neurologistAnswerVerifiedFetched.performFetch()
        } catch {
            print("Unable to perform fetch")
        }
        if let neurologistAnswerVerifiedFetchedObjetcts = neurologistAnswerVerifiedFetched.fetchedObjects {
            if neurologistAnswerVerifiedFetchedObjetcts.count == 8{
                self.summary.verified = true
            }
        }
        
        CoreDataManager.save()
        
        self.performSegue(withIdentifier: "showSummaryUnwindSegue", sender: sender)
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
        comment.resignFirstResponder()
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
