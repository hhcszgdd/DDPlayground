//
//  SortFunction.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/3/5.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

class SortFunction: NSObject {
    static let share = SortFunction()
    func test() {
           let intArr = [1,40,3,1,4,2,5,333,444,555,999,1,3,2,4,5].quickSorted()
           let floatArr = [0.5,0.13,0.54,0.75,0.93,0.1,0.42,0.3,0.1,0.4,0.2].quickSorted()
           print("print int result:\(intArr)")
           print("print float result:\(floatArr)")
    }

}
extension Array where Element: Comparable {
    
    public func quickSorted() -> Array {
        return quickSort(leftCursorOriginIndex: 0, rightCursorOriginIndex: self.count - 1)
    }
    
    private func quickSort(leftCursorOriginIndex: Int, rightCursorOriginIndex: Int) -> Array {
        guard !self.isEmpty else { return [] }//如果空直接返回
        if leftCursorOriginIndex >= rightCursorOriginIndex { return self }// 结束迭代条件:如果左右游标碰头,退出迭代
        var leftCursorIndex = leftCursorOriginIndex//左游标变量,找大数字时移动
        var rightCursorIndex = rightCursorOriginIndex//右游标变量,找小数字时移动
        var array = self
        let flagValue = array[leftCursorOriginIndex]//参考值
        while rightCursorIndex > leftCursorIndex {//只有左右游标不碰头就一直找
            while  array[rightCursorIndex] >= flagValue &&  leftCursorIndex < rightCursorIndex{//左游标小于右游标的前提下,从右往左找小于参考值元素的坐标
                rightCursorIndex -= 1
            }
            while  array[leftCursorIndex] <= flagValue && leftCursorIndex < rightCursorIndex{//左游标小于右游标的前提下,从左往右找大于参考值元素的坐标
                leftCursorIndex += 1
            }
            array.swapAt(leftCursorIndex, rightCursorIndex)
        }
        if array[leftCursorOriginIndex] > array[leftCursorIndex] {//只要游标停止的位置的元素小于第一个参考值,就交换元素值
            array.swapAt(leftCursorOriginIndex, leftCursorIndex)
        }
        array = array.quickSort(leftCursorOriginIndex: leftCursorOriginIndex, rightCursorOriginIndex: leftCursorIndex - 1)
        array = array.quickSort(leftCursorOriginIndex: rightCursorIndex + 1, rightCursorOriginIndex: rightCursorOriginIndex)
        return array
    }
}
