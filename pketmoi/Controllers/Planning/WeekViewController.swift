//
//  WeekViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 24/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import Foundation

class WeekViewController: UIViewController {
    
    @IBOutlet weak var weekLabel: UILabel!
    private var week: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if weekLabel.text == nil {
            weekLabel.text = ""
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setWeek(number: Int){
        self.week = number
        let text: String! = "Semaine " + String(self.week)
        self.weekLabel.text = text
    }
    
    func getWeek() -> Int {
        return self.week!
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
