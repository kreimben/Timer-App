import SwiftUI
import Combine

import SwiftyStoreKit

struct SoundsArray: Identifiable, Hashable {
    
    let id = UUID()
    let soundName: String
    
    init(soundName: String) {
        
        self.soundName = soundName
    }
}

//MARK:- SettingPageView

struct SettingPageView: View {
    
    @State var showingModal = false
    
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        List {
            
            Section(header: Text("About sound"), footer: Text("If you want to change notification sound, please set the sound before starting timer.")) {
                
                PickerView()
            }
            
            Section(header: Text("About purchase")) {
                
                Button("Remove Ads") {
                    
                    print("Buy In-app Purchase")
                    //                    self.userSettings.isUserPurchased.toggle()
                    let productID = "com.KreimbenPro.nonConsumable.removeads"
                    SwiftyStoreKit.purchaseProduct(productID, quantity: 1, atomically: true) { result in
                        
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
                }
                
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
            
            Section(header: Text("General")) {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0")
                }
                
                Button(action: {
                    self.showingModal = true
                }) {
                    Text("Visit Kreimben.com")
                }.sheet(isPresented: $showingModal) {
                    SafariView(url: URL(string: "http://www.kreimben.com"))
                }
            }
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
        }
        .listStyle(GroupedListStyle())
    }
}

//MARK:- SettingPageView_Previews

struct SettingPageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingPageView()
    }
}
