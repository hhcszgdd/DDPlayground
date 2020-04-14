//
//  InteractionWithUIKit.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/4/13.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

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
