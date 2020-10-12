//
//  TimerViewController.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 10/5/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData

import CommonT_mer

class TimerViewController: UIHostingController<TimerVCWrapper> {
    
    private var userSettings = CTUserSettings()
    
    @objc dynamic required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder, rootView: TimerVCWrapper())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.barTintColor = UIColor(CTColorScheme.getColor(self.userSettings.colorIndex))
    }
}

struct TimerVCWrapper: View {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var body: some View {
        
        ContentView().environment(\.managedObjectContext, context)
    }
}
