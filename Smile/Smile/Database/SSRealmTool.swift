//
//  SSRealmTool.swift
//  Smile
//
//  Created by 李金 on 1/19/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit
import RealmSwift

class SSRealmTool: NSObject {
    /// 数据库版本号
    static var schemaVersion: UInt64 = 0
    
    /// 唯一的数据库操作的 Realm
    static let ss_realm = realm()
    
    /// 获取数据库操作的 Realm
    private static func realm() -> Realm {
        
        // 获取数据库文件路径
        let fileURL = URL(string: NSHomeDirectory() + "/Documents/Scanner.realm")
        print("data base file path: ", fileURL?.absoluteString)
        // 在 APPdelegate 中需要配置版本号时，这里也需要配置版本号
        let config = Realm.Configuration(fileURL: fileURL, schemaVersion: schemaVersion)
        
        return try! Realm(configuration: config)
    }}
