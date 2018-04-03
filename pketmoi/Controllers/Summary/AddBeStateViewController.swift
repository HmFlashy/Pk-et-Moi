//
//  AddBeStateViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 03/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class AddBeStateViewController: UIViewController {

    var beState: BeState!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var onButton: CustomRadioButton!
    @IBOutlet weak var offButton: CustomRadioButton!
    @IBOutlet weak var dyskinesiesButton: CustomRadioButton!
    @IBOutlet weak var onLabel: UILabel!
    @IBOutlet weak var offLabel: UILabel!
    @IBOutlet weak var dyskinesiesLabel: UILabel!
    
    fileprivate lazy var stateFetched: NSFetchedResultsController<State> = {
        let request: NSFetchRequest<State> = State.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(State.name), ascending: false)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            try self.stateFetched.performFetch()
        } catch {
            print("Unable to perfom fetch")
        }
        
        self.onLabel.text = stateFetched.object(at: IndexPath(row: 0, section: 0)).name
        self.offLabel.text = stateFetched.object(at: IndexPath(row: 1, section: 0)).name
        self.dyskinesiesLabel.text = stateFetched.object(at: IndexPath(row: 2, section: 0)).name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   }
    
    @IBAction func onPressed(_ sender: CustomRadioButton) {
        onButton.isSelected = true
        offButton.isSelected = false
        dyskinesiesButton.isSelected = false
    }
    
    @IBAction func offPressed(_ sender: CustomRadioButton) {
        offButton.isSelected = true
        onButton.isSelected = false
        dyskinesiesButton.isSelected = false
    }
    
    @IBAction func dyskinesiesPressed(_ sender: CustomRadioButton) {
        dyskinesiesButton.isSelected = true
        onButton.isSelected = false
        offButton.isSelected = false
    }
    
    @IBAction func savePressed(_ sender: Any) {
        if onButton.isSelected || offButton.isSelected || dyskinesiesButton.isSelected {
            if onButton.isSelected{
                self.beState.state = stateFetched.object(at: IndexPath(row: 0, section: 0))
            }
            else if offButton.isSelected{
                self.beState.setValue(stateFetched.object(at: IndexPath(row: 1, section: 0)), forKey: "state")
            }
            else{
                self.beState.state = stateFetched.object(at: IndexPath(row: 2, section: 0))
            }
            self.performSegue(withIdentifier: "summaryDayUnwindSegue", sender: self)
        }
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
