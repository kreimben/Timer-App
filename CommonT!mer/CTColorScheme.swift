import Foundation
import SwiftUI

public enum CTColors: CaseIterable {
    case blue, red, yellow, green, orange, purple, black//, White
}

public class CTColorScheme {
    
    public init() { }
    
    public let scheme = [
        "\(CTColors.blue)",
        "\(CTColors.red)",
        "\(CTColors.yellow)",
        "\(CTColors.green)",
        "\(CTColors.orange)",
        "\(CTColors.purple)",
        "\(CTColors.black)"
    ]
    
    public static func getColor(_ color: Int) -> Color {
        
        switch color {
            
        case 0: return Color.blue
        case 1: return Color.red
        case 2: return Color.yellow
        case 3: return Color.green
        case 4: return Color.orange
        case 5: return Color.purple
        case 6: return Color.black
            
        default:
            return Color.blue
        }
    }
    
    public static func getSystemUIColor(_ color: Int) -> UIColor {
        
        switch color {
            
        case 0: return UIColor.systemBlue
        case 1: return UIColor.systemRed
        case 2: return UIColor.systemYellow
        case 3: return UIColor.systemGreen
        case 4: return UIColor.systemOrange
        case 5: return UIColor.systemPurple
        case 6: return UIColor.black
            
        default:
            return UIColor(named: "systemBlue")!
        }
    }
    
    /// Return custom UIColor based on saved color in `CTUserSettings`.
    /// 0 = blue / 1 = red / 2 = yellow / 3 = green / 4 = orange / 5 = purple / 6 = black
    /// - Parameters:
    ///   - colorIndex: Index from `CTUserSettings`
    /// - Returns: Converted `UIColor`
    public static func getUIColor(_ colorIndex: Int, red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 1.0) -> UIColor {
        
        switch colorIndex {
        
        case 0: return UIColor(red: 0 + red, green: 0 + green, blue: 1 + blue, alpha: alpha)
        case 1: return UIColor(red: 1 + red, green: 0 + green, blue: 0 + blue, alpha: alpha)
        case 2: return UIColor(red: 1 + red, green: 1 + green, blue: 0 + blue, alpha: alpha)
        case 3: return UIColor(red: 0 + red, green: 0.5 + green, blue: 0 + blue, alpha: alpha)
        case 4: return UIColor(red: 1 + red, green: 0.65 + green, blue: 0 + blue, alpha: alpha)
        case 5: return UIColor(red: 0.5 + red, green: 0 + green, blue: 1.5 + blue, alpha: alpha)
        case 6: return UIColor(red: 0 + red, green: 0 + green, blue: 0 + blue, alpha: alpha)
            
        default: return UIColor(named: "Blue")!
        }
    }
}

//
//  CTColorScheme.swift
//  CommonT!mer
//
//  Created by Aksidion Kreimben on 7/16/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
