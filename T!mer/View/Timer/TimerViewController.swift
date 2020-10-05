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

class TimerViewController: UIHostingController<TimerVCWrapper> {
    
    @objc dynamic required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder, rootView: TimerVCWrapper())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

struct TimerVCWrapper: View {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var body: some View {
        
        ContentView().environment(\.managedObjectContext, context)
    }
}
