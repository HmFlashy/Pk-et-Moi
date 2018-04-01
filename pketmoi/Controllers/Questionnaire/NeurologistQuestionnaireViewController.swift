//
//  NeurologistQuestionnaireViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 01/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class NeurologistQuestionnaireViewController: UIViewController {

    var summary: Summary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation -

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "neurologistPageViewSegue" {
            let vc = segue.destination as! NeurologistQuestionPageViewController
            vc.summary = self.summary
        }
    }
}
