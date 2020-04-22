//
//  SwiftAssociatedTypes.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/4/22.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

class SwiftAssociatedTypes: NSObject {

}
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}

///Generic Subscripts

///Subscripts can be generic, and they can include generic where clauses. You write the placeholder type name inside angle brackets after subscript, and you write a generic where clause right before the opening curly brace of the subscript’s body. For example:

extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result = [Item]()
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}


struct IntStack: Container {
    // original IntStack implementation
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}
struct Stack<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}











/**
 
 不透明类型
 // Error: Protocol with associated types can't be used as a return type.
 func makeProtocolContainer<T>(item: T) -> Container {
     return [item]
 }

 // Error: Not enough information to infer C.
 func makeProtocolContainer<T, C: Container>(item: T) -> C {
     return [item]
 }
 Using the opaque type some Container as a return type expresses the desired API contract—the function returns a container, but declines to specify the container’s type:

 func makeOpaqueContainer<T>(item: T) -> some Container {
     return [item]
 }
 let opaqueContainer = makeOpaqueContainer(item: 12)
 let twelve = opaqueContainer[0]
 print(type(of: twelve))
 // Prints "Int"

 */
/**
 在值类型(结构体, 枚举等)内部修改其自身属性, 需要在修改行为所在的方法前加关键字mutating
 Modifying Value Types from Within Instance Methods
 Structures and enumerations are value types. By default, the properties of a value type cannot be modified from within its instance methods.

 However, if you need to modify the properties of your structure or enumeration within a particular method, you can opt in to mutating behavior for that method. The method can then mutate (that is, change) its properties from within the method, and any changes that it makes are written back to the original structure when the method ends. The method can also assign a completely new instance to its implicit self property, and this new instance will replace the existing one when the method ends.

 You can opt in to this behavior by placing the mutating keyword before the func keyword for that method:

 struct Point {
     var x = 0.0, y = 0.0
     mutating func moveBy(x deltaX: Double, y deltaY: Double) {
         x += deltaX
         y += deltaY
     }
 }
 var somePoint = Point(x: 1.0, y: 1.0)
 somePoint.moveBy(x: 2.0, y: 3.0)
 print("The point is now at (\(somePoint.x), \(somePoint.y))")
 // Prints "The point is now at (3.0, 4.0)"
 The Point structure above defines a mutating moveBy(x:y:) method, which moves a Point instance by a certain amount. Instead of returning a new point, this method actually modifies the point on which it is called. The mutating keyword is added to its definition to enable it to modify its properties.
 
 
 当结构体的对象是let常量的时候, 再调用包含 mutating 的方法会报错
 Note that you cannot call a mutating method on a constant of structure type, because its properties cannot be changed, even if they are variable properties, as described in Stored Properties of Constant Structure Instances:

 let fixedPoint = Point(x: 3.0, y: 3.0)
 fixedPoint.moveBy(x: 2.0, y: 3.0)
 // this will report an error
 
 
 let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
 // this range represents integer values 0, 1, 2, and 3
 rangeOfFourItems.firstValue = 6
 // this will report an error, even though firstValue is a variable property
 */
