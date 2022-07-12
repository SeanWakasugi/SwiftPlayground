//
//  ViewController.swift
//  SwiftPlayground
//
//  Created by s.wakasugi on 2022/07/08.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    let testNotificationButton = UIButton(type: .system)
    let setNotificationButton = UIButton(type: .system)
    let datePicker = UIDatePicker()
    
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound], completionHandler: { (granted, error) in })
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        
        stackView.addArrangedSubview(testNotificationButton)
        testNotificationButton.setTitle("通知のテスト", for: .normal)
        testNotificationButton.configuration = UIButton.Configuration.plain()
        testNotificationButton.addTarget(self, action: #selector(testNotification(sender:)), for: .touchUpInside)
        
        stackView.addArrangedSubview(datePicker)
        datePicker.preferredDatePickerStyle = .inline
        
        stackView.addArrangedSubview(setNotificationButton)
        setNotificationButton.configuration = UIButton.Configuration.filled()
        setNotificationButton.setTitle("通知日時設定", for: .normal)
        setNotificationButton.addTarget(self, action: #selector(setNotification(sender: )), for: .touchUpInside)
    }
    
    @objc func testNotification(sender: UIButton) {
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 0.5, repeats: false)
        showNotification(trigger: trigger)
    }
    
    @objc func setNotification(sender: UIButton) {
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: datePicker.date)
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponents, repeats: false)
        showNotification(trigger: trigger)
    }
    
    func showNotification(trigger: UNNotificationTrigger) {
        let content = UNMutableNotificationContent()
        content.title = "Notification"
        content.body = "This is a notification"
        content.sound = UNNotificationSound.default
        let trigger = trigger
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest.init(identifier: uuidString, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in print(error as Any) }
        print(trigger)
    }
}

extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
