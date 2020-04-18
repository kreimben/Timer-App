//
//  IconImageGenerator.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 12/26/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//

import Cocoa
import CoreGraphics

class IconImageGenerator: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let outterCircle = NSBezierPath()
        outterCircle.move(to: NSPoint(x: 9.0, y: 9.0))
        outterCircle.appendArc(withCenter: NSPoint(x: 9.0, y: 9.0), radius: 8.0, startAngle: 0, endAngle: CGFloat.pi)
        NSColor.red.set()
        outterCircle.fill()
    }
    
}
