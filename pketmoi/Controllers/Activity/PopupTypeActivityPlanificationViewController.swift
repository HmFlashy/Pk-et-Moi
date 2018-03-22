//
//  PopupTypeActivityPlanificationViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 11/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class PopupTypeActivityPlanificationViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
    }
    
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
