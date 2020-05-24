//
//  RXStudentModel.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/5/24.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

import RealmSwift
class RXStudentModel: Object {//集成自realm的Object类
    @objc dynamic var name = "nil"
       @objc dynamic var age = 0000
       @objc dynamic var weight = 0000
    @objc dynamic var id = UUID().uuidString
       @objc dynamic var address = "nil"
       @objc dynamic var birthday : NSDate? = nil
       @objc dynamic var photo : NSData?  = nil
       
       //重写 Object.primaryKey() 可以设置模型的主键。
       //声明主键之后，对象将被允许查询，更新速度更加高效，并且要求每个对象保持唯一性。
       //一旦带有主键的对象被添加到 Realm 之后，该对象的主键将不可修改。
       override static func primaryKey() -> String? {
           return "id"
       }
       
       //重写 Object.ignoredProperties() 可以防止 Realm 存储数据模型的某个属性
       override static func ignoredProperties() -> [String] {
           return ["tempID"]
       }
       
       //重写 Object.indexedProperties() 方法可以为数据模型中需要添加索引的属性建立索引，Realm 支持为字符串、整型、布尔值以及 Date 属性建立索引。
       override static func indexedProperties() -> [String] {
           return ["name"]
       }
       
       //List 用来表示一对多的关系：一个 Student 中拥有多个 Book。注意：List 只能够包含 Object 类型，不能包含诸如String之类的基础类型。
       let books = List<RXBookModel>()
}
extension RXStudentModel {
    /// 获取 所保存的 Student
      public class func getStudents() -> Results<RXStudentModel> {
          let defaultRealm = RealmTool.getDB()
          return defaultRealm.objects(RXStudentModel.self)
      }
}

class RXBookModel: Object {
    @objc dynamic var name = "nil"
    @objc dynamic var author = "nil"
    
    /// LinkingObjects 反向表示该对象的拥有者
    let owners = LinkingObjects(fromType: RXStudentModel.self, property: "books")
}


class RealmTool: Object {
    class func getDB() -> Realm {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        print("数据库path: \(docPath)")
        let dbPath = docPath.appending("/defaultDB.realm")
        /// 传入路径会自动创建数据库
        let defaultRealm = try! Realm(fileURL: URL.init(string: dbPath)!)
        return defaultRealm
    }
}
