//
//  WebSocketCase.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/4/28.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

@available (iOS 13, *)
class WebSocketCase: NSObject {
    static let share : WebSocketCase = WebSocketCase()
    var tapCount = 0
    
    lazy var task: URLSessionWebSocketTask  = {
        let url = URL(string: "ws://localhost:59840")!
        
//        let url = URL(string: "ws://121.40.165.18:8800")!
        
        let tempTask = URLSession.shared.webSocketTask(with: url)
        
        tempTask.resume()
        tempTask.send(URLSessionWebSocketTask.Message.string("hello")) { (error) in
            print(error)
        }
        tempTask.send(URLSessionWebSocketTask.Message.string("hello")) { (error) in
            print(error)
        }
        tempTask.receive { (result) in
            print(result)
        }
//        tempTask.sendPing { (error) in
//            print("ping error: \(error)")
//        }
        return tempTask
    }()
    func test() {
        if tapCount == 0 {
            tapCount += 1
            task.send(URLSessionWebSocketTask.Message.string("hello")) { (error) in
                print(error)
            }
        }else {
            task.send(URLSessionWebSocketTask.Message.string("hello")) { (error) in
                print(error)
            }
        }
    }
}
