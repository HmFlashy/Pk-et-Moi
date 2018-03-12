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
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var typeActivity: UITextField!
    @IBOutlet weak var descriptionTypeActivity: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
        self.showAnimate()
    }
    
    @IBAction func addTypeActivity(_ sender: Any) {
        guard typeActivity.text != "" else {
            self.removeAnimate()
            return
        }
        let typeActivityName: String = typeActivity.text!
        let descriptionTA: String = descriptionTypeActivity.text
        TypeActivity.createActivity(name: typeActivityName, description: descriptionTA)
        typeActivity.text = ""
        self.removeAnimate()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
}
