//
//  TestLottieAnimation.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/5/24.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
import Lottie
class TestLottieAnimation: DDViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.add(subview: backgroundLottieView)
        backgroundLottieView.play()
        // Do any additional setup after loading the view.
    }
    // MARK: Components
    private lazy var backgroundLottieView: AnimationView = {
        let result = AnimationView(name: "signature-lottie")
//        let result = AnimationView(name: "tellus-logo-animation")
        result.loopMode = .loop
        result.contentMode = .scaleAspectFit
        result.clipsToBounds = false
        return result
    }()


}

extension ViewController {
    func testLottieAnimation() {
        navigationController?.pushViewController(TestLottieAnimation(), animated: true)
    }
}
