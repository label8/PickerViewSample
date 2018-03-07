//
//  ViewController.swift
//  PickerViewSample
//
//  Created by 蜂谷庸正 on 2018/03/07.
//  Copyright © 2018年 Tsunemasa Hachiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var prefText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    
    // PrefとCityは別のPickerを使いたいので宣言のみ
    var pickerView: AreaPickerView?
    
    var prefList = [
        ["prefCode": "1", "prefName": "東京"],
        ["prefCode": "2", "prefName": "神奈川"],
        ["prefCode": "3", "prefName": "千葉"],
        ["prefCode": "4", "prefName": "埼玉"],
        ["prefCode": "5", "prefName": "群馬"]
    ]
    
    var cityList = [
        ["cityCode": "1", "cityName": "川越市", "prefCode": "4"],
        ["cityCode": "2", "cityName": "朝霞市", "prefCode": "4"],
        ["cityCode": "3", "cityName": "入間市", "prefCode": "4"],
        ["cityCode": "4", "cityName": "さいたま市", "prefCode": "4"],
        ["cityCode": "5", "cityName": "春日部市", "prefCode": "4"],
        ["cityCode": "6", "cityName": "蕨市", "prefCode": "4"],
        ["cityCode": "7", "cityName": "所沢市", "prefCode": "4"],
        ["cityCode": "8", "cityName": "越谷市", "prefCode": "4"],
        ["cityCode": "9", "cityName": "熊谷市", "prefCode": "4"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テキストフィールドの設定
        prefText.delegate = self
        cityText.delegate = self
        
        prefText.tag = 1
        cityText.tag = 2
        
        cityText.isEnabled = false
        
        // ピッカーの設定
        pickerView = AreaPickerView()
        pickerView?.areaPickerViewDelegate = self
        pickerView?.prefList = prefList // この時点でPref用のpickerのセットアップが始まる
        
        // Prefのピッカーをキーボードと置き換え
        prefText.inputView = pickerView
        prefText.inputAccessoryView = pickerView?.toolbar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        pickerView?.addTextField(textField: textField)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: AreaPickerViewDelegate {
    func choosePrefecture(data: [String : Any]) {
        cityText.text = ""
        cityText.isEnabled = true
        
        // ピッカーの設定
        pickerView = AreaPickerView()
        pickerView?.cityList = cityList // この時点でCity用のpickerのセットアップが始まる
        
        // Cityのピッカーをキーボードと置き換え
        cityText.inputView = pickerView
        cityText.inputAccessoryView = pickerView?.toolbar
    }
    
    func chooseCity(data: [String : Any]) {
        print(data)
    }
}
