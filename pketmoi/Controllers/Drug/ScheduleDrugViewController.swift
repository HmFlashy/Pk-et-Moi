//
//  ScheduleDrugViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 21/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class ScheduleDrugViewController: UIViewController {

    @IBOutlet weak var typeDrugName: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    var typeDrug: TypeDrug? = nil
    var containerView: DrugContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeDrugName.text = typeDrug?.name
    }
    
    @IBAction func changeValue(_ sender: Any) {
        if(switchButton.isOn){
            containerView!.segueIdentifierReceivedFromParent(switchButton: "Regular")
        } else{
            containerView!.segueIdentifierReceivedFromParent(switchButton: "NotRegular")
        }
    }
    
    // MARK: - Navigation -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            containerView = segue.destination as? DrugContainerViewController
            containerView?.typeDrug = self.typeDrug
        }
    }
}
