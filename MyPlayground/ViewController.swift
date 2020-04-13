//
//  ViewController.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/2/29.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
class ViewController: DDViewController {
    lazy var tableView: UITableView = {
        let result = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        result.delegate = self
        result.dataSource = self
        return result
    }()
    override var naviBarStyle: DDNavigationBarStyle { return .green }
    lazy var emitterView: DDEmojiEmitterView = {
        let result = DDEmojiEmitterView(frame: view.bounds)
        view.addSubview(result)
        return result
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.add(subview: tableView, pin: .all)
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor(named: "DDDarkAndWhireColor")
        } else {
            // Fallback on earlier versions
            view.backgroundColor = UIColor.darkGray
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DDAction.allCases.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if let c = tableView.dequeueReusableCell(withIdentifier: "DDCell") {
            cell = c
        }else {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "DDCell")
        }
        cell.textLabel?.text = "will be perform action : \(DDAction.allCases[indexPath.row].rawValue)"
        return cell
    }
    
    @available(iOS 13.0, *)
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
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
        return UIContextMenuConfiguration(identifier: "Unique-ID" as NSCopying, previewProvider: nil , actionProvider: actionProvider)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        willBePerformAction(action: DDAction.allCases[indexPath.row])
    }
}


extension ViewController {

}

extension ViewController {
    func changeAlongToPushAnimation() {
        transitionCoordinator?.animate(alongsideTransition: { (context) in
            // make some change
        }, completion: { (context) in
            
        })
    }

}
