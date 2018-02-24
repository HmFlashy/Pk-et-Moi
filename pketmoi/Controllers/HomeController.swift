//
//  HomeController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 21/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var buttonTriggerEvent: UIButton!
    @IBOutlet weak var buttonProgramActivity: UIButton!
    @IBOutlet weak var buttonSynthesis: UIButton!
    @IBOutlet weak var buttonProgramDrugs: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonTriggerEvent.layer.borderColor = UIColor.black.cgColor
        buttonTriggerEvent.layer.borderWidth = 2
        buttonTriggerEvent.titleLabel?.textAlignment = NSTextAlignment.center
        
        buttonProgramActivity.layer.borderColor = UIColor.black.cgColor
        buttonProgramActivity.layer.borderWidth = 2
        buttonProgramActivity.titleLabel?.textAlignment = NSTextAlignment.center
        
        buttonSynthesis.layer.borderColor = UIColor.black.cgColor
        buttonSynthesis.layer.borderWidth = 2
        buttonSynthesis.titleLabel?.textAlignment = NSTextAlignment.center
        
        buttonProgramDrugs.layer.borderColor = UIColor.black.cgColor
        buttonProgramDrugs.layer.borderWidth = 2
        buttonProgramDrugs.titleLabel?.textAlignment = NSTextAlignment.center
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


