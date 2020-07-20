import SwiftUI

// MARK: Code's from [https://stackoverflow.com/questions/57518852/swiftui-picker-onchange-or-equivalent]
extension Binding {
    
    func onChange(_ completion: @escaping (Value) -> Void) -> Binding<Value> {
        
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                completion(selection)
        })
    }
}

//
//  Binding+Extension.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/21/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
