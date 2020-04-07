//
//  DDRxViewController.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/3/7.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class DDRxViewController: DDViewController {
    let bag = DisposeBag()
    var ob = Observable.from([1,2,3,4,5,6,7])
    let subjectt = PublishSubject<String>()
    override var naviBarStyle: DDNavigationBarStyle { return .blue }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subjectt.subscribe(onNext: { (intValue) in
            print("1 int value : \(intValue)")
        }, onError: { (error) in
            print("1 errorrrrr")
        }, onCompleted: {
            print("1 done ")
        }) {
            print("1 over")
        }.disposed(by: bag)
        
        subjectt.subscribe(onNext: { (intValue) in
            print("2 int value : \(intValue)")
        }, onError: { (error) in
            print("2 errorrrrr")
        }, onCompleted: {
            print("2 done ")
        }) {
            print("2 over")
        }.disposed(by: bag)
        
        subjectt.onNext("xxxxx")
        subjectt.onNext("ooooo")
//        subjectt.onError(RxError.noElements)
        
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
        subjectt.onNext("ooooo")
        subjectt.onCompleted()
//        let vc = DDCollectionViewController()
//        vc.collectionView.sections = [
//            DDSection(rows: [  DDRow5(), DDRow(), DDRow1(), DDRow2(), DDRow3() , DDRow4()  ])
//        ]
//
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension DDRxViewController {
   
}
