import SwiftUI

import CommonT_mer

struct UpdateLogView: View {
    
    @ObservedObject var userSettings = CTUserSettings()
    
    var body: some View {
        
        GeometryReader { geoReader in
            ZStack {
                Color.white
                
                VStack {
                    UpdateLogDetailView()
                    
                    Spacer()
                    
                    ZStack {
                        Color.blue
                        
                        Button(action: {
                            
                            let buildVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as? String ?? ""
                            
                            print("UserSettings' latestBuildVersion is \(self.userSettings.latestBuildVersion)")
                            print("Current Build Version is \(buildVersion)")
                            print("Type is \(type(of: buildVersion))")
                            print("UserSettings' latestBuildVersion is \(self.userSettings.latestBuildVersion)")
                            
                            self.userSettings.latestBuildVersion
                                = Int(buildVersion)!
                            self.userSettings.updateLogBlurValue = 0
                        }) {
                            
                            Text("OK")
                                .foregroundColor(.white)
                        }
                    }
                    .frame(height: geoReader.size.height * 0.16)
                }
            }
        }
    }
}

struct UpdateLogView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateLogView()
    }
}

//
//  UpdateLogView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 5/1/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
