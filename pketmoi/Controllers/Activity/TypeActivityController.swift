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
        var errors = false
        if typeActivity.text!.isEmpty {
            errors = true
            typeActivity.layer.borderWidth = 1
            typeActivity.layer.borderColor = UIColor.red.cgColor
        }
        else {
            typeActivity.layer.borderWidth = 0
        }
        if !errors{
            _ = TypeActivity.createTypeActivity(name: typeActivity.text!, description: descriptionTypeActivity.text)
            self.removeAnimate()
        }
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
    
    @IBAction func returnButton(_ sender: Any) {
        removeAnimate()
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.dismiss(animated: true, completion: nil)
            }
        });
    }
}
