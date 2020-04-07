//
//  UIImageExtension.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/4/7.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

extension UIImage {
    func resizingImageSizeUncommend() -> UIImage {
        // Resizing image
        let scale: CGFloat = 0.2
        let size = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        let renderer = UIGraphicsImageRenderer(size: size)
        let resizedImage = renderer.image { (context) in
            self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        }
        
        return resizedImage
    }
    
    /// if you want show the real size of image , set : imageView.contentMode = .center
    static func resizingImageSizeCommend() -> UIImage {
        // Resizing image
        let filePath = "\(Bundle.main.bundlePath)/Snip20200318_13.png"
        let url = NSURL(fileURLWithPath: filePath)
        let imageSource = CGImageSourceCreateWithURL(url, nil)!
//        let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil)
        let options: [NSString: Any] = [
            kCGImageSourceThumbnailMaxPixelSize: 100,
            kCGImageSourceCreateThumbnailFromImageAlways: true
        ]
        let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary)
        return UIImage(cgImage: scaledImage!)
    }
    
    static func createImageUncommend(bounds:CGRect, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        color.setFill()
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: 20, height: 20))
        path.addClip()
        UIRectFill(bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static func createImageCommend(bounds:CGRect, color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        let image = renderer.image { (context) in
            color.setFill()
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: 20, height: 20))
            path.addClip()
            UIRectFill(bounds)
        }
        return image
    }
}

