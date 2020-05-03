import SwiftUI

struct HowToUseThisApp: View {
    
    /// @Binding for alternating "presentationMode"
    //    @Binding var isPresented: Bool
    /// @END
    
    /// @Background Color Opacity
    @State var backgroundColorOpacity = 0.7
    /// @END
    
    var body: some View {
        ScrollView {
            
            VStack {
                
                ZStack {
                    Color.blue.opacity(backgroundColorOpacity)
                    
                    
                    VStack(alignment: .leading) {
                        
                        Text("T!mer,")
                            .font(.system(size: 32, design: .rounded)).bold()
                            .padding([.top])
                        Text("Powerful Visualized Timer")
                            .font(.system(size: 30, design: .rounded)).bold()
                        
                        Text("Focus on your task and Don't waste your time with \"T!mer\".")
                            .padding()
                    }
                    
                }
                .frame(height: 200)
                
                ZStack { // Shortcuts
                    Color.green.opacity(backgroundColorOpacity)
                    
                    VStack {
                        Text("Shortcuts")
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()
                            .padding()
                        
                        Text("You can start T!mer drawing circle using your finger directly though, T!mer have some of shortcuts for convinience.")
                            .padding()
                        
                        Text("Let's look around!")
                            .font(.headline)
                            .bold()
                            .padding()
                        
                        Image("howToUse-1")
                            .resizable()
                            .aspectRatio(1.0, contentMode: .fill)
                            .imageScale(.large)
                            .padding()
                        
                        Text("As you can see, You can use T!mer directly using shortcuts.")
                            .padding()
                        
                    }
                } // Shortcuts
                
                ZStack { // Tips
                    Color.yellow.opacity(backgroundColorOpacity)
                    VStack {
                        
                        Text("Tips")
                            .font(.system(size: 32, design: .rounded))
                            .padding([.top, .bottom])
                        
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("⚬ How to Stop T!mer?")
                                    .font(.system(.headline, design: .rounded))
                                    .padding([.top, .bottom])
                                
                                Text("- Click and hold inner circle until timer is cancled.")
                                    .padding(.bottom)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("⚬ How to set T!mer 60 minutes?")
                                    .font(.system(.headline, design: .rounded))
                                    .padding([.top, .bottom])
                                
                                Text("- Click and hold circle.")
                                    .padding(.bottom)
                            }
                        }
                    }
                } // Tips
            }
        } // ScrollView
    } // var body
}

struct HowToUseThisApp_Previews: PreviewProvider {
    static var previews: some View {
        HowToUseThisApp()
    }
}

//
//  HowToUseThisApp.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 5/3/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
