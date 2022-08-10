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
    
    var isTimerOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countLabel.text = String(count)
        setTimeLabel()
    }
    
    @IBAction func didPressCountButton(_ sender: UIButton) {
        isTimerOn = !isTimerOn
        if isTimerOn {
            sender.setTitle("Stop", for: .normal)
            countUp()
        } else {
            sender.setTitle("Start", for: .normal)
        }
    }
    
    @IBAction func didPressTimeButton(_ sender: UIButton) {
        setTimeLabel()
    }
    
    func countUp() {
        DispatchQueue.global().async {
            while self.isTimerOn {
                Thread.sleep(forTimeInterval: 0.5)
                self.count = self.count + 1
                DispatchQueue.main.async {
                    self.countLabel.text = String(self.count)
                }
            }
        }
    }
    
    func setTimeLabel() {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        timeLabel.text = formatter.string(from: Date())
    }
}
