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
        var errors = false
        if typeEventTextArea.text!.isEmpty{
            errors = true
            typeEventTextArea.layer.borderWidth = 1
            typeEventTextArea.layer.borderColor = UIColor.red.cgColor
        }
        else {
            typeEventTextArea.layer.borderWidth = 0
        }
        guard !errors else {
            return
        }
        _ = TypeEvent.createTypeEvent(name: typeEventTextArea.text!)
        typeEventTextArea.text = ""
        typeEventTextArea.layer.borderColor = UIColor.white.cgColor
    }
}

