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
    
    public static func getUIColor(_ color: Int) -> UIColor {
        
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
}

//
//  CTColorScheme.swift
//  CommonT!mer
//
//  Created by Aksidion Kreimben on 7/16/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
