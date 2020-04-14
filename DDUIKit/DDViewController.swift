//
//  DDViewController.swift
//  test
//
//  Created by JohnConnor on 2020/2/19.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit



open class DDViewController: UIViewController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return naviBarStyle.statusBarStyle
    }
    override open var prefersStatusBarHidden: Bool { return false }
    override open var shouldAutorotate: Bool { return true }
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    /// be overide by subViewController
    var naviBarStyle: DDNavigationBarStyle {
        return .white
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false  , animated: true )
        setupNavigationBarAppearance(style:self.naviBarStyle)
    }
    
    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if ((self.traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass)
               || ( self.traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass)) {
               // screen has rotated,if you want change layout view, do it
            print("need change view layout")
            if self.traitCollection.verticalSizeClass == .compact {
                print("横屏")
            } else {
                print("竖屏")
            }
        } else {
            // needn't change view layout
            print("needn't change view layout")
        }
    }
    
    lazy var backButton: UIButton = {
        let result = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
//        result.setImage(#imageLiteral(resourceName: "bar-back-arrow"), for: UIControl.State.normal)
        result.adjustsImageWhenHighlighted = false
        result.addTarget(self , action: #selector(backBtnClick), for: UIControl.Event.touchUpInside)//no use
        return result
    }()
}

extension DDViewController {
    @objc func testMenu() {
    }
    
     @objc func backBtnClick() {
        print("xxxxxxxx")
        }
    
    func setBackButton()  {
        
        if #available(iOS 13.0, *) {
            // ios 13下设置 无法拦截返回事件,但可以去掉返回键title:"back"
            navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)//
        }else {// 12也是
            ///:设置导航栏返回键
            self.navigationController?.navigationBar.topItem?.backBarButtonItem =   UIBarButtonItem.init(title: nil , style: UIBarButtonItem.Style.plain, target: nil , action: nil )//去掉title
            self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back-arrow")//返回按键
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back-arrow")
        }
    }
    
}

public enum DDNavigationBarStyle {
    var barColor: UIColor {
        switch self {
        case .white:
            return .white
        case .black:
            return .black
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        }
    }
    
    var backItemTintColor: UIColor {
        switch self {
        case .white:
            return .black
        case .black:
            return .white
        case .red:
            return .white
        case .green:
            return .white
            
        case .blue:
            return .white
        }
    }
    
    var naviBarStyle: UIBarStyle {
        switch self {
        case .white:
            return .default
            
        case .black:
            return .black
            
        case .red:
            return .default
            
        case .green:
            return .default
            
        case .blue:
            return .default
            
        }
    }
    
    var statusBarStyle: UIStatusBarStyle {
        switch self {
        case .white:
            return .default
            
        case .black:
            return .lightContent
            
        case .red:
            return .default
            
        case .green:
            return .default
            
        case .blue:
            return .default
            
        }
    }
    
    case red
    case green
    case blue
    case black
    case white
}

protocol DDNavigationBarAppearenceDelegate {
    var naviBarStyle: DDNavigationBarStyle {get}
}

extension  DDNavigationBarAppearenceDelegate {
//    /// default implament
    var naviBarStyle: DDNavigationBarStyle {
        return .white
    }
}

extension UIViewController: DDNavigationBarAppearenceDelegate {
    func setupNavigationBarAppearance(style:DDNavigationBarStyle) {
         navigationController?.navigationBar.tintColor = style.backItemTintColor
                if #available(iOS 13.0, *) {
                    // ios 13下设置导航栏背景色
                    if navigationItem.standardAppearance == nil {
                        navigationItem.standardAppearance = UINavigationBarAppearance()
                        navigationItem.standardAppearance?.configureWithDefaultBackground()
                        navigationItem.standardAppearance?.backgroundColor = style.barColor
                        navigationItem.standardAppearance?.setBackIndicatorImage(#imageLiteral(resourceName: "back-arrow"), transitionMaskImage: #imageLiteral(resourceName: "back-arrow"))//设置返回键
                    }
                    
                }else {
                    // TO do
                    navigationController?.navigationBar.barStyle = style.naviBarStyle
                    //true ,vc.view.origin.y 为0, 否则等于导航栏高度
        //            navigationController?.navigationBar.isTranslucent = false
                    navigationController?.navigationBar.barTintColor = style.barColor
                    
        //            navigationController?.navigationBar.backgroundColor = naviBarStyle.barColor
                    
                    navigationController?.navigationBar.tintColor = style.backItemTintColor
                    navigationController?.navigationBar.layoutIfNeeded()
                }
    }
}
