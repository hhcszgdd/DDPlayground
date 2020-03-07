//
//  ViewController.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/2/29.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
import DDUIKit
import DDFramework
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let ss = UIView()
        ss.setWidth(200)
        ss.setHeight(200)
        ss.backgroundColor = .blue
        view.add(subview: ss, pin: [.top, .left], margin: DDMargins(top: 200, left: 100))
        view.backgroundColor = .white
        CoreDataManager.share.testSaveData()
        CoreDataManager.share.testReadData()
//        GradientManager.share.testWithView(parentView: view)
        SortFunction.share.test()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let vc = DDViewController()
        vc.collectionView.sections = [
            DDSection(rows: [ DDRow4(), DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
        ]
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension ViewController {
    func changeAlongToPushAnimation() {
        transitionCoordinator?.animate(alongsideTransition: { (context) in
            // make some change
        }, completion: { (context) in
            
        })
    }
}

