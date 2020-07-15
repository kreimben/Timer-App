import Foundation
import SwiftUI
import Combine

import GoogleMobileAds
import CommonT_mer

class Interstitial: NSObject, GADInterstitialDelegate {
    
    @ObservedObject var userSettings = CTUserSettings()
    @ObservedObject var mainController = CTMainController()
    
    #if DEBUG
    private var interstitialID = "ca-app-pub-3940256099942544/4411468910"
    #else
    private var interstitialID = "ca-app-pub-4942689053880729/9986747026"
    #endif
    
    private var interstitial: GADInterstitial!
    
    override init() {
        super.init()
        
        self.interstitial = GADInterstitial(adUnitID: self.interstitialID)
        loadInterstitial()
    }
    
    func loadInterstitial() {
        
        let req = GADRequest()
        self.interstitial.load(req)
        self.interstitial.delegate = self
    }
    
    func showAd() {
        
        if self.interstitial.isReady {
            
            let root = UIApplication.shared.windows.first?.rootViewController
            self.interstitial.present(fromRootViewController: root!)
        } else {
            
            print("Interstitial Ad Is Not Ready")
        }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        
        self.interstitial = GADInterstitial(adUnitID: interstitialID)
        loadInterstitial()
    }
    
    func settingTimer() {
        
        let limit: Double = 1.5
        print("Random Range is: \(limit)")
        let time: DispatchTime = DispatchTime.now() + limit
        
        if self.mainController.isTimerRunning() {
            
            DispatchQueue.main.asyncAfter(deadline: time) {
                
                self.showAd()
            }
        }
    }
}

//
//  Interstitial.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 2/4/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
