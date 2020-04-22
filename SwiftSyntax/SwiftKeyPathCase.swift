//
//  SwiftKeyPathCase.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/4/21.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import Foundation

class SwiftKeyPathCase: NSObject {
    static let share : SwiftKeyPathCase = SwiftKeyPathCase()
    var nameObserver :NSKeyValueObservation?
    var ageObserver :NSKeyValueObservation?
    lazy var personWillBeOvserved : Person = {
        let p = Person()
        nameObserver = p.observe(\Person.name, options: [ .new, .old ]) { (person, observedChange) in
            print("name : \(person.name)")
            print("old name : \(observedChange.oldValue ?? "nil old value")")
            print("new name : \(observedChange.newValue ?? "nil new value")")
        }
        ageObserver = p.observe(\Person.age, options: [ .new, .old ]) { (person, observedChange) in
                   print("age : \(person.age)")
                   print("old age : \(observedChange.oldValue ?? 0)")
                   print("new age : \(observedChange.newValue ?? 0)")
               }
        return p;
    }()
    
    func changeNameOfPersonByKeyPath(newName:String = "1") {
        let oldNameValue = getPropertyValueOfSomeClass(someClassInstance: personWillBeOvserved, keyPath: \Person.name)
        setPropertyValueOfSomeClass(someClassInstance: personWillBeOvserved, propertyValue:"✌️\(oldNameValue) + \(newName)🙌" , keyPath: \Person.name)
    }
    
    func changeAgeOfPersonByKeyPath(newAge:Int = 1) {
        let oldAge = getPropertyValueOfSomeClass(someClassInstance: personWillBeOvserved, keyPath: \Person.age)
        setPropertyValueOfSomeClass(someClassInstance: personWillBeOvserved, propertyValue:newAge + oldAge , keyPath: \Person.age)
    }
    
    @discardableResult
    func getPropertyValueOfSomeClass<SomeClass,PropertyType>(someClassInstance: SomeClass, keyPath: KeyPath<SomeClass,PropertyType>) -> PropertyType{
        let property = someClassInstance[keyPath: keyPath]
        return property
    }
    func setPropertyValueOfSomeClass<SomeClass,PropertyType>(someClassInstance: SomeClass, propertyValue: PropertyType, keyPath: ReferenceWritableKeyPath<SomeClass,PropertyType>)  {
        someClassInstance[keyPath: keyPath] = propertyValue
    }
}
///另外一件事就是被观察的属性 需要用 dynamic 修饰 ，否则也无法观察到。
/// 若是希望通过kvo检测某个属性, 有两种方式:
/// 方法1: 在该属性前添加 @objc dynamic 来修饰即可
/// 方法2: 在该属性所在的类前用 @objcMembers修饰 , 且该属性用dynamic 修饰
//@objcMembers
class Person : NSObject {
//    dynamic var name : String = "default value"
    @objc dynamic var name : String = "default value"
    @objc dynamic var age : Int = 0
}

func setter<Object: AnyObject, Value>( for object: Object,  keyPath: ReferenceWritableKeyPath<Object, Value>
) -> (Value) -> Void {
    return { [weak object] value in
        object?[keyPath: keyPath] = value
    }
}


extension DDViewController {
    func testSwiftKeyPath() {
        //        SwiftKeyPathCase.share.changeNameOfPersonByKeyPath(newName:"John Connor")
        SwiftKeyPathCase.share.changeAgeOfPersonByKeyPath(newAge:1)
    }
    
}
