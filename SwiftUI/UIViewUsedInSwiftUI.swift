//
//  UIViewUsedInSwiftUI.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/4/13.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
import SwiftUI
class UIViewUsedInSwiftUI: UIView {
    let textLabel = UILabel()
    convenience init(num:Double) {
        self.init(frame:CGRect.zero)
        addSubview(textLabel)
        textLabel.text = "\(num)"
        textLabel.sizeToFit()
        backgroundColor = .red
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(textLabel)
//        backgroundColor = .red
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

///convert UIKit View to swiftUI
@available(iOS 13.0, *)
struct ViewUsedInSwiftUI: UIViewRepresentable{
    @Binding var value: Double
    func makeUIView(context: UIViewRepresentableContext<ViewUsedInSwiftUI>) -> UIViewUsedInSwiftUI {
//        return UIViewUsedInSwiftUI(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
        return UIViewUsedInSwiftUI(num: value)
    }
    
    func updateUIView(_ uiView: UIViewUsedInSwiftUI, context: UIViewRepresentableContext<ViewUsedInSwiftUI>) {
        
    }
    
    typealias UIViewType = UIViewUsedInSwiftUI

    class Coordinator: NSObject {
       var value: Binding<Double>
       init(value: Binding<Double>) {
         self.value = value
       }
           
       @objc func valueChanged(_ sender: UISlider) {
         self.value.wrappedValue = Double(sender.value)
       }
     }
       
     func makeCoordinator() -> ViewUsedInSwiftUI.Coordinator {
       return Coordinator(value: $value)
     }
}
