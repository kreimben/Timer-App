import UIKit
import SwiftUI
import NotificationCenter

import CommonT_mer

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet var baseView: UIView!
    
    var timer: Timer?
    
    var timeDisplay = UILabel()
    
    var mainController = CTMainController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        view.backgroundColor = .clear
        
        let boolean = self.mainController.isTimerRunning()
        
        let checkNil = UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime")
        
        let time = Date().distance(to: checkNil as? Date ?? Date())
        
        print("isTimerStarted: \(String(describing: boolean))")
        
        self.baseView.backgroundColor = .clear
        
        if (boolean && time > 0) == false {
            
            let button = UIButton(type: .roundedRect)
            button.setTitle("Start T!mer", for: .normal)
            button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)!
            
            if traitCollection.userInterfaceStyle == .light {
                button.tintColor = .white
            } else {
                button.tintColor = UIColor(red: 0.5, green: 0, blue: 0, alpha: 1)
            }
            
            let roundedRectangle = RoundedRectangleView(frame: CGRect(
                x: view.bounds.midX - 10,
                y: button.bounds.minY + 24,
                width: 180,
                height: 60
            ))
            
            roundedRectangle.backgroundColor = .clear
            
            view.addSubview(roundedRectangle)
            view.addSubview(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80).isActive = true
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchDown)
            
            let circleView = CircleView(frame: CGRect(
                x: self.baseView.bounds.minX,
                y: self.baseView.bounds.minY,
                width: self.baseView.frame.width,
                height: self.baseView.frame.height
            ))
            
            circleView.backgroundColor = .clear
            
            self.baseView.addSubview(circleView)
        } else {
            
            print("boolean: \(String(describing: boolean))")
            
            self.timeDisplay.font = UIFont(name: "Helvetica", size: 45)
            self.timeDisplay.textColor = .white
            
            if let checkNil = UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime") {
                
                let time = Date().distance(to: checkNil as! Date)
                
                print("time: \(time)")
                
                self.timeDisplay.text = String(format: "%02d:%02d", Int(time / 60), Int(time) % 60)
            }
            
            let circleView = CircleView(frame: CGRect(
                x: self.baseView.bounds.minX,
                y: self.baseView.bounds.minY,
                width: self.baseView.frame.width,
                height: self.baseView.frame.height
            ))
            
            circleView.backgroundColor = .clear
            
            self.baseView.addSubview(circleView)
            view.addSubview(self.timeDisplay)
            
            self.timeDisplay.translatesAutoresizingMaskIntoConstraints = false
            
            self.timeDisplay.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 96).isActive = true
            self.timeDisplay.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        }
    }
    
    // MARK: - viewDidDisappear
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
        
        if let url = NSURL(string: "Timer_openApp://") {
            print("URL set OK")
            extensionContext?.open(url as URL) { message in
                
                print("Open App Completion Result: \(message.description)")
            }
        }
    }
    
    // MARK: - Timer
    @objc func fireTimer() {
        
        if let checkNil = UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime"), self.mainController.isTimerRunning() == true {
            
            let time = Date().distance(to: checkNil as! Date)
            
            print(time)
            
            if time > 0 { // When timer is running
                
                self.timeDisplay.text = String(format: "%02d:%02d", Int(time / 60), Int(time) % 60)
                
                let circleView = CircleView(frame: CGRect(
                    x: self.baseView.bounds.minX,
                    y: self.baseView.bounds.minY,
                    width: self.baseView.frame.width,
                    height: self.baseView.frame.height
                ))
                
                circleView.backgroundColor = .clear
                
                self.baseView.addSubview(circleView)
            } else {
                
                self.timer?.invalidate()
                UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.synchronize()
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
