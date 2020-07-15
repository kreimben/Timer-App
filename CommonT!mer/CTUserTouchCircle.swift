import Foundation
import SwiftUI
import Combine
import Dispatch

public struct CTUserTouchCircle: View {
    
    /// @Init
    @Binding var center: CGPoint
    @Binding var atan2: CGFloat
    @Binding var circleColor: Color
    @Binding var circleRadius: CGFloat
    /// @END
    
    // MARK: init()
    public init(center: Binding<CGPoint>, atan2: Binding<CGFloat>, circleColor: Binding<Color>, circleRadius: Binding<CGFloat>) {
        
        self._center = center
        self._atan2 = atan2
        self._circleColor = circleColor
        self._circleRadius = circleRadius
    }
    
    @EnvironmentObject var mainController: CTMainController
    
    @ObservedObject var userTouchController = CTUserTouchController()
    @ObservedObject var userSettings = CTUserSettings()
    
    public var body: some View {
        
        GeometryReader { geometry -> Path in
            Path { path in
                
                DispatchQueue.main.async {
                    self.center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
                    
                path.move(to: self.center)
                    
                path.addArc(center: self.center, radius: self.circleRadius, startAngle: .degrees(-90), endAngle: .degrees(self.atan2ToDegrees(tan: self.atan2)), clockwise: false)
                
            }
        }
        .foregroundColor(self.circleColor)
    }
    
    func atan2ToDegrees(tan: CGFloat) -> Double {
        
        if tan > 0 {
            
            return (Double(tan) * (180 / Double.pi) - 90)
            
        } else if tan < 0 {
            
            return  (Double(tan) * (180 / Double.pi) + 270)
            
        } else {
            
            return -90
            
        }
    }
}

public class CTUserTouchController: ObservableObject {
    
    public init() { }
    
    public func atan2ToDegrees(tan: CGFloat) -> Double {
        
        if tan > 0 {
            
            return (Double(tan) * (180 / Double.pi) - 90)
            
        } else if tan < 0 {
            
            return  (Double(tan) * (180 / Double.pi) + 270)
            
        } else {
            
            return 90
            
        }
    }
}

//
//  CTUserTouchCircle.swift
//  CommonT!mer
//
//  Created by Aksidion Kreimben on 7/16/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
