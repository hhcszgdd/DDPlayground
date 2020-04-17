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
