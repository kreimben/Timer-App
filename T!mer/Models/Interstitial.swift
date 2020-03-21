import Foundation
import SwiftUI
import Combine

import GoogleMobileAds

class Interstitial: NSObject, GADInterstitialDelegate {
    
    @ObservedObject var userSettings = UserSettings()
    
    private var interstitialID = "ca-app-pub-3940256099942544/4411468910"
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
        }
            
        else{
            
            print("Interstitial Ad Is Not Ready")
        }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        
        self.interstitial = GADInterstitial(adUnitID: interstitialID)
        loadInterstitial()
    }
    
    func settingTimer() {
        
        let rangeLimit = self.userSettings.initialNotificationTime
        let limit: Double = Double.random(in: 0 ... rangeLimit)
        print("Random Range is: \(limit)")
        let time: DispatchTime = DispatchTime.now() + limit
        
        if self.userSettings.isTimerStarted {
            
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