import SwiftUI

struct UpdateLogDetailView: View {
    
    /// @ObservedObject
    @ObservedObject var userSettings = UserSettings()
    /// @END
    
    /// @App Version
    @State var appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"]! as! String
    /// @END
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("What's new ")
                        .font(.largeTitle)
                        .bold()
                        .padding([.top], 30)
                    Text("in T!mer \(appVersion)?")
                        .font(.largeTitle)
                        .bold()
                        .padding([.bottom], 25)
                }.padding(.leading, 45)
                
                Spacer()
            }
            
            VStack(alignment: .leading) {
                Text("⚬ Add more notification sound")
                Text("⚬ Add \"What's new\" mini view\"")
                    .padding(.bottom, 35)
                
                Text("Next update schedule...") //.font(.title)
                Text("2nd week of May").bold() //.font(.title)
            }
            
//            Add more notification sound
//            Fix notification behaviour after timer ended
//            Add "What's new" mini view
        }
    }
}

struct UpdateLogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateLogDetailView()
    }
}

//
//  UpdateLogDetailView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 5/2/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
