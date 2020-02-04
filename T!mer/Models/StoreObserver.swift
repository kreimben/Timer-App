import Foundation
import StoreKit

class StoreObserver: NSObject, SKPaymentTransactionObserver {
    
    static var shared = StoreObserver()
    
    private override init() {
        super.init()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
                
            case .purchasing: break
            // Do not block your UI. Allow the user to continue using your app.
            case .deferred: print("StoreObserver: In-app Purchase deferred")
            // The purchase was successful.
            case .purchased: print("StoreObserver: In-app Purchase Purchased")//handlePurchased(transaction)
            // The transaction failed.
            case .failed: print("StoreObserver: In-app Purchase Failed")//handleFailed(transaction)
            // There are restored products.
            case .restored: print("StoreObserver: In-app Purchase Restored")//handleRestored(transaction)
            @unknown default: fatalError("Messages.unknownDefault")
            }
        }
    }
}

//
//  StoreObserver.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 2/4/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
