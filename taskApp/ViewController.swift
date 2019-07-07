//
//  ViewController.swift
//  taskApp
//
//  Created by 日向亮博 on 2019/06/26.
//  Copyright © 2019 Hinata10. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
//UITableViewDelegateとUITableViewDataSourceプロトコルを追加しそれぞれのメソッドを実装する。
    //IBOutlet接続してプロパティ化した。
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var kensaku: UISearchBar!
    
    let realm = try! Realm()//Realmのインスタンスを取得
    //DB内のタスク格納がされるリスト
    //日付が近い順番でソート（降順）
    //以降内容をアップデート毎に自動更新
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: false)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        kensaku.delegate = self
        kensaku.showsCancelButton = true
        kensaku.placeholder = "カテゴリを入力してください" //プレースホルダーの指定
        kensaku.layer.masksToBounds = true
        kensaku.tintColor = UIColor.blue
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let inputViewController:InputViewController = segue.destination as! InputViewController
        if segue.identifier == "cellSegue"{
            let indexPath = self.tableView.indexPathForSelectedRow
            inputViewController.task = taskArray[indexPath!.row]
        }else{
            let task = Task()
            task.date = Date()
            let allTasks = realm.objects(Task.self)
            if allTasks.count != 0{
                task.id = allTasks.max(ofProperty: "id")! + 1
            }
            inputViewController.task = task
        }
    }//下に入力画面から戻って来た時にTableViewを更新させるviewWillAppearを記述
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    //MARK: UITableViewDataSourceのプロトコルのメソッドを以下に示す。
    //まずデータの数を返すメソッド(メソッドなのでfuncを使う)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return taskArray.count
    }
    //次に各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //再利用可能なcellを得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//           以下修正、Cellに値を設定した。
        let task = taskArray[indexPath.row]
        cell.textLabel?.text = task.title
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString:String = formatter.string(from: task.date)
        cell.detailTextLabel?.text = dateString
        
        return cell
    }
    //MARK: UITableViewDelegateプロトコルのメソッド
    //各セルの選択時のメソッド ->didSlectRowAtせ: セルタップ時タスク入力画面に遷移する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "cellSegue", sender: nil) //セルをタップ時の遷移
    }
    //セルが削除可能であるエディタブルである事を伝えるメソッド ->editingStylrForRowAt: セルが削除可能
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
        return .delete //削除可能にするため.deleteを返す。
    }
    //Deleteが押された時に呼ばれるメソッド ->commit: forRowAt: Deleteが押された時ローカル通知キャンセルしデータベースからタスクを削除できる。
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            //削除するタスクを取得する
            let task = self.taskArray[indexPath.row]
            //ローカル通知をキャンセルする。
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [String(task.id)])
            //データベースから削除する
            try! realm.write{
                self.realm.delete(self.taskArray[indexPath.row])
                self.realm.delete(task)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            //未通知のローカル通知一覧をログ出力
            center.getPendingNotificationRequests{(requests: [UNNotificationRequest]) in
                for request in requests{
                    print("/------------/")
                    print(request)
                    print("/------------/")
                }
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("検索ボタンがタップ")
        let searchText = searchBar.text!
        print(searchText)
        taskArray = realm.objects(Task.self).filter("category == %@", searchText)
//        let predicate = NSPredicate(format: "category %@", taskArray)
//        results = realm.objects(Task.self).filter(predicate)
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("キャンセルボタンがタップ")
        kensaku.resignFirstResponder() //キャンセルを押したらキーボードを閉じて編集を中断
        taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: false)
        tableView.reloadData()
    }
}

