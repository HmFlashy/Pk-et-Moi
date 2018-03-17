//
//  OnBoardViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 17/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class OnBoardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func validateFirstTimeAction(_ sender: Any) {
        let typeProfession = TypeProfession.fillDatabase()
        let profession = Profession.fillDatabase()
        profession?.typeProfession = typeProfession
        do {
            try CoreDataManager.context.save()
        } catch {
            print("Error saving context")
            fatalError()
        }
        UserDefaults.standard.set("false", forKey: "firstLaunch")
        performSegue(withIdentifier: "toMainView", sender: sender)
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
