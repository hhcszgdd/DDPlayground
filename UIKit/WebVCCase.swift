//
//  WebVCCase.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/4/22.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import SafariServices
extension UIViewController: SFSafariViewControllerDelegate {
    func showWebVC(url: URL = URL(string: "https://m.baidu.com")!) {
        let sfVC : SFSafariViewController!
        if #available(iOS 11.0, *) {
            let config = SFSafariViewController.Configuration()
            config.barCollapsingEnabled = false
            sfVC = SFSafariViewController(url: url, configuration: config)
            sfVC.setupNavigationBarAppearance(style: DDNavigationBarStyle.blue)
            sfVC.preferredBarTintColor = .blue
        } else {
            sfVC = SFSafariViewController(url: url)
        }
        sfVC.delegate = self
        
//        sfVC.modalPresentationStyle = .formSheet
        self.present(sfVC, animated: true, completion: nil)
    }
    
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
