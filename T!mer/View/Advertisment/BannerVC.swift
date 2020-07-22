import SwiftUI
import UIKit

import GoogleMobileAds

struct BannerVC: UIViewControllerRepresentable {
    
    init() { }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<BannerVC>) -> UIViewController {
        
        let view = GADBannerView(adSize: kGADAdSizeBanner)
        
        let viewController = UIViewController()
        
        #if DEBUG
        view.adUnitID = "ca-app-pub-3940256099942544/2934735716" // 배너광고 ID (for Test)
        #else
        view.adUnitID = "ca-app-pub-4942689053880729/1552889082" // 진짜 배너광고 ID
        #endif
        
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        view.load(GADRequest())
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

//
//  BannerVC.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/22/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
