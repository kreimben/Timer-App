//
//  StopwatchViewController.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 10/5/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//

import UIKit
import SwiftUI

import CommonT_mer

class StopwatchViewController: UIHostingController<StopwatchWrapper> {
    
    private var userSettings = CTUserSettings()
    
    @objc dynamic required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder, rootView: StopwatchWrapper())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct StopwatchWrapper: View {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var body: some View {
        
        StopwatchView().environment(\.managedObjectContext, context)
    }
}
