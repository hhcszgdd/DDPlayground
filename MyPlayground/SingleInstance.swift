//
//  SingleInstance.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/4/21.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit


class SingleInstance: NSObject {
    static let share: SingleInstance = SingleInstance()
    private override init() { super.init() }
}
