//
//  DDRxViewController.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/3/7.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
import DDFramework
import RxCocoa
import RxSwift
import DDUIKit
class DDRxViewController: DDViewController {
    let bag = DisposeBag()
    override var naviBarStyle: DDNavigationBarStyle { return .blue }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .black
        view.backgroundColor = .white
        view.add(subview: textField, pin: [.left, .top, .right], margin: DDMargins(top: 100, left: 20, right: -20))
        textField.setHeight(64)
        textField.rx.text.bind { text in
            print(text!)
        }.disposed(by: bag)
    }
    
    lazy var textField: UITextField = {
        let result = UITextField()
        result.backgroundColor = .red
        return result
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DDSoundEffect.switchTab.playSound()
        super.touchesBegan(touches, with: event)
        let vc = DDCollectionViewController()
        vc.collectionView.sections = [
            DDSection(rows: [  DDRow5(), DDRow(), DDRow1(), DDRow2(), DDRow3() , DDRow4()  ])
        ]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
