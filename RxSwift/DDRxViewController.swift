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
class DDRxViewController: UIViewController {
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.add(subview: textField, pin: [.left, .top, .right], margin: DDMargins(top: 100, left: 20, right: -20))
        textField.setHeight(64)
        textField.rx.text.bind { text in
            print(text!)
        }.disposed(by: bag)
        // Do any additional setup after loading the view.
    }
    
    lazy var textField: UITextField = {
        let result = UITextField()
        result.backgroundColor = .red
        return result
    }()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
