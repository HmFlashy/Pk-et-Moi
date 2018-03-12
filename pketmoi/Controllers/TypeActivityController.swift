//
//  TypeActivityController.swift
//  pketmoi
//
//  Created by Loris Zirah on 11/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class TypeActivityController: UIViewController{
    
    @IBOutlet weak var typeActivity: UITextField!
    @IBOutlet weak var descriptionTypeActivity: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTypeActivity(_ sender: Any) {
        guard typeActivity.text != "" else {
            return self.view.removeFromSuperview()
        }
        let typeActivityName: String = typeActivity.text!
        let descriptionTA: String = descriptionTypeActivity.text
        TypeActivity.createActivity(name: typeActivityName, description: descriptionTA)
        typeActivity.text = ""
        self.view.removeFromSuperview()
    }
}
