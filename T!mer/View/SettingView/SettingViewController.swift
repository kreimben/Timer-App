//
//  SettingViewController.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 10/5/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//

import UIKit
import SwiftUI

import CommonT_mer

class SettingViewController: UIHostingController<SettingPageView> {
    
    private var userSettings = CTUserSettings()
    
    @objc dynamic required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: SettingPageView())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
