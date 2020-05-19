import UIKit

class RoundedRectangleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
         
        let roundedRectangle = UIBezierPath(roundedRect: rect, cornerRadius: 16)
        
        UIColor.red.set()
        roundedRectangle.fill()
    }

}

//
//  RoundedRectangleView.swift
//  T!mer Widget
//
//  Created by Aksidion Kreimben on 5/19/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
