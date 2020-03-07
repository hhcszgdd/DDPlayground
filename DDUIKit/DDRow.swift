//
//  DDRow.swift
//  test
//
//  Created by JohnConnor on 2020/2/19.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
open class DDRow : UIView {
    var rowHeight: DDRowHeight {
        return DDRowHeight.auto
    }
    
    
    var collectionView: DDCollectionView!
//    var height: CGFloat {
//        return 44
//    }
//    private let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
//        addSubview(label)
//        label.text = "label1111"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            label.topAnchor.constraint(equalTo: topAnchor),
//            label.leftAnchor.constraint(equalTo: leftAnchor),
//            label.rightAnchor.constraint(equalTo: rightAnchor),
//            label.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //class DDRow <T>: NSObject {
    //    var a : AnyClass?
    //    init(t: T) {
    //        a = t as? AnyClass
    //    }
}
public enum DDRowHeight {
    case auto
    case caculattion(CGFloat)
}
