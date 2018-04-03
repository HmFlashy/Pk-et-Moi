//
//  ShowContactViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 03/04/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class ShowContactViewController: UIViewController {

    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    var contact: Contact!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstnameLabel.text = contact.firstname
        lastnameLabel.text = contact.lastname
        statusLabel.text = contact.status
        phoneLabel.text = contact.phone
        addressLabel.text = contact.address
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
