//
//  DDRow3.swift
//  test
//
//  Created by JohnConnor on 2020/2/20.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

open class DDRow3: DDRow {
//    override var height: CGFloat {
//        return 111
//    }
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.numberOfLines = 0
        label.text = "label3333rtwyfhdfghdfghhfdgdfghhfdgdfghhfdgdfghhfdgdfghhfdgdfghhfdgdfghhfdghdfghdfghrtherthdfghdfghsfdghsfdghsfghsfghsfghsfghsfgh3"
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


open class DDRow4: DDRow {
//    override var height: CGFloat {
//        return 111
//    }
    let label = UILabel()
    var myHeightAnchor :NSLayoutConstraint = NSLayoutConstraint()
    let button = UIButton(type: UIButton.ButtonType.infoLight)
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(button)
        button.addTarget(self , action: #selector(btnClick(sender:)), for: UIControl.Event.touchUpInside)
        label.numberOfLines = 0
//        label.text = "label3333rtwyfhdfghdfghhfdgdfghhfdgdfghhfdgdfghhfdgdfghhfdgdfghhfdgdfghhfdghdfghdfghrtherthdfghdfghsfdghsfdghsfghsfghsfghsfghsfgh3"
        label.translatesAutoresizingMaskIntoConstraints = false
        myHeightAnchor = label.heightAnchor.constraint(equalToConstant: 333)
        myHeightAnchor.isActive = true
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    @objc func btnClick(sender: UIButton) {
        myHeightAnchor.constant -= 10
        collectionView.reloadData()
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
//        label.frame = bounds
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
