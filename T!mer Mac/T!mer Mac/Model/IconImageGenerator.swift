//
//  IconImageGenerator.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 12/27/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//

import Cocoa

class IconImageGenerator: NSView {
    
    var image: NSImage? {
        didSet {
            needsDisplay = true
        }
    }
    
    init(frame frameRect: NSRect, image: NSImage?) {
        
        self.image = image
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }

    override func draw(_ dirtyRect: NSRect) {
//        super.draw(dirtyRect)

        image?.draw(at: .zero, from: bounds, operation: .sourceOver, fraction: 1.0)
    }
    
}
