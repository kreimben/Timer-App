import Foundation
import StoreKit

class IAPManager: NSObject, SKProductsRequestDelegate {
    
    override init() { super.init() }
    
    var request: SKProductsRequest!
    
    func validate(productIdentifier: [String]) {
        
        let productIdentifier = Set(productIdentifier)
        
        request = SKProductsRequest(productIdentifiers: productIdentifier)
        request.delegate = self
        request.start()
    }
    
    var products = [SKProduct]()
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        if !response.products.isEmpty {
            
            products = response.products
            /// Custom Method
//            displayStore(products)
        }
        
        for invalidIdentifier in response.invalidProductIdentifiers {
            
            /// Handle any invalid product identifiers as appropriate.
            print(invalidIdentifier)
        }
    }
    
    func makePayment() {
        
        let payment = SKMutablePayment(product: products[0])
        payment.quantity = 1
    }
}

//
//  IAPManager.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 2/4/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//

