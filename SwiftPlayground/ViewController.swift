//
//  ViewController.swift
//  SwiftPlayground
//
//  Created by s.wakasugi on 2022/07/08.
//

import UIKit

class ViewController: UIViewController {
    
    let button = UIButton(type: .system)
    let grayButton = UIButton(type: .system)
    let tintedButton = UIButton(type: .system)
    let filledButton = UIButton(type: .system)
    let pullDownButton = UIButton(type: .system)
    let popUpButton = UIButton(type: .system)

    let imageButton = UIButton(type: .system)
    let grayImageButton = UIButton(type: .system)
    let tintedImageButton = UIButton(type: .system)
    let filledImageButton = UIButton(type: .system)
    let imageTextButton = UIButton(type: .system)
    
    let stackView = UIStackView()
    let leftStackView = UIStackView()
    let rightStackView = UIStackView()

    
    @IBOutlet weak var sbButton: UIButton!
    @IBOutlet weak var sbGrayButton: UIButton!
    @IBOutlet weak var sbTintedButton: UIButton!
    @IBOutlet weak var sbFilledButton: UIButton!
    @IBOutlet weak var sbPullDownButton: UIButton!
    @IBOutlet weak var sbPopUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true

        addStackView(subStackView: leftStackView)
        addStackView(subStackView: rightStackView)
        
        button.configuration = UIButton.Configuration.plain()
        button.isEnabled = false
        grayButton.configuration = UIButton.Configuration.gray()
        grayButton.isEnabled = false
        tintedButton.configuration = UIButton.Configuration.tinted()
        tintedButton.isEnabled = false
        filledButton.configuration = UIButton.Configuration.filled()
        filledButton.isEnabled = false
        
        imageButton.configuration = UIButton.Configuration.plain()
        grayImageButton.configuration = UIButton.Configuration.gray()
        tintedImageButton.configuration = UIButton.Configuration.tinted()
        filledImageButton.configuration = UIButton.Configuration.filled()
        imageTextButton.configuration = UIButton.Configuration.filled()
        imageTextButton.setTitle("Edit", for: .normal)
        

        setPullDownMenuForButton(uiButton: pullDownButton)
        setPopUpMenuForButton(uiButton: popUpButton)
        popUpButton.changesSelectionAsPrimaryAction = true
        
        setPullDownMenuForButton(uiButton: sbPullDownButton)
        setPopUpMenuForButton(uiButton: sbPopUpButton)

        
        addButton(uiButton: button)
        addButton(uiButton: grayButton)
        addButton(uiButton: tintedButton)
        addButton(uiButton: filledButton)
        addButton(uiButton: pullDownButton)
        leftStackView.addArrangedSubview(popUpButton)
        
        addImageButton(imageButton: imageButton)
        addImageButton(imageButton: grayImageButton)
        addImageButton(imageButton: tintedImageButton)
        addImageButton(imageButton: filledImageButton)
        addImageButton(imageButton: imageTextButton)
        
    }

    func addStackView(subStackView: UIStackView) {
        stackView.addArrangedSubview(subStackView)
        subStackView.axis = .vertical
        subStackView.distribution = .equalSpacing
        subStackView.spacing = 10
        subStackView.alignment = .center
    }
    
    func addButton(uiButton: UIButton) {
        leftStackView.addArrangedSubview(uiButton)
        uiButton.setTitle("Button", for: .normal)
    }
    
    func addImageButton(imageButton: UIButton) {
        rightStackView.addArrangedSubview(imageButton)
        imageButton.setImage(UIImage(systemName: "pencil"), for: .normal)
    }
    
    func setPullDownMenuForButton(uiButton: UIButton) {
        let items = UIMenu(children: [
            UIAction(title: "Edit", image: UIImage(systemName: "pencil"), handler: { _ in print("Edit is tapped")}),
            UIAction(title: "Disabled", attributes: .disabled, handler: { _ in print("Disabled is tapped")}),
            UIAction(title: "Hidden", attributes: .hidden, handler: { _ in print("Hidden is tapped")}),
            UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { _ in print("Delete is tapped")})
        ])
        
        uiButton.menu = items
        uiButton.showsMenuAsPrimaryAction = true
    }
    
    func setPopUpMenuForButton(uiButton: UIButton) {
        let items = UIMenu(children: [
            UIAction(title: "Online Mode", handler: { _ in print("Online mode")}),
            UIAction(title: "Offline Mode", handler: { _ in print("Offline mode")})
        ])
        
        uiButton.menu = items
        uiButton.showsMenuAsPrimaryAction = true
    }
}

