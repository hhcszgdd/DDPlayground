//
//  ViewController.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/2/29.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
class ViewController: DDViewController {
    override var naviBarStyle: DDNavigationBarStyle { return .green }
    lazy var emitterView: DDEmojiEmitterView = {
        let result = DDEmojiEmitterView(frame: view.bounds)
        view.addSubview(result)
        return result
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "DDDarkAndWhireColor")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        testGameDemoVC()
//        testRXSwift()
//        testCupAnamation()
//        emitterView.startAnimation()
    }
    
    
}


extension ViewController {
    
    func testGameDemoVC() {
        let vc = DDGameDemoVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func testDDCollectionVC() {
        let vc = DDCollectionViewController()
        vc.collectionView.sections = [
            DDSection(rows: [  DDRow5(), DDRow(), DDRow1(), DDRow2(), DDRow3() , DDRow4()  ])
        ]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func testRXSwift() {
        let vc = DDRxViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func testCupAnamation() {
        DDGoldCupAnimator.show(on: view)
    }
    
    func testAutolayout() {
        let ss = UIView()
        ss.setWidth(200)
        ss.setHeight(200)
        ss.backgroundColor = .blue
        view.add(subview: ss, pin: [.top, .left], margin: DDMargins(top: 200, left: 100))
    }
    func performFunctionWithString() {
        self.perform(NSSelectorFromString("testShapLayer"), with: nil, with: nil)
    }
    
    func testCoreData() {
        CoreDataManager.share.testSaveData()
        CoreDataManager.share.testReadData()
    }
    
    func testLayer() {
        let curved = CurvedView(frame: CGRect(x: 100, y: 300, width: 222, height: 222), conners: [ .topLeft, .bottomRight ])
        curved.backgroundColor = .cyan
        view.addSubview(curved)
        
        //        GradientManager.share.testWithView(parentView: view)
        
        //        view.addSubview( SwitcherView( frame: UIScreen.main.bounds ) )
        
    }
    
    func testQuickSort() {
        SortFunction.share.test()
    }
    
    func testMutipleThread() {
        DDMultipleThread.share.testGCDAsync()
    }
    
}

extension ViewController {
    func changeAlongToPushAnimation() {
        transitionCoordinator?.animate(alongsideTransition: { (context) in
            // make some change
        }, completion: { (context) in
            
        })
    }
    
    @objc func testShapLayer() {
        DDShapeLayerManager.share.testWithView(parentView: view)
    }
}

