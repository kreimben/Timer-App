import UIKit
import Combine

import CommonT_mer

class MainTabBarViewController: UITabBarController {
    
    private var userSettings = CTUserSettings()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeTabBar), name: .changeTabBarColor, object: nil)
        
        self.changeTabBar()
    }
}

extension MainTabBarViewController {
    
    @objc
    func changeTabBar() {
        
//        print("Changed!")
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .systemGray4
        self.tabBar.barTintColor = UIColor(CTColorScheme.getColor(self.userSettings.colorIndex))
    }
}

//
//  MainTabBarViewController.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/23/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
