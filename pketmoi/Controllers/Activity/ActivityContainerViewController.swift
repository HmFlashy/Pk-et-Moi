//
//  ContainerViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 13/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class ActivityContainerViewController: UIViewController {
    
    var vc : UIViewController!
    var segueIdentifier : String!
    var lastViewController: UIViewController!
    var typeActivity : TypeActivity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segueIdentifierReceivedFromParent(switchButton: "NotRegular")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segueIdentifierReceivedFromParent(switchButton: String){
        if switchButton == "NotRegular"
        {
            self.segueIdentifier = "NotRegular"
            self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
        }
        else if switchButton == "Regular"
        {
            self.segueIdentifier = "Regular"
            self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
        }
    }
    
    // MARK: - Navigation -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier{
            //Avoids creation of a stack of view controllers
            if lastViewController != nil{
                lastViewController.view.removeFromSuperview()
            }
            //Adds View Controller to Container "first" or "second"
            if segue.identifier == "NotRegular"{
                vc = segue.destination
                let notRegularVC = vc as! ScheduleActivityNotRegularViewController
                notRegularVC.typeActivity = self.typeActivity
            }
            else{ //Regular
                vc = segue.destination as! ScheduleActivityRegularViewController
                let regularVC = vc as! ScheduleActivityRegularViewController
                regularVC.typeActivity = self.typeActivity
            }
            self.addChildViewController(vc)
            vc.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
            self.view.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
            lastViewController = vc
        }
    }
}
