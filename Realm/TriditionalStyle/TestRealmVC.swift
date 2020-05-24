//
//  TestRealmVC.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/5/24.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
class TestRealmVC: DDViewController {
    override var naviBarStyle: DDNavigationBarStyle { return .blue }
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor(named: "DDDarkAndWhireColor")
        } else {
            // Fallback on earlier versions
            view.backgroundColor = UIColor.darkGray
        }
    }
    

    public class func configRealm() {
        /// 如果要存储的数据模型属性发生变化,需要配置当前版本号比之前大
        let dbVersion : UInt64 = 2
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPath.appending("/defaultDB.realm")
        let config = Realm.Configuration(fileURL: URL.init(string: dbPath), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: dbVersion, migrationBlock: { (migration, oldSchemaVersion) in
            
        }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
        Realm.Configuration.defaultConfiguration = config
        Realm.asyncOpen { (realm, error) in
            if let _ = realm {
                print("Realm 服务器配置成功!")
            }else if let error = error {
                print("Realm 数据库配置失败：\(error.localizedDescription)")
            }
        }
    }
}
