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

    }
}
class CurvedView: UIView {
    
    let cornerRadius: CGFloat = 24.0
    var connors: UIRectCorner = [.topLeft, .topRight, .bottomLeft]
    convenience init(frame: CGRect = CGRect.zero, conners: UIRectCorner) {
        self.init(frame: frame)
        self.connors = conners
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setMask()
    }
    
    /** Sets a mask on the view to round it's corners
     */
    func setMask() {
        
        let maskPath = UIBezierPath(roundedRect:self.bounds,
                                    byRoundingCorners: connors,
                                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.layer.mask = shape
        
    }
    
}

extension DDViewController {
    func testCurvedView() {
        let vc = DDViewController()
        let curved = CurvedView(frame: CGRect(x: 100, y: 300, width: 222, height: 222), conners: [ .topLeft, .bottomRight ])
        curved.backgroundColor = .cyan
        vc.view.addSubview(curved)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func testShapeLayer() {
        let vc = DDViewController()
        let width: CGFloat = 444
        let height: CGFloat = 444
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
        vc.view.layer.addSublayer(shapeLayer)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
