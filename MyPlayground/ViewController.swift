//
//  ViewController.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/2/29.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
import DDUIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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

