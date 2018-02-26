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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var TypeEvents: [TypeEvent] = []
        do {
            TypeEvents  =  try TypeEvent.getAllEvents()
        } catch {
            print("Error getting the events")
        }
        
        var names : [String] = []
        for typeEvent in TypeEvents {
            names.append(typeEvent.name!)
        }
        
        typeEventPickerView.typeEvents = names
    }
}
