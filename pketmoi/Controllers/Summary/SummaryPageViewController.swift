//
//  SummaryPageViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 23/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class SummaryPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {
    
    var summary: Summary!
    
    lazy var viewControllerList:[UIViewController] = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "SummaryDayOne") as! SummaryDayOneViewController
        vc1.summary = self.summary
        let vc2 = sb.instantiateViewController(withIdentifier: "SummaryDayTwo") as! SummaryDayTwoViewController
        vc2.summary = self.summary
        
        return [vc1, vc2]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstViewController = viewControllerList.first{
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        self.dataSource = self
        self.delegate = self
        if let firstVC = viewControllerList.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        for subView in view.subviews {
            if subView is UIScrollView {
                (subView as! UIScrollView).delegate = self
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard viewControllerList.count > previousIndex else{return nil}
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        let nextIndex = vcIndex + 1
        guard viewControllerList.count > nextIndex else {return nil}
        return viewControllerList[nextIndex]
    }

// MARK: - Scroll View Delegate

public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let point = scrollView.contentOffset
    var percentComplete: CGFloat
    percentComplete = fabs(point.x - view.frame.size.width)/view.frame.size.width
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
