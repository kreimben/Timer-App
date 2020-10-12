import UIKit

import CommonT_mer

class MainTabBarViewController: UITabBarController {
    
    var userSettings = CTUserSettings()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = CTColorScheme.getUIColor(self.userSettings.colorIndex, red: 0, green: -0.1, blue: 0, alpha: 1)
    }

}

//
//  MainTabBarViewController.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/23/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
