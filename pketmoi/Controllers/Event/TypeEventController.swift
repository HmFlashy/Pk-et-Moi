//
//  TypeEventController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 21/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class TypeEventController: UIViewController {
    
    @IBOutlet weak var typeEventTextArea: UITextField!
    @IBOutlet weak var typeEventTableView: TypeEventTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTypeEvent(_ sender: Any) {
        guard let typeEventName = typeEventTextArea.text else{return}
        guard !typeEventName.isEmpty else {return}
        _ = TypeEvent.createTypeEvent(name: typeEventName)
        typeEventTextArea.text = ""
    }
}

