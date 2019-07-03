//
//  ViewController.swift
//  taskApp
//
//  Created by 日向亮博 on 2019/06/26.
//  Copyright © 2019 Hinata10. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//UITableViewDelegateとUITableViewDataSourceプロトコルを追加しそれぞれのメソッドを実装する。
    //IBOutlet接続してプロパティ化した。
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }
    //MARK: UITableViewDataSourceのプロトコルのメソッドを以下に示す。
    //まずデータの数を返すメソッド(メソッドなのでfuncを使う)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 0
    }
    //次に各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //再利用可能なcellを得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    //MARK: UITableViewDelegateプロトコルのメソッド
    //各セルの選択時のメソッド ->didSlectRowAtせ: セルタップ時タスク入力画面に遷移する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "cellSegue", sender: nil) //セルをタップ時の遷移
    }
    //セルが削除可能であるエディタブルである事を伝えるメソッド ->editingStylrForRowAt: セルが削除可能
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
        return.delete //削除可能にするため.deleteを返す。
    }
    //Deleteが押された時に呼ばれるメソッド ->commit: forRowAt: Deleteが押された時ローカル通知キャンセルしデータベースからタスクを削除できる。
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
    }

}

