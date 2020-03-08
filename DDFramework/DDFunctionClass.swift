//
//  DDFunctionClass.swift
//  DDFramework
//
//  Created by JohnConnor on 2020/2/29.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

open class DDFunctionClass: NSObject {
    open func testPrint () {
        print("you can do it")
    }
}
public struct DDPosition: OptionSet {
    public static var top = DDPosition(rawValue: 1 << 0)
    public static var left = DDPosition(rawValue: 1 << 1)
    public static var bottom = DDPosition(rawValue: 1 << 2)
    public static var right = DDPosition(rawValue: 1 << 3)
    public static var all: DDPosition = [.top, .left, .bottom, .right]
    public let rawValue: Int
    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
}

public struct DDMargins {
    let top: CGFloat
    let left: CGFloat
    let bottom: CGFloat
    let right: CGFloat
    public init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        (self.top, self.left, self.bottom, self.right) = (top, left, bottom, right)
    }
    
}

extension UIView {
    
    /// Note: Just can be set once
    public func setSize(_ size: CGSize ) {
        setWidth(size.width)
        setHeight(size.height)
    }
    
    /// Note: Just can be set once
    public func setWidth(_ width: CGFloat ) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    /// Note: Just can be set once
    public func setHeight(_ height: CGFloat ) {
        if !translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    /// Note: Just can be set once
    public func add(subview: UIView,pin to: DDPosition = [.top, .left, .bottom, .right], margin:  DDMargins = DDMargins()) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        if to.contains(.top) {
            subview.topAnchor.constraint(equalTo: topAnchor, constant: margin.top).isActive = true
        }
        if to.contains(.left) {
            subview.leftAnchor.constraint(equalTo: leftAnchor, constant: margin.left).isActive = true
        }
        if to.contains(.bottom) {
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: margin.bottom).isActive = true
        }
        if to.contains(.right) {
            subview.rightAnchor.constraint(equalTo: rightAnchor, constant: margin.right).isActive = true
        }
    }
}
