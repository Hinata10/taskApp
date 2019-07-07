//
//  Task.swift
//  taskApp
//
//  Created by 日向亮博 on 2019/07/03.
//  Copyright © 2019 Hinata10. All rights reserved.
//
import Foundation
import RealmSwift

class Task: Object{
    //管理用ID、プライマリーキー
    @objc dynamic var id = 0
    //タイトル
    @objc dynamic var title = ""
    //内容
    @objc dynamic var contents = ""
    //日時
    @objc dynamic var date = Date()
    //カテゴリをタスクに追加
    @objc dynamic var category = ""
    //idをプライマリーキーとして設定
    override static func primaryKey() -> String?{
        return "id"
    }
    
    
}
