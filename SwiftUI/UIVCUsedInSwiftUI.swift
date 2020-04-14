//
//  UIVCUsedInSwiftUI.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/4/13.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
import SwiftUI

class UIVCUsedInSwiftUI: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
//        Representable
        // Do any additional setup after loading the view.
    }
    func swiftUIUsedInUIKit() {
        if #available(iOS 13.0, *) {
            let vc = UIHostingController(rootView: ContentView())
            self.present(vc , animated: true , completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }
}





// convert UIKit (UIVCUsedInSwiftUI) to SwiftUI (VCUsedInSwiftUI)
@available(iOS 13.0, *)
struct VCUsedInSwiftUI: UIViewControllerRepresentable{
    typealias UIViewControllerType = UIVCUsedInSwiftUI
    func makeUIViewController(context: UIViewControllerRepresentableContext<VCUsedInSwiftUI>) -> VCUsedInSwiftUI.UIViewControllerType {
        return UIVCUsedInSwiftUI()
    }
    func updateUIViewController(_ uiViewController: UIVCUsedInSwiftUI, context: UIViewControllerRepresentableContext<VCUsedInSwiftUI>) {
    }
}
