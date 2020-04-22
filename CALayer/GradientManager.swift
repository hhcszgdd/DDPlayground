//
//  GradientManager.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/2/29.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
class GradientManager: NSObject {
    static let share: GradientManager = GradientManager()
    
   
}
extension DDViewController {
    func testGradient() {
           let vc = DDViewController()
           
           
           let containerView: UIView = {
               let frame = CGRect(x: 0, y: 0,
                                  width: 222,
                                  height: 200)
               /// 1. Create a holder view
               let view = UIView(frame: frame)
               
               /// 2. Cover it with a gradient color layer
               let gradient = CAGradientLayer()
               gradient.frame = view.bounds
               gradient.startPoint = CGPoint(x: 0, y: 0)
               gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
               gradient.colors = [
                   UIColor.red.cgColor,
                   UIColor.blue.cgColor]
               view.layer.addSublayer(gradient)
               
               /// 3. Mask the UILabel onto the color layer
               let label = UILabel(frame: view.bounds)
               label.text = "hello world, this is my first performence apphello world, this is my first performence apphello world, this is my first performence apphello world, this is my first performence apphello world, this is my first performence apphello world, this is my first performence apphello world, this is my first performence apphello world, this is my first performence apphello world, this is my first performence app"
               label.numberOfLines = 0
               label.textAlignment = .center
               label.lineBreakMode = NSLineBreakMode.byWordWrapping
               label.font = UIFont.boldSystemFont(ofSize: 22)
               view.addSubview(label)
               view.mask = label
               return view
           }()
           
           vc.view.addSubview(containerView)
        self.navigationController?.pushViewController(vc, animated: true)
       }
}
