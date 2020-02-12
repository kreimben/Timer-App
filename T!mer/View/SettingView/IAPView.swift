import SwiftUI
import UIKit

import SwiftyStoreKit

struct IAPView: View {
    
    @Binding var productID: String
    
    @ObservedObject var userSettings = UserSettings()
    
    init(productID: Binding<String>) {
        
        self._productID = productID
        
        if !(UserSettings().isUserPurchased) {
            
            /// Code's from official documentation at [https://github.com/bizz84/SwiftyStoreKit#retrieve-products-info]
            SwiftyStoreKit.retrieveProductsInfo([self.productID/*"com.KreimbenPro.nonConsumable.removeads"*/]) { result in
                if let product = result.retrievedProducts.first {
                    let priceString = product.localizedPrice!
                    print("Product: \(product.localizedDescription), price: \(priceString)")
                }
                else if let invalidProductId = result.invalidProductIDs.first {
                    print("Invalid product identifier: \(invalidProductId)")
                }
                else {
                    print("Error: \(String(describing: result.error))")
                }
            }
        }
    }
    
    var body: some View {
        
        ZStack {
            Color.blue.opacity(0.55).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Get T!mer Pro").font(.largeTitle).bold()
                
                ZStack {
                    
                    Color.blue.opacity(0.5)
                    
                    VStack {
                        HStack {
                            Text("• What is in T!mer \"Pro\"?").font(.headline)
                            Spacer()
                        }.padding([.leading, .trailing, .top], 10)
                        
                        Text("T!mer Pro enables to remove ads and unlock macOS T!mer")
                            .padding([.leading, .trailing], 6)
                        
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Circle()
                                    .frame(width: 12, height: 12)
                                
                                Text("Get removed ads!")
                            }.padding([.leading, .trailing, .top], 10).padding(.bottom, 5)
                            
                            HStack {
                                Circle()
                                    .frame(width: 12, height: 12)
                                
                                Text("Get macOS T!mer!")
                            }.padding([.leading, .trailing, .bottom], 10).padding(.top, 5)
                        }
                        .foregroundColor(self.userSettings.isUserPurchased ? .green : .red)
                    }
                }
                .cornerRadius(30)
                .padding([.leading, .trailing], 10)
                .frame(height: 200)
                
                ZStack {
                    Color.blue.opacity(0.5)
                    
                    ZStack {
                        
                        VStack {
                            Text("🎊Buy T!mer Pro, Use macOS T!mer either🎊")
                            
                            Image("macOS T!mer IDLE")
                                .resizable()
                                .scaledToFit()
                            
                            Image("macOS T!mer RUNNING")
                                .resizable()
                                .scaledToFit()
                        }
                    }.padding()
                }
                .cornerRadius(30)
                .padding([.leading, .trailing], 10)
                
                PurchaseButton(productID: $productID)
                
                Button(action: {
                    
                    print("Restore In-app Purchase")
                    
                    /// Code's from official documentaion at [https://github.com/bizz84/SwiftyStoreKit#purchases]
                    SwiftyStoreKit.restorePurchases(atomically: true) { results in
                        
                        if results.restoreFailedPurchases.count > 0 {
                            print("Restore Failed: \(results.restoreFailedPurchases)")
                        } else if results.restoredPurchases.count > 0 {
                            print("Restore Seccess: \(results.restoredPurchases)")
                        } else {
                            print("Nothing to Restore")
                        }
                    }
                }) {
                    Text("Restore in-app purchase")
                        .foregroundColor(Color.red)
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

fileprivate struct PurchaseButton: View {
    
    @Binding var productID: String
    
    @ObservedObject var userSettings = UserSettings()
    
    let userHaptics = UserHapticFeedback()
    
    var body: some View {
        
        Button(action: {
            
            self.userHaptics.hapticFeedbackPlay()
            
            /// Code's from official documentaion at [https://github.com/bizz84/SwiftyStoreKit#purchases]
            
            //                        self.userSettings.isUserPurchased.toggle()
            
            SwiftyStoreKit.purchaseProduct(self.productID, quantity: 1, atomically: true) { result in
                
                switch result {
                    
                case .success(let purchase):
                    print("Purchase Success: \(purchase)")
                    
                case .error(let error):
                    switch error.code {
                    case .unknown: print("Unknown error. Please contact support")
                    case .clientInvalid: print("Not allowed to make the payment")
                    case .paymentCancelled: break
                    case .paymentInvalid: print("The purchase identifier was invalid")
                    case .paymentNotAllowed: print("The device is not allowed to make the payment")
                    case .storeProductNotAvailable: print("The product is not available in the current storefront")
                    case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                    case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                    case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                    default: print((error as NSError).localizedDescription)
                    }
                }
            }
        }) {
            ZStack {
                
                RoundedRectangle(cornerRadius: 100, style: .circular)
                    .foregroundColor(.blue)
                
                Text("Purchase T!mer Pro")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
        .padding()
        .frame(height: 90)
    }
}

//struct IAPView_Previews: PreviewProvider {
//    static var previews: some View {
//        IAPView(productID: Binding<String>)
//    }
//}

//
//  IAPView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 2/11/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
