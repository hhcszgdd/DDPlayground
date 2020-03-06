//
//  DDRow2.swift
//  test
//
//  Created by JohnConnor on 2020/2/20.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

open class DDRow2: DDRow {
//    override var height: CGFloat {
//        return 88
//    }
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.numberOfLines = 0
        label.text = "label22222"
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
