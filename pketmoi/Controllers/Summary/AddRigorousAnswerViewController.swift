//
//  AddRigorousAnswerViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 03/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class AddRigorousAnswerViewController: UIViewController {

    @IBOutlet weak var buttonOne: CustomRadioButton!
    @IBOutlet weak var answerOne: UILabel!
    @IBOutlet weak var buttonTwo: CustomRadioButton!
    @IBOutlet weak var answerTwo: UILabel!
    @IBOutlet weak var buttonThree: CustomRadioButton!
    @IBOutlet weak var answerThree: UILabel!
    @IBOutlet weak var buttonFour: CustomRadioButton!
    @IBOutlet weak var answerFour: UILabel!
    @IBOutlet weak var buttonFive: CustomRadioButton!
    @IBOutlet weak var answerFive: UILabel!
    @IBOutlet weak var nbOversight: UITextField!
    var rigorousAnswer: RigorousAnswer!
    
    fileprivate lazy var answerFetched: NSFetchedResultsController<Answer> = {
        let request: NSFetchRequest<Answer> = Answer.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Answer.name), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try answerFetched.performFetch()
        } catch {
            print("Unable to perfom fetch")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func firstButtonPressed(_ sender: Any) {
        buttonOne.isSelected = true
        buttonTwo.isSelected = false
        buttonThree.isSelected = false
        buttonFour.isSelected = false
        buttonFive.isSelected = false
    }
    
    @IBAction func secondButtonPressed(_ sender: Any) {
        buttonOne.isSelected = false
        buttonTwo.isSelected = true
        buttonThree.isSelected = false
        buttonFour.isSelected = false
        buttonFive.isSelected = false
    }
    
    @IBAction func thirdButtonPressed(_ sender: Any) {
        buttonOne.isSelected = false
        buttonTwo.isSelected = false
        buttonThree.isSelected = true
        buttonFour.isSelected = false
        buttonFive.isSelected = false
    }
    
    @IBAction func fourthButtonPressed(_ sender: Any) {
        buttonOne.isSelected = false
        buttonTwo.isSelected = false
        buttonThree.isSelected = false
        buttonFour.isSelected = true
        buttonFive.isSelected = false
    }
    
    @IBAction func fithButtonPressed(_ sender: Any) {
        buttonOne.isSelected = false
        buttonTwo.isSelected = false
        buttonThree.isSelected = false
        buttonFour.isSelected = false
        buttonFive.isSelected = true
    }
    
    @IBAction func validateButton(_ sender: Any) {
        self.nbOversight.layer.borderWidth = 0
        if buttonOne.isSelected {
            let answer: Answer = Answer.getAnswer(forName: "Toutes les prises")!
            self.rigorousAnswer.answer = answer
            self.performSegue(withIdentifier: "summaryDayRigorousAnswerUnwindSegue", sender: sender)
        }
        else if buttonTwo.isSelected {
            let answer: Answer = Answer.getAnswer(forName: "La plupart des prises")!
            self.rigorousAnswer.answer = answer
            self.performSegue(withIdentifier: "summaryDayRigorousAnswerUnwindSegue", sender: sender)
        }
        else if buttonThree.isSelected {
            let answer: Answer = Answer.getAnswer(forName: "Quelques prises")!
            self.rigorousAnswer.answer = answer
            self.performSegue(withIdentifier: "summaryDayRigorousAnswerUnwindSegue", sender: sender)
        }
        else if buttonFour.isSelected {
            let answer: Answer = Answer.getAnswer(forName: "Aucune des prises")!
            self.rigorousAnswer.answer = answer
            self.performSegue(withIdentifier: "summaryDayRigorousAnswerUnwindSegue", sender: sender)
        }
        else if buttonFive.isSelected {
            if !(nbOversight.text?.isEmpty)! {
                let answer: Answer = Answer.getAnswer(forName: "J'ai oublié x prise(s)")!
                self.rigorousAnswer.answer = answer
                self.rigorousAnswer.nbOversight = nbOversight.text
                self.performSegue(withIdentifier: "summaryDayRigorousAnswerUnwindSegue", sender: sender)
            }
            else{
                self.nbOversight.layer.borderWidth = 1
                self.nbOversight.layer.borderColor = UIColor.red.cgColor
            }
        }
    }

    // MARK: - Navigation -

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "summaryDayRigorousAnswerUnwindSegue" {
            CoreDataManager.save()
        }
    }
}
