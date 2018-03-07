//
//  AreaPickerView.swift
//  PickerViewSample
//
//  Created by 蜂谷庸正 on 2018/03/07.
//  Copyright © 2018年 Tsunemasa Hachiya. All rights reserved.
//

import UIKit

protocol AreaPickerViewDelegate: class {
    func choosePrefecture(data: [String: Any])
    func chooseCity(data: [String: Any])
}


enum PickerType: Int {
    case Pref = 1
    case City
}

class AreaPickerView: UIPickerView {
    
    var prefList = [[String: Any]]() {
        didSet {
            setup()
        }
    }
    var cityList = [[String: Any]]() {
        didSet {
            setup()
        }
    }
    
    var areaPickerViewDelegate: AreaPickerViewDelegate?
    
    var toolbar: UIToolbar?
    var activeTextField: UITextField?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        self.delegate = self
        self.showsSelectionIndicator = true

        let doneItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(AreaPickerView.didTapDone(_:)))
        let cancelItem = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(AreaPickerView.didTapCancel(_:)))
        let spacerItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        toolbar?.barStyle = UIBarStyle.default
        toolbar?.setItems([cancelItem, spacerItem, doneItem], animated: true)
        toolbar?.sizeToFit()
    }
    
    @objc private func didTapDone(_ sender: AreaPickerView) {
        activeTextField?.endEditing(true)
    }

    @objc private func didTapCancel(_ sender: AreaPickerView) {
        activeTextField?.text = ""
        activeTextField?.endEditing(true)
    }
    
    func addTextField(textField: UITextField) {
        activeTextField = textField
    }

}

extension AreaPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let tag = activeTextField?.tag else { return 0 }
        
        let pickerType = PickerType(rawValue: tag)
        switch pickerType! {
        case .Pref:
            return prefList.count
        case .City:
            return cityList.count
        }
    }
}

extension AreaPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let tag = activeTextField?.tag else { return "" }
        
        let pickerType = PickerType(rawValue: tag)
        switch pickerType! {
        case .Pref:
            let data = prefList[row] as [String: Any]
            return data["prefName"] as? String
        case .City:
            let data = cityList[row] as [String: Any]
            return data["cityName"] as? String
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let tag = activeTextField?.tag else { return }
        
        let pickerType = PickerType(rawValue: tag)
        switch pickerType! {
        case .Pref:
            let data = prefList[row] as [String: Any]
            activeTextField?.text = data["prefName"] as? String
            self.areaPickerViewDelegate?.choosePrefecture(data: data)
        case .City:
            let data = cityList[row] as [String: Any]
            activeTextField?.text = data["cityName"] as? String
            self.areaPickerViewDelegate?.chooseCity(data: data)
        }

    }
}
