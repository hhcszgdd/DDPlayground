//
//  Swift52.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/4/21.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import Foundation
/*
Swift5 的# 与字符串格式化

Swift 5添加转义字符串的新方式。 您在字符串的开头和结尾添加#，这样您就可以使用反斜杠和引号而不会出现问题。SE-0200：

在原始字符串中使用字符串插值时，必须在反斜杠后使用#号：

        let str = "swift5.0"
         //\n会被直接输出 , are两边的双引号会被直接输出 , you里面的\也会直接输出
        print(#"hello\#(str) \n how "are" y\ou"#)//helloswift5.0 \n how "are" y\ou
        //\n会被转义成换行 , are两边的双引号需要用\来转义才会被输出 , you里面的\需要另一个\转义才也会被输出
        print("henllo\(str) \n ,how \"are\" y\\ou")//henlloswift5.0
        //,how "are" y\ou
        

Swift 5使用原始字符串简化了正则表达式：
在此代码中，您使用反斜杠数量的一半来编写正则表达式，因为您不需要在原始字符串中转义反斜杠。
let regex = try! NSRegularExpression(pattern: #"\d\.\d"#)

Swift 5为Character添加了属性 您使用isNumber来检查每个字符是否都是数字
id.forEach { digits += $0.isNumber ? 1 : 0 }
*/
