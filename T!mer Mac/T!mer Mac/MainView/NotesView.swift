import SwiftUI

struct NotesView: View {
    
    /// @Environment
    @Environment(\.presentationMode) var presentationMode
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
                    
                    // TODO: Make main program's screen-shot image and put it on.
                    
                    //Image("main_screen_shot")
                        //.resizable()
                        //.frame(width: 200, height: 120)
                    
                    Text("How to Use T!mer?")
                        .font(.system(.headline))
                    
                    ZStack { // Notes view
                        Color.red.opacity(0.5)
                        VStack {
                            Text("Notes!")
                                .font(.system(.title, design: .rounded))
                                .padding()
                            
                            Text("Don't close this app while opening subviews\nincluding this view and \"Preferences\" view and \"Start T!mer\" view")
                                .font(.system(size: 12))
                                .padding()
                        }
                    }
                }
            } // ScrollView
            .frame(width: 400, height: 240)

            Button("Done") {
                
                self.presentationMode.wrappedValue.dismiss()
            }
            .padding()
        } // master vstack
    } // var body
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}

//
//  NotesView.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 3/22/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
