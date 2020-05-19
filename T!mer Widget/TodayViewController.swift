import UIKit
import SwiftUI
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    var timer: Timer?
    
    var timeDisplay = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        view.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.6)
        
        let boolean = UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "isTimerStarted") as? Bool ?? nil
        
        if (boolean) == false {
            
            let button = UIButton(type: .roundedRect)
            button.setTitle("Start T!mer", for: .normal)
            
            view.addSubview(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchDown)
        } else {
            
            self.timeDisplay.text = ""
            self.timeDisplay.font = UIFont(name: "Helvetica", size: 45)
            self.timeDisplay.textColor = .white
            
            if let checkNil = UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime"), checkNil != nil {
                
                let time = Date().distance(to: checkNil as! Date)
                
                self.timeDisplay.text = String(format: "%02d:%02d", Int(time / 60), Int(time) % 60)
            }
            
            view.addSubview(self.timeDisplay)
            
            self.timeDisplay.translatesAutoresizingMaskIntoConstraints = false
            
            self.timeDisplay.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100).isActive = true
            self.timeDisplay.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        self.timer?.invalidate()
        print("Timer invalidate!")
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    @objc func didTappedButton(_ sender: UIButton) {
        
        print("Button Tapped!")
    }
    
    @objc func fireTimer() {
        
        print("Fire Timer!!!")
        
        if let checkNil = UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime"), checkNil != nil {
            
            let time = Date().distance(to: checkNil as! Date)
            
            if time > 0 { // When timer is running
                
                self.timeDisplay.text = String(format: "%02d:%02d", Int(time / 60), Int(time) % 60)
            }
        }
    }
}

//
//  TodayViewController.swift
//  T!mer Widget
//
//  Created by Aksidion Kreimben on 5/19/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
