//
//  ViewController.swift
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testTextField1: UITextField!
    @IBOutlet weak var testTextField2: UITextField!

    //管理オブジェクトコンテキスト
    var managedContext:NSManagedObjectContext!

    
    //最初からあるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //管理オブジェクトコンテキストを取得する。
        let applicationDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedContext = applicationDelegate.managedObjectContext
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        //保存データを表示する。
        displayData()
            
        //デリゲート先に自分を設定する。
        testTextField1.delegate = self
        testTextField2.delegate = self
    }


    
    //保存データ表示メソッド
    func displayData(){
        do {
            //Playエンティティで保存されているデータを取得する。
            let fetchRequest = NSFetchRequest(entityName: "Player")
            let result = try managedContext.executeFetchRequest(fetchRequest) as! [Player]
            
            //取得したデータをラベルに表示する。
            var outputStr = ""
            for data in result {
                if let name = data.name, age = data.age {
                    outputStr = outputStr + "," + name + "," + String(age)
                }
            }
            testLabel.text = outputStr
            
        } catch {
            //エラーメッセージをアラートで表示する。
            let alert = UIAlertController(title:"エラー", message:String(error), preferredStyle:UIAlertControllerStyle.Alert)
            self.presentViewController(alert, animated:true, completion:nil)
        }
    }



    //Returnキー押下時の呼び出しメソッド
    func textFieldShouldReturn(textField:UITextField) -> Bool {
        
        //キーボードをしまう
        self.view.endEditing(true)
        
        return true
    }


    
    //ボタン押下時の呼び出しメソッド
    @IBAction func pushButton(sender: UIButton) {
    
        do {
            //Playerエンティティのオブジェクトを管理オブジェクトコンテキストに追加する。
            let player = NSEntityDescription.insertNewObjectForEntityForName("Player", inManagedObjectContext: managedContext) as! Player
            player.name = testTextField1.text!
            player.age = Int(testTextField2.text!)
            
            //管理オブジェクトコンテキストに格納したデータを保存する。
            try managedContext.save()
            
            //保存データを表示する。
            displayData()

        } catch {
            //エラーメッセージをアラートで表示する。
            let alert = UIAlertController(title:"エラー", message:String(error), preferredStyle:UIAlertControllerStyle.Alert)
            self.presentViewController(alert, animated:true, completion:nil)
        }
    }
}