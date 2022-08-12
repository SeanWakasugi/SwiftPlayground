//
//  UINavigationController+customBar.swift
//  SwiftPlayground
//
//  Created by s.wakasugi on 2022/08/08.
//

import Foundation
import UIKit

extension UINavigationController {
    func customColorBar(item: UIColor, background: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = background
        appearance.titleTextAttributes = [.foregroundColor: item]
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: item]
        self.navigationBar.tintColor = item
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func defaultBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        self.navigationBar.tintColor = nil
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
}

class firstViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.customColorBar(item: .magenta, background: .black)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.defaultBar()
    }
}

class secondViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.customColorBar(item: .yellow, background: .blue)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.defaultBar()
    }
}

class thirdViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.customColorBar(item: .cyan, background: .red)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.defaultBar()
    }
}
