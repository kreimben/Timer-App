//
//  SettingViewController.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 10/5/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//

import UIKit
import SwiftUI

class SettingViewController: UIHostingController<SettingPageView> {
    
    @objc dynamic required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: SettingPageView())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
