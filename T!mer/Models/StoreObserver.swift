import UIKit
import SwiftUI
import StoreKit

class StoreObserver: NSObject, SKPaymentTransactionObserver {
    
    override init() {
        super.init()
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue,updatedTransactions transactions: [SKPaymentTransaction]) {
        //Handle transaction states here.

    }
}

//
//  IAPManager.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 2/3/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
