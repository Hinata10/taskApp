//
//  InputViewController.swift
//  taskApp
//
//  Created by 日向亮博 on 2019/07/01.
//  Copyright © 2019 Hinata10. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    //IBOutlet接続でプロパティ化した。
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
