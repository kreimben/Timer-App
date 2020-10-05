//
//  StopwatchViewController.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 10/5/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//

import UIKit
import SwiftUI

class StopwatchViewController: UIHostingController<StopwatchView> {
    
    @objc dynamic required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder, rootView: StopwatchView())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
