//
//  DDShapeLayerManager.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/3/12.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

class DDShapeLayerManager: NSObject {
    static let share: DDShapeLayerManager = DDShapeLayerManager()
    func testWithView(parentView: UIView) {
        let width: CGFloat = parentView.bounds.width
        let height: CGFloat = parentView.bounds.height
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        let path = CGMutablePath()
        stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 6).forEach {
            angle in
            var transform  = CGAffineTransform(rotationAngle: angle)
                .concatenating(CGAffineTransform(translationX: width / 2, y: height / 2))
            
            let petal = CGPath(ellipseIn: CGRect(x: -20, y: 0, width: 40, height: 100),
                               transform: &transform)
            
            path.addPath(petal)
        }
        
        shapeLayer.path = path
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.yellow.cgColor
        shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        parentView.layer.addSublayer(shapeLayer)
    }
}
