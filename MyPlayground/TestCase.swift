//
//  TestCase.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/4/13.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

enum DDAction: String , CaseIterable {
    case layout
    case rxSwift
    case scene
    case ddCollection
    case quickSort
    case curvedView
    case mutipleThread
    case coreData
    case selWithString
    case emitterView
    case swiftUI
    case allKindOfAlert
}

extension ViewController {
    func willBePerformAction(action: DDAction)  {
        print(action.rawValue)
        switch action {
        case .layout:
            testAutolayout()
        case .rxSwift:
            testRXSwift()
        case .scene:
            testGameDemoVC()
        case .ddCollection:
            testDDCollectionVC()
        case .quickSort:
            testQuickSort()
        case .curvedView:
            testCurvedView()
        case .mutipleThread:
            testMutipleThread()
        case .coreData:
            testCoreData()
        case .selWithString:
            performFunctionWithString()
        case .emitterView:
            testEmitterView()
        case .swiftUI:
            testSwiftUI()
        case .allKindOfAlert:
            testAllKindOfAlert()
        }
    }
    
}
import SwiftUI
extension ViewController {
    func testAllKindOfAlert() {
        let vc = AllKindOfAlert()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func testSwiftUI() {
        if #available(iOS 13.0, *) {
            let vc = UIHostingController(rootView: ContentView())
                // ios 13下设置导航栏背景色
            vc.setupNavigationBarAppearance(style:.blue)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
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
    
    
    @objc func testShapLayer() {
        DDShapeLayerManager.share.testWithView(parentView: view)
    }
    
    func testCoreData() {
        CoreDataManager.share.testSaveData()
        CoreDataManager.share.testReadData()
    }
    
    func testCurvedView() {
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
    
    func testEmitterView()   {
        self.emitterView.startAnimation()
    }
    
    
}
