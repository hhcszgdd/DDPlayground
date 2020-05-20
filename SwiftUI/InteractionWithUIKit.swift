//
//  InteractionWithUIKit.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/4/13.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

//MARK: warning , you must choose ios13 deveice or simulator , or you will get compile error

import SwiftUI

@available(iOS 13.0, *)
struct ContentView: View{
    var body: some View {
        VStack {
            VCUsedInSwiftUI()
            Text("hello world")
            ViewUsedInSwiftUI(value: $t)
        }
    }
    @State private var t: Double = 2.2;
}

@available(iOS 13.0, *)
struct InteractionWithUIKit_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension DDViewController {
    func testSwiftUI() {
        if #available(iOS 13.0, *) {
            let vc = UIHostingController(rootView: ContentView())
                // ios 13下设置导航栏背景色
            vc.setupNavigationBarAppearance(style:.blue)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
