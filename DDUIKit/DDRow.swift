//
//  DDRow.swift
//  test
//
//  Created by JohnConnor on 2020/2/19.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
import DDFramework
open class DDRow : UIView {
    var rowHeight: DDRowHeight {
        return DDRowHeight.auto
    }
    var collectionView: DDCollectionView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public enum DDRowHeight {
    case auto
    case caculattion(CGFloat)
}
