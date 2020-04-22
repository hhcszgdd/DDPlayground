//
//  DDTimer.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/4/22.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import Foundation
class DDTimer: NSObject {
    static let share: DDTimer = DDTimer()
    private var action : (()->())?
    private var timer: Timer?
    func perform(deadLine: TimeInterval, onMode: RunLoop = RunLoop.main, execute:@escaping ()->()) {
        if timer?.isValid ?? false {
            timer?.invalidate()
        }
        timer = Timer(timeInterval: deadLine, target: self , selector: #selector(performSomething), userInfo: nil, repeats: false)
        self.action = execute
        onMode.add(timer!, forMode: RunLoop.Mode.common)
    }
    
    @objc private  func performSomething() {
        self.action?()
        self.action = nil
        if timer?.isValid ?? false {
            timer?.invalidate()
        }
        timer = nil
    }
}
