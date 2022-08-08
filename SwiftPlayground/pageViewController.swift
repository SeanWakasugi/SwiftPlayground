//
//  pageViewController.swift
//  SwiftPlayground
//
//  Created by s.wakasugi on 2022/08/05.
//

import UIKit

class pageViewController: UIPageViewController {

    var controllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let first = storyboard!.instantiateViewController(withIdentifier: "firstView")
        let second = storyboard!.instantiateViewController(withIdentifier: "secondView")
        let third = storyboard!.instantiateViewController(withIdentifier: "thirdView")

        controllers = [first, second, third]
        setViewControllers([controllers[0]], direction: .forward, animated: true)
        dataSource = self
    }
}

extension pageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        if index < controllers.count - 1 {
            return controllers[index + 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        if index > 0 {
            return controllers[index - 1]
        } else {
            return nil
        }
    }
    
    
}
