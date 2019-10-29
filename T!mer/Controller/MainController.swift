import Foundation
import SwiftUI
import AVFoundation
import UIKit
import GoogleMobileAds

class MainController: ObservableObject {
    
    @Published var userDegrees: Double = 90.0 {
        didSet {
            floor(userDegrees)
        }
    }
    
    func floorDegree() {
        
        self.userDegrees -= Double(Int(Int(self.userDegrees) % 6))
        self.userDegrees = Double(Int(self.userDegrees))
    }
    
    //MARK:- AboutTimer
    
    var scheduledTimer: Timer? = Timer()
    var processedDegrees: Int = 90
    let finalMinus = 90.0
    
    @Published public var isTimerStarted: Bool = false
    
    func timeConverter() -> String {
        if self.isTimerStarted {
            return String(format: "%02d:%02d", Int(Int((self.userDegrees + self.finalMinus) * 10) / 60), Int(Int((self.userDegrees + self.finalMinus) * 10)) % 60)
        } else {
            return String(format: "%02d:00", Int(Int((self.userDegrees + self.finalMinus) * 10) / 60))
        }
    }
    
    func timerStart() {
        self.scheduledTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeUpdater), userInfo: nil, repeats: true)
        isTimerStarted = true
    }
    
    @objc func timeUpdater() {
        
        if Double(self.userDegrees + self.finalMinus) > 0.1 {
            
            self.userDegrees -= 0.1
        } else {
         
            playSound()
            self.userDegrees = 0.01 - 90
            endTimer()
            showInterstitialAds()
        }
    }
    
    func endTimer() {
        
        isTimerStarted = false
        self.scheduledTimer?.invalidate()
        self.scheduledTimer = nil
    }
    
    func arrangeDegrees() {
        
        self.processedDegrees = Int(self.userDegrees) - Int(self.userDegrees) % 6
        
        print("\(Double(self.processedDegrees) + self.finalMinus * 10) seconds")
        
        self.userDegrees = Double(self.processedDegrees)
    }
    
    func initTimerToFull() {
        self.userDegrees = 270
    }
    
    func initTimerToZero() {
        self.userDegrees = -89.9
    }
    
    //MARK:- About Ads
    
    @Published var isUserPurchased = false
    @State var interstitial: GADInterstitial!

    func showInterstitialAds() {

//        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
//
//        let request = GADRequest()
//        self.interstitial.load(request)
//
//        if self.isUserPurchased {
//            return
//        } else {
//            netShow()
//        }
    }

    private func netShow() {

        if self.interstitial.isReady {

            let root = UIApplication.shared.windows.first?.rootViewController
            self.interstitial.present(fromRootViewController: root!)

        } else {
            print("Interstitial advertisment is not ready.")
        }
    }
    
    //MARK:- About Player
    
    var player: AVAudioPlayer!
    
    func playSound() {
        
        let url = Bundle.main.url(forResource: "Default Bell", withExtension: "wav")!
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.play()
        } catch {
            print("There is error to play sound when timer is done")
        }
    }
}
