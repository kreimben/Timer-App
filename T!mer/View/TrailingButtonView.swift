//
//  TraillingButtonView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 10/30/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//

import SwiftUI

struct TrailingButtonView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        Group {
            if self.userSettings.alertSoundIsOn {
                Image(systemName: "bell.fill")
                    .foregroundColor(Color.red.opacity(1.0))
                    .padding(8)
                    .background(Color.white.opacity(0.5))
                    .clipShape(Circle())
                    .onTapGesture {
                        self.userSettings.alertSoundIsOn.toggle()
                }
//                .onLongPressGesture(minimumDuration: 1.5, maximumDistance: 10, pressing: nil) {
//                    SettingPageView()
//                }
                .gesture(
                    LongPressGesture(minimumDuration: 1.5, maximumDistance: CGFloat(10))
                    .onEnded { _ in
                        SettingPageView()
                    }
                )
            } else {
                Image(systemName: "bell.slash.fill")
                    .foregroundColor(Color.red.opacity(1.0))
                    .padding(8)
                    .background(Color.white.opacity(0.5))
                    .clipShape(Circle())
                    .onTapGesture {
                        self.userSettings.alertSoundIsOn.toggle()
                }
//                .onLongPressGesture(minimumDuration: 1.5, maximumDistance: 10, pressing: nil) {
//                    SettingPageView()
//                }
                .gesture(
                    LongPressGesture(minimumDuration: 1.5, maximumDistance: CGFloat(10))
                    .onEnded { _ in
                        SettingPageView()
                    }
                )
            }
        }
    }
}

struct TraillingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TrailingButtonView()
    }
}
