import UIKit

import CommonT_mer

class MainTabBarViewController: UITabBarController {
    
    var userSettings = CTUserSettings()

    override func viewDidLoad() {
        super.viewDidLoad()

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
