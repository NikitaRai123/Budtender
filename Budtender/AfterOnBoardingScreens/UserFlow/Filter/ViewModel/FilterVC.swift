//
//  FilterVC.swift
//  Budtender
//
//  Created by apple on 16/08/23.
//

import UIKit
import MultiSlider
class FilterVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtBrand: UITextField!
    @IBOutlet weak var categoryDropDownButton: UIButton!
    @IBOutlet weak var brandDropDownButton: UIButton!

    var category = ["Vape pens","Flower/Bud","Concentrates","Edibles","CBD","Gear","Cultivation"]
    var brand = ["Lorem Ipsum","Lorem Ipsum","Lorem Ipsum"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCategory.delegate = self
        txtBrand.delegate = self
        createPickerView()
        dismissPickerView()
        action()
    }
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        txtCategory.inputView = pickerView
        txtBrand.inputView = pickerView
     
    }
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        txtCategory.inputAccessoryView = toolBar
        txtBrand.inputAccessoryView = toolBar
        
    }
    @objc func action() {
        view.endEditing(true)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.categoryDropDownButton.setImage(UIImage(named: "Ic_ShowDropDown"), for: .normal)
        self.brandDropDownButton.setImage(UIImage(named: "Ic_ShowDropDown"), for: .normal)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.categoryDropDownButton.setImage(UIImage(named: "Ic_DropDown"), for: .normal)
        self.brandDropDownButton.setImage(UIImage(named: "Ic_DropDown"), for: .normal)
     
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyAction(_ sender: UIButton) {
    }
}
extension FilterVC: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if txtCategory.isFirstResponder{
            return category.count
        }else{
            return brand.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if txtCategory.isFirstResponder{
            return category[row]
        }else{
            return brand[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if txtCategory.isFirstResponder{
            self.txtCategory.text = category[row]
        }else{
            self.txtBrand.text = brand[row]
        }
    }
}
