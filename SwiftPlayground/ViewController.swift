//
//  ViewController.swift
//  SwiftPlayground
//
//  Created by s.wakasugi on 2022/07/08.
//

import UIKit

class ViewController: UIViewController {
    
    let label = UILabel()
    let plainButton = UIButton(type: .system)
    let grayButton = UIButton(type: .system)
    let tintedButton = UIButton(type: .system)
    let filledButton = UIButton(type: .system)
    let pullDownButton = UIButton(type: .system)
    let popUpButton = UIButton(type: .system)

    let stackView = UIStackView()
    
    @IBOutlet weak var sbPullDownButton: UIButton!
    @IBOutlet weak var sbPopUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true

        label.text = "コードで実装したボタン"
        stackView.addArrangedSubview(label)
        
        plainButton.configuration = UIButton.Configuration.plain()
        grayButton.configuration = UIButton.Configuration.gray()
        tintedButton.configuration = UIButton.Configuration.tinted()
        filledButton.configuration = UIButton.Configuration.filled()
        
        addButton(uiButton: plainButton)
        addButton(uiButton: grayButton)
        addButton(uiButton: tintedButton)
        addButton(uiButton: filledButton)

        addPullDownButton(pullDownButton: pullDownButton)
        addPopUpButton(popUpButton: popUpButton)

        // StoryboardのPullDown/PopUpボタンにもメニュー設定
        setPullDownMenu(pullDownButton: sbPullDownButton)
        setPopUpMenu(popUpButton: sbPopUpButton)
        
    }
    
    func addButton(uiButton: UIButton) {
        stackView.addArrangedSubview(uiButton)
        uiButton.setTitle("Button", for: .normal)
    }
    
    
    func addPullDownButton(pullDownButton: UIButton) {
        setPullDownMenu(pullDownButton: pullDownButton)
        pullDownButton.showsMenuAsPrimaryAction = true
        pullDownButton.setTitle("Button", for: .normal)
        stackView.addArrangedSubview(pullDownButton)
    }
    
    func setPullDownMenu(pullDownButton: UIButton) {
        let items = UIMenu(children: [
            UIAction(title: "Edit", image: UIImage(systemName: "pencil"), handler: { _ in print("Edit is tapped")}),
            UIAction(title: "Disabled", attributes: .disabled, handler: { _ in print("Disabled is tapped")}),
            UIAction(title: "Hidden", attributes: .hidden, handler: { _ in print("Hidden is tapped")}),
            UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { _ in print("Delete is tapped")})
        ])
        pullDownButton.menu = items
    }
    
    func addPopUpButton(popUpButton: UIButton) {
        setPopUpMenu(popUpButton: popUpButton)
        popUpButton.showsMenuAsPrimaryAction = true
        popUpButton.changesSelectionAsPrimaryAction = true
        stackView.addArrangedSubview(popUpButton)
    }
    
    func setPopUpMenu(popUpButton: UIButton) {
        let items = UIMenu(children: [
            UIAction(title: "Online Mode", handler: { _ in print("Online mode")}),
            UIAction(title: "Offline Mode", handler: { _ in print("Offline mode")})
        ])
        popUpButton.menu = items
    }
}

