//
//  TypeEventController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 21/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import SQLite3

class TypeEventController: UIViewController {
    
    
    @IBOutlet weak var typeEventTextArea: UITextField!
    @IBOutlet weak var typeEventtest: UILabel!
    
    let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTypeEvent(_ sender: Any) {
        let typeEventName: String? = typeEventTextArea.text
        var event = Event.createEvent(moc: self.persistentContainer.viewContext, name: typeEventName!)
        
        typeEventTextArea.text = ""
        typeEventtest.text = "\(typeEventName) inserted !"
    }
}

