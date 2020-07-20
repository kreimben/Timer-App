import SwiftUI
import UIKit

final class SoundPicker: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UITableViewController {
        
        let tableViewController = SoundTableViewController()
        
        return tableViewController
    }
    
    func updateUIViewController(_ tableView: UITableViewController, context: Context) { }
    
    class Coordinator: NSObject {
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        
        return Coordinator()
    }
}

//
//  SoundPicker.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/20/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
