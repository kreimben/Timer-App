import UIKit

class CircleView: UIView {
    
    var radius: CGFloat = 40
    var time = Date().distance(to: UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime") as? Date ?? Date())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let centerPoint = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let adjustDegree = CGFloat.pi * 3/2
        
        // MARK: - Base Circle
        let baseCircle = UIBezierPath(
            arcCenter: centerPoint,
            radius: self.radius,
            startAngle: 0,
            endAngle: CGFloat.pi * 2,
            clockwise: true
        )
        UIColor(red: 0.8, green: 0, blue: 0, alpha: 1).set()
        baseCircle.fill()
        
        // MARK: - Visualized Timer
        let visual = UIBezierPath()
        visual.move(to: centerPoint)
        visual.addArc(
            withCenter: centerPoint,
            radius: self.radius * 0.8,
            startAngle: 0 + adjustDegree,
            endAngle: (CGFloat(time) * 0.1) * CGFloat.pi / 180 + adjustDegree,
            clockwise: false
        )
        UIColor.white.set()
        visual.fill()
    }
}

//
//  CircleView.swift
//  T!mer Widget
//
//  Created by Aksidion Kreimben on 5/19/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//

