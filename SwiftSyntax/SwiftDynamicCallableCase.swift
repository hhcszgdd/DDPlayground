//
//  SwiftDynamicCallableCase.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/4/21.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

class SwiftDynamicCallableCase: NSObject {
//    class var testClass = ""//error: Class stored properties not supported in classes; did you mean 'static'?
    static var testStatic = ""
    static let share: SwiftDynamicCallableCase = SwiftDynamicCallableCase()
    func test() {
        let student = DDStudent()
        let name: String = student.name
        
        let city: String = student.city
        let age : Int = student.age
        let studentNumber : Int = student.studentNumber
        let wrongKey : String = student.wrongKey
        print("name:\(name)")
        print("city:\(city)")
        print("age:\(age)")
        print("studentNumber:\(studentNumber)")
        print("wrongKey:\(wrongKey)")
        
        let teacher = DDTeacher()
        let b = teacher[2]
        let a = DDTeacher[6]
        let c = teacher[2,3]
        
        
        let bird = DDBird()
        bird(1,3,4,5,6)
        bird(hello : 11 , world:22 , fuck:33)
        bird("","","")
    }
}


/// 动态类型查找
@dynamicMemberLookup class DDStudent  {
    private let _name = "John Lock"
    private let _city = "Lu Yi"
    private let _age = 18
    private let _studentNumber = 20090244
    subscript(dynamicMember member:String) -> String{
        if member == "name" { return _name }
        else if member == "city" { return _city }
        else { return "xxxxxx" }
    }
    subscript(dynamicMember member:String) -> Int{
        if member == "studentNumber" { return _studentNumber }
        else if member == "age" { return _age }
        else { return 999999 }
    }
}
///Classes, structures, and enumerations can define subscripts 下标 https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
//let mars = Planet[4]
//print(mars)
/**
 语法
 get/set
 subscript(index: Int) -> Int {
     get {
         // Return an appropriate subscript value here.
     }
     set(newValue) {
         // Perform a suitable setting action here.
     }
 }
 或
 get
 subscript(index: Int) -> Int {
     // Return an appropriate subscript value here.
 }
 */
class DDTeacher  {
    private let _name = "John Lock"
    private let _city = "Lu Yi"
    private let _age = 18
    private var _studentNumber = 20090244
    
    subscript(index: Int) -> Int {//teacher[33]
        get {
            // Return an appropriate subscript value here.
            return _age
        }
        set(newValue) {
            // Perform a suitable setting action here.
            _studentNumber = newValue
        }
    }
    
    static subscript(index: Int) -> Int {//DDTeacher[22]
        get {
            // Return an appropriate subscript value here.
            return 0000
        }
        set(newValue) {
            // Perform a suitable setting action here.
            
        }
    }
    
    subscript(age: Int, studentNumber: Int) -> Int {//teacher[2,3]
        return age * studentNumber
    }
    
    
}

@dynamicCallable class DDBird  {
    
    /// 对象加括号可以间接调用这个方法
    ///let b = DDBird()
    ///b(1,3,4,5,6)
    /// - Parameter withArguments: 必须是符合ExpressibleByArrayLiteral类型
    ///这个方法也可以有任意类型的返回值
    func dynamicallyCall(withArguments: [Int]){
        
        print("oooo")
        print(withArguments)//[1, 3, 4, 5, 6]
    }
    
    func dynamicallyCall(withArguments: [String]){
        
        print("bbbb")
        print(withArguments)//[1, 3, 4, 5, 6]
    }
    
    /// 对象加括号可以间接调用这个方法
    ///     ///let b = DDBird()
    ///b(hello : 11 , world:22 , fuck:33)
    /// - Parameter withKeywordArguments: 必须符合ExpressibleByDictionaryLiteral类型
    ///这个方法也可以有任意类型的返回值
    func dynamicallyCall(withKeywordArguments:KeyValuePairs<String , Int>){
        print("xxxx")
        print(withKeywordArguments)//["hello": 11, "world": 22, "fuck": 33]
        let dictArr = withKeywordArguments.map { (key, value) -> Dictionary<String , Int > in
            
            var dict = Dictionary<String,Int>()
            dict[key] = value
            return dict
        }
        print(dictArr)
    }
}

extension DDViewController {
    func testSwiftDynamicCallable()  {
        SwiftDynamicCallableCase.share.test()
    }
}
