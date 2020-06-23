//
//  PropertyWrapperCase.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/6/22.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import Foundation
@propertyWrapper
struct Clamping<Value: Comparable> {
    var value: Value
    let range: ClosedRange<Value>

    init(wrappedValue initialValue: Value, _ range: ClosedRange<Value>) {
        precondition(range.contains(initialValue))// if initialValue is bigger than range.upper , will crash here
        self.value = initialValue
        self.range = range
    }

    var wrappedValue: Value {
        get { value }
        set { value = min(max(range.lowerBound, newValue), range.upperBound) }
    }
}
struct Solution {
    @Clamping(0...14) var pH: Double = 7.0
}

let carbonicAcid1 = Solution(pH: 4.68) // everything goes well
//let carbonicAcid2 = Solution(pH: 100) // will crash at precondition

////////////////////
@propertyWrapper
struct Trimmed {
    private(set) var value: String = ""

    var wrappedValue: String {
        get { value }
        set { value = newValue.trimmingCharacters(in: .whitespacesAndNewlines) }
    }

    init(wrappedValue initialValue: String) {
        self.wrappedValue = initialValue
    }
}

struct Post {
    @Trimmed var title: String
    var body: String
}

func testPropertyWrapper() {
    var quine = Post(title: "  Swift Property Wrappers  ", body: "  hello world    ")
    print("print title 1:\(quine.title)") // "Swift Property Wrappers" (no leading or trailing spaces!)
    print("print body 1:\(quine.body)") // "  hello world    " (exist leading or trailing spaces!)
    
    quine.title = "      @propertyWrapper     "
    quine.body = "      this is bodyyyy     "
    print("print title 2:\(quine.title)") // "@propertyWrapper" (still no leading or trailing spaces!)
    print("print body 2:\(quine.body)")// "      this is bodyyyy     " (exist leading or trailing spaces!)
}
