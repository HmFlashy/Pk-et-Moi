//
//  AdditionalInformationViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 18/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class AdditionalInformationViewController: UIViewController {

    @IBOutlet weak var textArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveData(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(textArea.text, forKey: "AdditionalInformation")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
