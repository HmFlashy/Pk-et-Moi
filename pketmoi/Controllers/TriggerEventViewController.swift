//
//  TriggerEventViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 24/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class TriggerEventViewController: UIViewController {
    
    @IBOutlet weak var typeEventPickerView: TypeEventPickerViewController!
    
    let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var Events: [Event] = []
        do {
            Events  =  try Event.getAllEvents(moc: persistentContainer.viewContext)
        } catch {
            print("Error getting the events")
        }
        
        var names : [String] = []
        for event in Events {
            names.append(event.name!)
        }
        
        typeEventPickerView.typeEvents = names
    }
}
