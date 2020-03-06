//
//  DDRow1.swift
//  test
//
//  Created by JohnConnor on 2020/2/20.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

open class DDRow1: DDRow {
    let label: UILabel = {
        let result = UILabel()
        result.numberOfLines = 0
        return result
    }()
    
//    override var height: CGFloat {
//        setNeedsLayout()
//        setNeedsDisplay()
//        return self.bounds.height
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.text = "label1111111111111asdfasdfasdfasdfasdfasdfasfsdf 1111111111111111111111111111111111111111111111111111111111111111111"
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
//        label.frame = bounds
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
