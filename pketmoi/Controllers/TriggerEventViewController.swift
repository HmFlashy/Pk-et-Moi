//
//  TriggerEventViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 24/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class TriggerEventViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var typeEventPickerView: TypeEventPickerViewController!
    
    @IBOutlet weak var dataPicker: UIDatePicker!
    
    @IBOutlet weak var descriptionTextArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTriggerEvent(_ sender: Any) {
        var event: Event = Event(context: CoreDataManager.context)
        event.belongsTo = typeEventPickerView.selectedTypeEvent
        print(event.belongsTo?.name)
        print(dataPicker.date)
        event.date = dataPicker.date
        event.eventDescription = descriptionTextArea.text
        do {
            try CoreDataManager.context.save()
        } catch {
            print("Erreur")
        }
        
        
    }
}
