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
import AudioToolbox
public enum DDSoundEffect : String {
    case switchTab = "digi_plink"
    case plusButtonOpen = "slide_right"
    case plusButtonClose = "slide_left"
    case homesDropOpen = "card_drop"
    case homesDropClose = "card_set"
    case openWallet = "keyboard"

    private var fileExtension: String {
        switch self {
        case .openWallet: return "mp3"
        default: return "m4a"
        }
    }

    public func playSound() {
        guard let soundUrl = Bundle.main.url(forResource: self.rawValue, withExtension: self.fileExtension) else { return }

        var soundId: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)//创建系统声音
        AudioServicesAddSystemSoundCompletion(soundId, nil, nil, { soundId, _ -> Void in AudioServicesDisposeSystemSoundID(soundId) }, nil)//设置回调
        AudioServicesPlaySystemSound(soundId)//播放时长小于等于30s的音频
    }
}


extension String {
    public func convertToImage(font: UIFont  = UIFont.systemFont(ofSize: 84)) -> UIImage? {
        let size = CGSize(width: font.lineHeight, height: font.lineHeight)
        UIGraphicsBeginImageContext(size);
        let context = UIGraphicsGetCurrentContext()

        UIColor.clear.set()
        let rect = CGRect(origin: CGPoint.zero, size: size)
        context?.fill(rect)
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attributes = [
            NSAttributedString.Key.font:font,
            NSAttributedString.Key.paragraphStyle:paragraph
        ]
        
        NSString(string: self).draw(in: rect, withAttributes: attributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext();
        
        
        
        return image
    }
}


extension DDViewController {
    
    func testAutolayout() {
        let ss = UIView()
        ss.setWidth(200)
        ss.setHeight(200)
        ss.backgroundColor = .blue
        view.add(subview: ss, pin: [.top, .left], margin: DDMargins(top: 200, left: 100))
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            ss.removeFromSuperview()
        }
    }
}
