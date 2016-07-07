//
//  ViewController.swift
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testTextField1: UITextField!
    
    let dataList = ["Integer 16","Integer 32","Integer 64","Decimal","Double","Float","String","Boolean","Date", "Binary Data", "Transformable"]

    var selectStr:String = "Integer 16"
    
    //管理オブジェクトコンテキスト
    var managedContext:NSManagedObjectContext!
    
    
    //最初からあるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //管理オブジェクトコンテキストを取得する。
        let applicationDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedContext = applicationDelegate.managedObjectContext
        
        //デリゲート先に自分を設定する。
        testTextField1.delegate = self
    }
    

    //コンポーネントの個数を返すメソッド
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    //コンポーネントに含まれるデータの個数を返すメソッド
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    
    //データを返すメソッド
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
    
    
    //データ選択時の呼び出しメソッド
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //選択されたデータを取得する。
        selectStr = self.pickerView(pickerView, titleForRow: pickerView.selectedRowInComponent(0), forComponent: 0)!
        
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
            //新しいオブジェクトを管理オブジェクトコンテキストに格納する。
            let player = NSEntityDescription.insertNewObjectForEntityForName("Player", inManagedObjectContext: managedContext) as! Player
        
            switch selectStr {
            case "Integer 16":
                player.testInteger16 = Int(testTextField1.text!)
            case "Integer 32":
                player.testInteger32 = Int(testTextField1.text!)
            case "Integer 64":
                player.testInteger64 = Int(testTextField1.text!)
            case "Decimal":
                player.testDecimal = NSDecimalNumber(double: Double(testTextField1.text!)!)
            case "Double":
                player.testDouble = Double(testTextField1.text!)
            case "Float":
                player.testFloat = Float(testTextField1.text!)
            case "String":
                player.testString = String(testTextField1.text!)
            case "Boolean":
                player.testBoolean = NSString(string:testTextField1.text!).boolValue
            case "Date":
                let formatter = NSDateFormatter()
                formatter.locale = NSLocale(localeIdentifier: "ja")
                formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                player.testDate = formatter.dateFromString(String(testTextField1.text!))
            case "Binary":
                let data = NSData(data: String(testTextField1.text!).dataUsingEncoding(NSUTF8StringEncoding)!)
                player.testBynaryData = data
            case "Transformable":
                player.testTransformable = String(testTextField1.text!)
            
                
            default:
                print("とりあえずそれ以外")
            }
        
            //管理オブジェクトコンテキストに格納したデータを保存する。
            try managedContext.save()
            
            //Playエンティティで保存されているデータを取得する。
            let fetchRequest = NSFetchRequest(entityName: "Player")
            let result = try managedContext.executeFetchRequest(fetchRequest) as! [Player]
            
            print(result)
            
        } catch {
            print(error)
        }
    }

}