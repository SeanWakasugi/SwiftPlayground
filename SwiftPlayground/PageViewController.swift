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
    
    var cacheIndex: Int?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPageViewController" {
            self.pageViewController = segue.destination as? PageViewController
            pageViewController.delegate = self
        }
    }
    
    override func viewDidLoad() {
        pageControl.numberOfPages = pageViewController.controllers.count
        didMovePage()
    }
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        view.isUserInteractionEnabled = false
        pageViewController.goPreviousPage() { [weak self] in
            self?.didMovePage()
        }
    }
    
    @IBAction func didPressNextButton(_ sender: UIButton) {
        view.isUserInteractionEnabled = false
        pageViewController.goNextPage() { [weak self] in
            self?.didMovePage()
        }
    }
    
    func didMovePage() {
        pageControl.currentPage = pageViewController.index
        if pageViewController.index == 0 {
            backButton.isHidden = true
        } else if pageViewController.index == pageViewController.controllers.count - 1 {
            nextButton.isHidden = true
        } else {
            backButton.isHidden = false
            nextButton.isHidden = false
        }
        view.isUserInteractionEnabled = true
    }
}

extension RootPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            self.pageViewController.index = cacheIndex!
            didMovePage()
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let index = self.pageViewController.controllers.firstIndex(of: pendingViewControllers.first!) {
            cacheIndex = index
        }
    }
}

class PageViewController: UIPageViewController {
    
    var controllers: [UIViewController] = []
    
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let first = storyboard!.instantiateViewController(withIdentifier: "firstPage")
        let second = storyboard!.instantiateViewController(withIdentifier: "secondPage")
        let third = storyboard!.instantiateViewController(withIdentifier: "thirdPage")
        
        controllers = [first, second, third]
        setViewControllers([controllers[index]], direction: .forward, animated: true)
        dataSource = self
    }
    
    func goPreviousPage(completion: @escaping (()-> Void)) {
        index = index - 1
        setViewControllers([controllers[index]], direction: .reverse, animated: true) {isFinished in
            if isFinished {
                completion()
            }
        }
    }
    
    func goNextPage(completion: @escaping (()-> Void)) {
        index = index + 1
        setViewControllers([controllers[index]], direction: .forward, animated: true) {isFinished in
            if isFinished {
                completion()
            }
        }
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if index < controllers.count - 1 {
            return controllers[index + 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if index > 0 {
            return controllers[index - 1]
        } else {
            return nil
        }
    }
}


