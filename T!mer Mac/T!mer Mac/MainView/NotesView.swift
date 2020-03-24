import SwiftUI

struct NotesView: View {
    
    /// @Binding about alternating "presentationMode"
    @Binding var isPresented: Bool
    /// @END
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    
                    VStack(alignment: .leading) {
                        Text("T!mer,")
                            .font(.system(size: 32, design: .rounded)).bold()
                            .padding([.top])
                        Text("Powerful Visualized Timer")
                            .font(.system(size: 30, design: .rounded)).bold()
                    }
                    
                    HStack {
                        Text("Focus on your task and Don't waste your time with")
                            .font(.system(size: 13, design: .rounded))
                        Text("\"T!mer\".")
                            .font(.system(size: 13, design: .rounded)).bold()
                    }.padding([.top, .bottom])
                    
                    Image("main_screenshot")
                        .resizable()
                        .frame(width: 500 * 0.8, height: 300 * 0.8)
                    
                    Text("How to Use T!mer?")
                        .font(.system(.headline))
                    
                    ZStack { // Notes view
                        Color.red.opacity(0.5)
                        VStack {
                            Text("Notes!")
                                .font(.system(.title, design: .rounded))
                                .padding()
                            
                            Text("Please don't close this app while opening subviews\nincluding this view and \"Preferences\" view and \"Start T!mer\" view")
                                .font(.system(size: 12))
                                .padding()
                        }
                    }
                }
            } // ScrollView
            .frame(width: 400, height: 240)

            Button("Done") {
                
                self.isPresented = false
            }
            .padding()
        } // master vstack
    } // var body
}

//
//  NotesView.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 3/22/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
