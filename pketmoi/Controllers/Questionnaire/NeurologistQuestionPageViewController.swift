//
//  NeurologistQuestionPageViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 01/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class NeurologistQuestionPageViewController: UIPageViewController {

    var vcs : [UIViewController] = []
    var summary: Summary!
    var currentVC: Int!
    
    fileprivate lazy var neurologistQuestionFetched: NSFetchedResultsController<NeurologistQuestion> = {
        let request: NSFetchRequest<NeurologistQuestion> = NeurologistQuestion.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(NeurologistQuestion.number), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(summary)
        // Creating neurologistQuestion
//        _ = NeurologistQuestion.createNeurologistQuestion(name: "Akinésies de début de dose", number: 1)
//        _ = NeurologistQuestion.createNeurologistQuestion(name: "Akinésies de fin de dose", number: 2)
//        _ = NeurologistQuestion.createNeurologistQuestion(name: "Dystonie du gros orteil", number: 3)
//        _ = NeurologistQuestion.createNeurologistQuestion(name: "Dyskinésies invalidantes", number: 4)
//        _ = NeurologistQuestion.createNeurologistQuestion(name: "Effet On/Off", number: 5)
//        _ = NeurologistQuestion.createNeurologistQuestion(name: "Fluctuations non motrices", number: 6)
//        _ = NeurologistQuestion.createNeurologistQuestion(name: "Hallucinations", number: 7)
//        _ = NeurologistQuestion.createNeurologistQuestion(name: "Freezing", number: 8)

        
        do{
            try neurologistQuestionFetched.performFetch()
        } catch {
            print("Unable to perform Neurologist question fetch")
        }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: "NeurologistFirstQuestion") as! NeurologistFirstQuestionViewController
        vc1.neurologistQuestion = self.neurologistQuestionFetched.object(at: IndexPath(row: 0, section: 0))
        self.vcs.append(vc1)
        vc1.summary = self.summary
        
        let vc2 = sb.instantiateViewController(withIdentifier: "NeurologistQuestion") as! NeurologistQuestionViewController
        vc2.neurologistQuestion = self.neurologistQuestionFetched.object(at: IndexPath(row: 1, section: 0))
        self.vcs.append(vc2)
        vc2.summary = self.summary

        let vc3 = sb.instantiateViewController(withIdentifier: "NeurologistQuestion") as! NeurologistQuestionViewController
        vc3.neurologistQuestion = self.neurologistQuestionFetched.object(at: IndexPath(row: 2, section: 0))
        self.vcs.append(vc3)
        vc3.summary = self.summary

        let vc4 = sb.instantiateViewController(withIdentifier: "NeurologistQuestion") as! NeurologistQuestionViewController
        vc4.neurologistQuestion = self.neurologistQuestionFetched.object(at: IndexPath(row: 3, section: 0))
        self.vcs.append(vc4)
        vc4.summary = self.summary

        let vc5 = sb.instantiateViewController(withIdentifier: "NeurologistQuestion") as! NeurologistQuestionViewController
        vc5.neurologistQuestion = self.neurologistQuestionFetched.object(at: IndexPath(row: 4, section: 0))
        self.vcs.append(vc5)
        vc5.summary = self.summary
        
        let vc6 = sb.instantiateViewController(withIdentifier: "NeurologistQuestion") as! NeurologistQuestionViewController
        vc6.neurologistQuestion = self.neurologistQuestionFetched.object(at: IndexPath(row: 5, section: 0))
        self.vcs.append(vc6)
        vc6.summary = self.summary
        
        let vc7 = sb.instantiateViewController(withIdentifier: "NeurologistQuestion") as! NeurologistQuestionViewController
        vc7.neurologistQuestion = self.neurologistQuestionFetched.object(at: IndexPath(row: 6, section: 0))
        self.vcs.append(vc7)
        vc7.summary = self.summary
        
        let vc8 = sb.instantiateViewController(withIdentifier: "NeurologistLastQuestion") as! NeurologistLastQuestionViewController
        vc8.neurologistQuestion = self.neurologistQuestionFetched.object(at: IndexPath(row: 7, section: 0))
        vc8.summary = self.summary
        self.vcs.append(vc8)
        
        self.currentVC = 1
        setViewControllers([vcs[self.currentVC-1]], direction: .forward, animated: true, completion: nil)
    }
    
    func nextPage(){
        if self.currentVC + 1 < 9{
            self.currentVC = self.currentVC + 1
        }
        setViewControllers([vcs[self.currentVC-1]], direction: .forward, animated: true, completion: nil)
    }
    
    func previousPage(){
        if self.currentVC - 1 > 0 {
            self.currentVC = self.currentVC - 1
        }
        setViewControllers([vcs[self.currentVC-1]], direction: .reverse, animated: true, completion: nil)
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
