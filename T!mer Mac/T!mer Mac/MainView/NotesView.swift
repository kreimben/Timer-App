import SwiftUI

struct NotesView: View {
    
    /// @Binding for alternating "presentationMode"
    @Binding var isPresented: Bool
    /// @END
    
    /// @Background Color Opacity
    @State var backgroundColorOpacity = 0.7
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
                    } // Title
                    
                    HStack {
                        Text("Focus on your task and Don't waste your time with")
                            .font(.system(size: 13, design: .rounded))
                        Text("\"T!mer\".")
                            .font(.system(size: 13, design: .rounded)).bold()
                    }.padding([.top, .bottom]) // Headline
                    
                    Image("main_screenshot")
                        .resizable()
                        .frame(width: 500 * 0.8, height: 300 * 0.8)
                    
                    ZStack { // Shortcuts
                        Color.blue.opacity(backgroundColorOpacity)
                        VStack {
                            Text("Shortcuts")
                                .font(.system(.title, design: .rounded))
                                .padding()
                            
                            Text("You can start T!mer drawing circle using trackpad or mouse")
                                .font(.system(size: 12))
                            
                            Text("directly though T!mer have some of shortcuts for convinience.")
                                .font(.system(size: 12)).padding(.bottom)
                            
                            Text("Let's look around!")
                                .font(.system(size: 12))
                                .padding([.leading, .trailing])
                            
                            Text("Run T!mer for").bold().padding()
                            VStack(alignment: .leading) {
                                Group {
                                    HStack {
                                        Text("⌘1")
                                        Spacer()
                                        Text("1 Minute")
                                    } // 1
                                    HStack {
                                        Text("⌘2")
                                        Spacer()
                                        Text("2 Minutes")
                                    } // 2
                                    HStack {
                                        Text("⌘3")
                                        Spacer()
                                        Text("3 Minutes")
                                    } // 3
                                    HStack {
                                        Text("⌘4")
                                        Spacer()
                                        Text("4 Minutes")
                                    } // 4
                                    HStack {
                                        Text("⌘5")
                                        Spacer()
                                        Text("5 Minutes")
                                    } // 5
                                    HStack {
                                        Text("⌘⌥1")
                                        Spacer()
                                        Text("10 Minutes")
                                    } // 10
                                    HStack {
                                        Text("⌘⌥⇧1")
                                        Spacer()
                                        Text("15 Minutes")
                                    } // 15
                                    HStack {
                                        Text("⌘⌥2")
                                        Spacer()
                                        Text("20 Minutes")
                                    } // 20
                                    HStack {
                                        Text("⌘⌥3")
                                        Spacer()
                                        Text("30 Minutes")
                                    } // 30
                                } // 1, 2, 3, 4, 5, 10, 15, 20, 30 minutes
                                Group {
                                    HStack {
                                        Text("⌘⌥4")
                                        Spacer()
                                        Text("40 Minutes")
                                    } // 40
                                    HStack {
                                        Text("⌘⌥⇧4")
                                        Spacer()
                                        Text("45 Minutes")
                                    } // 45
                                    HStack {
                                        Text("⌘⌥5")
                                        Spacer()
                                        Text("50 Minutes")
                                    } // 50
                                    HStack {
                                        Text("⌘⌥6")
                                        Spacer()
                                        Text("60 Minutes")
                                    } // 60
                                    Divider()
                                    HStack {
                                        Text("⌘.")
                                        Spacer()
                                        Text("Stop")
                                    }
                                } // 40, 45, 50, 60 minutes and Stop
                            } // Shortcut Texts
                                .padding([.leading, .trailing], 8 * 14)
                                .padding(.bottom)
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
                                    
                                    Text("- Click and hold inner circle until timer is cancled or Press ⌘.")
                                        .padding(.bottom)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("⚬ How to set T!mer 60 minutes?")
                                        .font(.system(.headline, design: .rounded))
                                        .padding([.top, .bottom])
                                    
                                    Text("- Click and hold circle or Press ⌘⌥6")
                                        .padding(.bottom)
                                }
                            }
                        }
                    } // Tips
                }
            } // ScrollView
            .frame(width: 400, height: 240)

            Button("Done") {
                
                self.isPresented = false
            }
            .padding(.bottom)
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
