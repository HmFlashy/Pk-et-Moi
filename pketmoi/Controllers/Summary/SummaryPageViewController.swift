//
//  SummaryPageViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 23/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class SummaryPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var summary: Summary!
    var currentDay: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "SummaryDay") as! SummaryDayViewController
        vc.summary = self.summary
        vc.setDay(day: self.currentDay)
        
        setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        self.delegate = self
        self.dataSource = self
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if self.currentDay-1 <= 0 {
            return nil
        }
        self.currentDay = self.currentDay - 1
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SummaryDay") as! SummaryDayViewController
        vc.summary = self.summary
        vc.setDay(day: self.currentDay)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if self.currentDay+1 >= 6 {
            return nil
        }
        self.currentDay = self.currentDay + 1
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SummaryDay") as! SummaryDayViewController
        vc.summary = self.summary
        vc.setDay(day: self.currentDay)
        return vc
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
