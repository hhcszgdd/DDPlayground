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
    case swiftKeyPath
    case SwiftDynamicCallable
    case SafariVC
    case shapeLayer
    case cupAnimatin
    case webSocket
    case pdfKit
    case lottieAnimation
}

extension ViewController {
    func willBePerformAction(action: DDAction)  {
        print(action.rawValue)
        switch action {
        case .layout:
            testAutolayout()
        case .rxSwift:
            navigationController?.pushViewController(DDRxViewController(), animated: true)
        case .scene:
            testGameDemoVC()
        case .ddCollection:
            testDDCollectionVC()
        case .quickSort:
            SortFunction.share.test()
        case .curvedView:
            testCurvedView()
        case .mutipleThread:
            DDMultipleThread.share.testGCDAsync()
        case .coreData:
            CoreDataManager.share.testSaveData()
            CoreDataManager.share.testReadData()
        case .selWithString:
            self.view.perform(NSSelectorFromString("layoutIfNeeded"), with: nil, with: nil)
        case .emitterView:
            self.emitterView.startAnimation()
        case .swiftUI:
            testSwiftUI()
        case .allKindOfAlert:
            testAllKindOfAlert()
        case .swiftKeyPath:
            testSwiftKeyPath()
        case .SwiftDynamicCallable:
            testSwiftDynamicCallable()
        case .SafariVC:
            showWebVC()
        case .shapeLayer:
            testShapeLayer()
        case .cupAnimatin:
            DDGoldCupAnimator.show(on: view)
        case .lottieAnimation:
            testLottieAnimation()
        case .pdfKit:
            if #available(iOS 11, *) {
                showPDFSign()
            }
        case .webSocket:
            if #available(iOS 13, *) {
                WebSocketCase.share.test()
            } else {
                print("nothing to do")
            }
        }
    }
    
}
