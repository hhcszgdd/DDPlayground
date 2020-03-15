//
//  DDMultipleThread.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/3/13.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

class DDMultipleThread: NSObject {
    static let share: DDMultipleThread = DDMultipleThread()
    var blockOperation: BlockOperation?
    var queue : OperationQueue = OperationQueue()
    lazy var dispatchGroup = DispatchGroup()
    func testGCDSync() {
        DispatchQueue.global().async(group: dispatchGroup, execute: DispatchWorkItem(block: {
            print("task 1")
        }))
        
        DispatchQueue.global().async(group: dispatchGroup, execute: DispatchWorkItem(block: {
            print("task 2")
        }))
        
        dispatchGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem.init(block: {
            print("group over")
        }))
    }
    func testThread() {
        let thread = Thread {
            print("nothing necessary is be test")
        }
        thread.start()
    }
    func testGCDAsync() {
        DispatchQueue.global().async(group: dispatchGroup, execute: DispatchWorkItem(block: {
            DispatchQueue.main.async {//main: be executed before over
                sleep(3)
                print("task 1")
            }
        }))
        
        DispatchQueue.global().async(group: dispatchGroup, execute: DispatchWorkItem(block: {
            DispatchQueue.global().async {//global: be executed after over,it is not what I want
                sleep(5)
                print("task 2")
            }
        }))
        
        DispatchQueue.global().async(group: dispatchGroup, execute: DispatchWorkItem(block: {
            self.dispatchGroup.enter()
            DispatchQueue.global().async {// be executed before over,it is what I want, great !!
                sleep(4)
                print("task 3")
                self.dispatchGroup.leave()
            }
        }))
        
        dispatchGroup.notify(queue: DispatchQueue.global(), work: DispatchWorkItem.init(block: {
            print("group over")
        }))
    }
    
    func testBlockOperation() {
        blockOperation = BlockOperation {
            let sema = DispatchSemaphore.init(value: 0)//step 1
            DispatchQueue.global().async {
                for i in 0...10000 {
                    if i == 10000 {print("task in concurrent is executed")}
                }
                sema.signal() //step 2, invoke after task, this can convert async to sync
            }
            sema.wait()//step 3
        }
        blockOperation?.completionBlock = { print(" operation is done ") }
        blockOperation?.start()
    }
    func testOperationQueueWithConcurrent() {
        operation3.addDependency(operation2)
        operation2.addDependency(operation1)
        //        queue.maxConcurrentOperationCount = 1
        print("\n\n👿")
        queue.addOperation(operation1)
        queue.addOperation(operation2)
        queue.addOperation(operation3)
    }
    
    lazy var operation1 = BlockOperation {
        DispatchQueue.global().async {
            print("1")
        }
    }
    lazy var operation2 = BlockOperation {
        DispatchQueue.global().async {
            print("2")
        }
    }
    lazy var operation3 = BlockOperation {
        DispatchQueue.global().async {
            print("3")
        }
    }
    
    var o :BlockOperation?
    var t : URLSessionDataTask?
}

extension DDMultipleThread {
    
    func testBlockOperationWithQuery() {
        o = BlockOperation {
            print("....\(Thread.current)")
        }
        o?.addExecutionBlock {
            DispatchQueue.global().sync {
                var request = URLRequest(url: URL(string: "https://www.baidu.com")!)
                request.httpMethod = "GET"
                self.t = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    print("ttttt complate")
                    print("Data: \(String(data: data!, encoding: String.Encoding.utf8))")
                    print("response: \(response)")
                    print("error: \(error) ,,,\(Thread.current)")
                }
                self.t?.resume()
                
            }
        }
        //        o?.addDependency(T##op: Operation##Operation)
        o?.completionBlock = {
            print("✌️task 1 is over")
            print(".>>>\(Thread.current)")
        }
        o?.start()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.0000000001) {
            self.o?.cancel()
        }
    }
}
