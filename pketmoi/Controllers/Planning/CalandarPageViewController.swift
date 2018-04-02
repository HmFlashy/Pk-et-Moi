//
//  CalandarPageViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 24/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import Foundation

class CalandarPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    private var weekViewControllers: [WeekViewController]! = []
    private var CURRENT_WEEK: Int? = nil
    private var pageIsAnimating: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        let calendar = Calendar.current
        CURRENT_WEEK = calendar.component(.weekOfYear, from: Date())
        self.weekViewControllers.append(newWeekViewController(weekNumber: CURRENT_WEEK!))
        self.setViewControllers(weekViewControllers, direction: .forward, animated: false, completion: nil)
        self.weekViewControllers.append(newWeekViewController(weekNumber: CURRENT_WEEK! + 1))
        self.weekViewControllers.append(newWeekViewController(weekNumber: CURRENT_WEEK! + 2))
        // Do any additional setup after loading the view.
    }
    
    private func newWeekViewController(weekNumber: Int) -> WeekViewController {
        let weekController: WeekViewController =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeekViewController") as! WeekViewController
        _ = weekController.view
        weekController.setWeek(number: weekNumber)
        return weekController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: - Delegate Protocols
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    }

    // MARK: - Data Source Protocols
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let weekViewController: WeekViewController = viewController as! WeekViewController
        let week = weekViewController.getWeek() - 1
        return self.newWeekViewController(weekNumber: week)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let weekViewController: WeekViewController = viewController as! WeekViewController
        let week = weekViewController.getWeek() + 1
        return self.newWeekViewController(weekNumber: week)
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
