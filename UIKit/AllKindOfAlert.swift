//
//  AllKindOfAlert.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/4/17.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

class AllKindOfAlert: DDViewController {
    override var naviBarStyle: DDNavigationBarStyle {return .black}
    lazy var button1: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.contactAdd)
        button.setTitle("UIAlertController usage", for: .normal)
        button.addTarget(self, action: #selector(buttonClick(sender:)), for: UIControl.Event.touchUpInside)
        button.backgroundColor = .blue
        return button
    }()
    lazy var button2: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.contactAdd)
        button.setTitle("UIContextMenuInteraction usage", for: .normal)
//        button.addTarget(self, action: #selector(buttonClick2(sender:)), for: UIControl.Event.touchUpInside)
        if #available(iOS 13.0, *) {
            let interaction = UIContextMenuInteraction(delegate: self)
            button.addInteraction(interaction)
        }
        button.backgroundColor = .red
        return button
    }()
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [button1, button2])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.add(subview: stackView, pin: [.left, .top, .right], margin: DDMargins(top: 100, left: 0, bottom: 0, right: 0))
        stackView.setHeight(100)
        view.backgroundColor = .cyan
        // Do any additional setup after loading the view.
    }
//    @objc func buttonClick2(sender:UIButton) {
//        if #available(iOS 13.0, *) {
//            let interaction = UIContextMenuInteraction(delegate: self)
//            sender.addInteraction(interaction)
//        } else {
//            // Fallback on earlier versions
//        }
//
//    }
    @objc func buttonClick(sender:UIButton) {
        print("click")
        alert()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var view = UIApplication.shared.windows[0].subviews.first;
        var level = UIWindow.Level.normal
//        for w in UIApplication.shared.windows {
//
//            if w.windowLevel > level {
//                level = w.windowLevel
//                 view = w.subviews.first;
//            }
//        }
//        UIApplication.shared.windows.first?.windowLevel = .
        var responder : UIResponder? = view
        while responder != nil {
            print("\(responder)")
            responder = responder?.next
        }
    }
    func alert() {
        let alert = UIAlertController(title: "title", message: "message ", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "action1", style: UIAlertAction.Style.default) { (action ) in

            
        }
        let action2 = UIAlertAction(title: "action and action", style: UIAlertAction.Style.default) { (action ) in
            self.alert()
        }
        alert.addAction(action)
        alert.addAction(action2)
        self.present(alert, animated: true) {
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension AllKindOfAlert: UIContextMenuInteractionDelegate {
    @available(iOS 13.0, *)
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
                
        let actionProvider : UIContextMenuActionProvider =  { suggest in
            
            let editMenu = UIMenu(title: "Edit...", children: [
                UIAction(title: "Copy", handler: { (action) in
                    print("copy")
                }),
                UIAction(title: "paste", handler: { (action) in
                    print("paste")
                })
            ])
            return UIMenu(title: "share...", children: [
                UIAction(title: "share", handler: { (action) in
                    print("share")
                }),
                editMenu,
                UIAction(title: "delete", handler: { (action) in
                    print("delete")
                })
            ])
            
        }
        let contentViewProfider = { () -> UIViewController in
            let vc = UIViewController()
            vc.view.addSubview(UISwitch())
            vc.view.backgroundColor = .green
            return vc
        }
        return UIContextMenuConfiguration(identifier: "Unique-ID" as NSCopying, previewProvider: contentViewProfider , actionProvider: actionProvider)
    }
    
    
}

extension DDViewController {
    func testAllKindOfAlert() {
        let vc = AllKindOfAlert()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
/*
 allKindOfAlert
 (lldb) po UIApplication.shared.windows[0]
 <UIWindow: 0x101d091b0; frame = (0 0; 375 667); hidden = YES; gestureRecognizers = <NSArray: 0x2804f2b20>; layer = <UIWindowLayer: 0x280a93a80>>

 (lldb) po UIApplication.shared.windows[0].subviews
 0 elements

 (lldb) po UIApplication.shared.windows[0].windowScene
 ▿ Optional<UIWindowScene>
   - some : <UIWindowScene: 0x101d02410; scene = <FBSSceneImpl: 0x28249a980; identifier: sceneID:hhcszgd.MyPlayground.com-default>; persistentIdentifier = 014BCF74-E0EB-4E7B-9C4E-080B8BBD3B63; activationState = UISceneActivationStateForegroundActive; settingsCanvas = <UIWindowScene: 0x101d02410>; windows = (
     "<UIWindow: 0x101d091b0; frame = (0 0; 375 667); hidden = YES; gestureRecognizers = <NSArray: 0x2804f2b20>; layer = <UIWindowLayer: 0x280a93a80>>",
     "<MyPlayground.DDWindow: 0x101c13e50; baseClass = UIWindow; frame = (0 0; 375 667); gestureRecognizers = <NSArray: 0x2804c7db0>; layer = <UIWindowLayer: 0x280abc0a0>>",
     "<UITextEffectsWindow: 0x10559fda0; frame = (0 0; 375 667); opaque = NO; autoresize = W+H; layer = <UIWindowLayer: 0x280ab4440>>"
 )>

 (lldb) po UIApplication.shared.windows[0].windowScene?.windows
 ▿ Optional<Array<UIWindow>>
   ▿ some : 3 elements
     - 0 : <UIWindow: 0x101d091b0; frame = (0 0; 375 667); hidden = YES; gestureRecognizers = <NSArray: 0x2804f2b20>; layer = <UIWindowLayer: 0x280a93a80>>
     - 1 : <MyPlayground.DDWindow: 0x101c13e50; baseClass = UIWindow; frame = (0 0; 375 667); gestureRecognizers = <NSArray: 0x2804c7db0>; layer = <UIWindowLayer: 0x280abc0a0>>
     - 2 : <UITextEffectsWindow: 0x10559fda0; frame = (0 0; 375 667); opaque = NO; autoresize = W+H; layer = <UIWindowLayer: 0x280ab4440>>

 (lldb) po UIApplication.shared.windows[0].windowScene?.windows[0].subviews
 ▿ Optional<Array<UIView>>
   - some : 0 elements

 (lldb)  po UIApplication.shared.windows
 ▿ 3 elements
   - 0 : <UIWindow: 0x101d091b0; frame = (0 0; 375 667); hidden = YES; gestureRecognizers = <NSArray: 0x2804f2b20>; layer = <UIWindowLayer: 0x280a93a80>>
   - 1 : <MyPlayground.DDWindow: 0x101c13e50; baseClass = UIWindow; frame = (0 0; 375 667); gestureRecognizers = <NSArray: 0x2804c7db0>; layer = <UIWindowLayer: 0x280abc0a0>>
   - 2 : <UITextEffectsWindow: 0x10559fda0; frame = (0 0; 375 667); opaque = NO; autoresize = W+H; layer = <UIWindowLayer: 0x280ab4440>>

 (lldb)  po UIApplication.shared.windows[1]
 <MyPlayground.DDWindow: 0x101c13e50; baseClass = UIWindow; frame = (0 0; 375 667); gestureRecognizers = <NSArray: 0x2804c7db0>; layer = <UIWindowLayer: 0x280abc0a0>>

 (lldb)  po UIApplication.shared.windows[1].subviews
 ▿ 1 element
   - 0 : <UITransitionView: 0x101c17090; frame = (0 0; 375 667); autoresize = W+H; layer = <CALayer: 0x280abe9e0>>

 (lldb)  po UIApplication.shared.windows[1].subviews.first?.subviews
 ▿ Optional<Array<UIView>>
   ▿ some : 1 element
     - 0 : <UIDropShadowView: 0x101c17d00; frame = (0 0; 375 667); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x280abc3c0>>

 (lldb)  po UIApplication.shared.windows[1].subviews.first?.subviews.first?.subviews
 ▿ Optional<Array<UIView>>
   ▿ some : 1 element
     - 0 : <UILayoutContainerView: 0x101c149a0; frame = (0 0; 375 667); clipsToBounds = YES; autoresize = W+H; gestureRecognizers = <NSArray: 0x2804c76f0>; layer = <CALayer: 0x280abc1a0>>

 (lldb)  po UIApplication.shared.windows[1].subviews.first?.subviews.first?.subviews.first?.subviews
 ▿ Optional<Array<UIView>>
   ▿ some : 2 elements
     - 0 : <UINavigationTransitionView: 0x101c160b0; frame = (0 0; 375 667); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x280abc160>>
     - 1 : <UINavigationBar: 0x101c14d20; frame = (0 20; 375 44); opaque = NO; autoresize = W; userInteractionEnabled = NO; tintColor = UIExtendedGrayColorSpace 1 1; layer = <CALayer: 0x280abc120>>

 (lldb)  po UIApplication.shared.windows[1].subviews.first?.subviews.first?.subviews.first?.subviews.first?.subviews
 ▿ Optional<Array<UIView>>
   ▿ some : 1 element
     - 0 : <UIViewControllerWrapperView: 0x105578950; frame = (0 0; 375 667); autoresize = W+H; layer = <CALayer: 0x280a86f00>>

 (lldb)  po UIApplication.shared.windows[1].subviews.first?.subviews.first?.subviews.first?.subviews.first?.subviews.first?.subviews
 ▿ Optional<Array<UIView>>
   ▿ some : 1 element
     - 0 : <UIView: 0x101d011a0; frame = (0 0; 375 667); autoresize = W+H; layer = <CALayer: 0x280a919a0>>

 (lldb)  po UIApplication.shared.windows[1].subviews.first?.subviews.first?.subviews.first?.subviews.first?.subviews.first?.subviews.first?.next
 ▿ Optional<UIResponder>
   ▿ some : <MyPlayground.AllKindOfAlert: 0x101d0dcb0>
 
 
 (lldb)  po UIApplication.shared.windows[1].isHidden
 false

 (lldb)  po UIApplication.shared.windows[0].isHidden
 true

 (lldb)  po UIApplication.shared.windows[2].isHidden
 false
 
 结论:iOS13 想要获取当前显示的window中appDelegat中设置的那个window, 不能用keyWindow来获取 , 也不能用windowLevel来获取, 也不能用下标为0来获取 , 只能自定义一个CustomWindow, 再遍历UIApplication.shared.windows 对比类是否为CustomWindow 的方式,
 */
