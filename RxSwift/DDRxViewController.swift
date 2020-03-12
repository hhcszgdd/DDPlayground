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
    var o :BlockOperation?
    var t : URLSessionDataTask?
    override var naviBarStyle: DDNavigationBarStyle { return .blue }
    override func viewDidLoad() {
        super.viewDidLoad()
        testBlockOperation()
        
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

extension DDRxViewController {
    func testInvOperation() {
    }
    
    func testBlockOperation() {
        o = BlockOperation {
            print("....\(Thread.current)")
        }
        o?.addExecutionBlock {
            DispatchQueue.global().sync {
                var request = URLRequest(url: URL(string: "https://www.baidu.com")!)
                request.httpMethod = "GET"
                self.t = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    print("ttttt complate")
                    print("Data: \(String(data: data!, encoding: String.Encoding.utf8))")
                    print("response: \(response)")
                    print("error: \(error) ,,,\(Thread.current)")
                }
                self.t?.resume()
                
            }
        }
        //        o?.addDependency(T##op: Operation##Operation)
        o?.completionBlock = {
            print("✌️task 1 is over")
            print(".>>>\(Thread.current)")
        }
        o?.start()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.0000000001) {
            self.o?.cancel()
        }
    }
}
