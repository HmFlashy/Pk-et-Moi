//
//  EventController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 21/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class EventController: UIViewController {
    
    
    
    @IBOutlet weak var buttonTriggerEvent: UIButton!
    @IBOutlet weak var buttonAddEvent: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString)

        buttonTriggerEvent.layer.cornerRadius = 8
        buttonAddEvent.layer.cornerRadius = 8
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
