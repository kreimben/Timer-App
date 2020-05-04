import Foundation
import SwiftUI

enum TColors: CaseIterable {
    case Blue, Red, Yellow, Green, Orange, Purple, Black//, White
}

class TColorScheme {
    
    let scheme = [
        "\(TColors.Blue)",
        "\(TColors.Red)",
        "\(TColors.Yellow)",
        "\(TColors.Green)",
        "\(TColors.Orange)",
        "\(TColors.Purple)",
        "\(TColors.Black)"
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
