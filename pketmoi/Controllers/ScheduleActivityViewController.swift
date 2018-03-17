//
//  ScheduleActivityViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 12/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class ScheduleActivityViewController: UIViewController {
    
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var typeActivityName: UILabel!
    var typeActivity: TypeActivity? = nil
    var containerView: ActivityContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeActivityName.text = typeActivity?.name
    }
    
    @IBAction func changeValue(_ sender: Any) {
        if(switchButton.isOn){
            containerView!.segueIdentifierReceivedFromParent(switchButton: "Regular")
        } else{
            containerView!.segueIdentifierReceivedFromParent(switchButton: "NotRegular")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            containerView = segue.destination as! ActivityContainerViewController
            containerView?.typeActivity = self.typeActivity
        }
    }
}
