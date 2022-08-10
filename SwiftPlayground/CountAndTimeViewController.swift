//
//  CountAndTimeViewController.swift
//  SwiftPlayground
//
//  Created by s.wakasugi on 2022/08/10.
//

import UIKit

class CountAndTimeViewController: UIViewController {
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeButton: UIButton!
    
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countLabel.text = String(count)
        setTimeLabel()
    }
    
    @IBAction func didPressCountButton(_ sender: UIButton) {
        countUp()
            
    }
    
    @IBAction func didPressTimeButton(_ sender: UIButton) {
        setTimeLabel()
    }
    
    func countUp() {
        count = count + 1
        countLabel.text = String(count)
    }
    
    func setTimeLabel() {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        timeLabel.text = formatter.string(from: Date())
    }
}
