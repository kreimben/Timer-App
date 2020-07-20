import SwiftUI
import UIKit

final class SoundPicker: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> SoundTableViewController {
        
        let vc = SoundTableViewController()
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: SoundTableViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator {
        
        
    }
}

//
//  SoundPicker.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/21/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
