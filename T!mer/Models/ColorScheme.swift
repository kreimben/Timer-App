import Foundation
import SwiftUI

enum Colors: CaseIterable {
    case blue, red, yellow, green, orange, purple, black//, White
}

class ColorScheme {
    
    let scheme = [
        "\(Colors.blue)",
        "\(Colors.red)",
        "\(Colors.yellow)",
        "\(Colors.green)",
        "\(Colors.orange)",
        "\(Colors.purple)",
        "\(Colors.black)"
    ]
    
    static func getColor(_ color: Int) -> Color {
        
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
}

//
//  ColorScheme.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 3/21/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
