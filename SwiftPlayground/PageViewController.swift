//
//  pageViewController.swift
//  SwiftPlayground
//
//  Created by s.wakasugi on 2022/08/05.
//

import UIKit

class RootPageViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var pageViewController: PageViewController!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPageViewController" {
            self.pageViewController = segue.destination as? PageViewController
        }
    }
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        pageViewController.setViewControllers([pageViewController.controllers[0]], direction: .reverse, animated: true)
    }
    
    @IBAction func didPressNextButton(_ sender: UIButton) {
        pageViewController.setViewControllers([pageViewController.controllers[2]], direction: .forward, animated: true)
    }
    
    
}

class PageViewController: UIPageViewController {

    var controllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let first = storyboard!.instantiateViewController(withIdentifier: "firstPage")
        let second = storyboard!.instantiateViewController(withIdentifier: "secondPage")
        let third = storyboard!.instantiateViewController(withIdentifier: "thirdPage")

        controllers = [first, second, third]
        setViewControllers([controllers[0]], direction: .forward, animated: true)
        dataSource = self
    }
}

extension PageViewController: UIPageViewControllerDataSource {
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
