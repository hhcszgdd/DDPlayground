//
//  DDRow3.swift
//  test
//
//  Created by JohnConnor on 2020/2/20.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
//import DDFramework
open class DDRow3: DDRow {
    lazy var label: UILabel = {
         let result = UILabel()
        result.numberOfLines = 0
        result.text = "row33333333333333333333333333333333333333333333333333333333333333333"
        return result
    }()
    lazy var stack = UIStackView(arrangedSubviews: [ label ])
    override init(frame: CGRect) {
        super.init(frame: frame)
        add(subview: stack, pin: .all)
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


open class DDRow4: DDRow {
    override var rowHeight: DDRowHeight {
//        return .caculattion(88)
        return .auto
    }
    let label: UILabel = {
        let result = UILabel()
        result.numberOfLines = 0
        result.translatesAutoresizingMaskIntoConstraints = false
        result.text = "row4444444444444444444444444444444444444444444444444444444444"
        return result
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



open class DDRow5 : DDRow {
    override var rowHeight: DDRowHeight { .caculattion(222) }
    private let testSubView: UIView = {
        let result = UIView()
        result.backgroundColor = .purple
        return result
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        add(subview: testSubView, pin: .all, margin: DDMargins(top: 10, left: 10, bottom: -10, right: -100))
//        testSubView.setHeight(99)//Probably there some constraint conflict, but it works well .
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
