//
//  DDCollectionView.swift
//  test
//
//  Created by JohnConnor on 2020/2/19.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

open class DDCollectionView: UICollectionView {
    open var sections : [ DDSection ] = [] {
        didSet {
            reloadData()
        }
    }
}
