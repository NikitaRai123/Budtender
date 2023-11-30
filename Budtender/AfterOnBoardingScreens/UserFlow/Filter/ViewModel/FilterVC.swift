//
//  FilterVC.swift
//  Budtender
//
//  Created by apple on 16/08/23.
//

import UIKit
import MultiSlider
class FilterVC: UIViewController, UITextFieldDelegate {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtBrand: UITextField!
    @IBOutlet weak var categoryDropDownButton: UIButton!
    @IBOutlet weak var brandDropDownButton: UIButton!
    @IBOutlet weak var slider: MultiSlider!
    @IBOutlet weak var minValueLabel: UILabel!
    @IBOutlet weak var maxValueLabel: UILabel!
    //-------------------------------------------------------------------------------------------------------
    //MARK: Variables
    
    var category = ["Vape pens","Flower/Bud","Concentrates","Edibles","CBD","Gear","Cultivation"]
    var brand = ["Lorem Ipsum","Lorem Ipsum","Lorem Ipsum"]
    
    var viewModel: AddProductVM?
    var viewModel1: FilterVM?
    var categoryID: String?
    var subCategoryID: String?
    var subCategoryName: String?
    var dispensaryId: String = ""

    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCategory.delegate = self
        txtBrand.delegate = self
//        createPickerView()
        dismissPickerView()
        action()
        setSlider()
        setViewModel()
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Functions
    
    func setViewModel(){
        self.viewModel = AddProductVM(observer: self)
        self.viewModel1 = FilterVM(observer: self)
        viewModel?.productListApi()
        viewModel?.dispensaryListApi(isStatus: "1")
        
    }
    
    
    func setSlider() {
        slider.minimumValue = 0.0
        slider.maximumValue = 2000.0
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        minValueLabel.text = "$0"//"\(slider.value[0])"
        maxValueLabel.text = "$0"//"\(slider.value[1])"
    }

    
    @objc func sliderValueChanged(_ slider: MultiSlider) {
        minValueLabel.text = "\("$")\(slider.value[0])"
        maxValueLabel.text = "\("$")\(slider.value[1])"
    }
  
    
    func createCategoryPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        txtCategory.inputView = pickerView
    }
    
    func createSubCategoryPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
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
    //-------------------------------------------------------------------------------------------------------
    //MARK: TextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case txtCategory:
            print("txtCategory")
            self.createCategoryPickerView()
            return true
        case txtBrand:
            if txtCategory.text?.count ?? 0 > 0 {
                self.createSubCategoryPickerView()
                return true
            }
            print("txtBrand")
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankProductCategory+" first", view: self)
            return false
        default:
            return true
        }
//        self.categoryDropDownButton.setImage(UIImage(named: "Ic_ShowDropDown"), for: .normal)
//        self.brandDropDownButton.setImage(UIImage(named: "Ic_ShowDropDown"), for: .normal)
//        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        self.categoryDropDownButton.setImage(UIImage(named: "Ic_DropDown"), for: .normal)
//        self.brandDropDownButton.setImage(UIImage(named: "Ic_DropDown"), for: .normal)
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyAction(_ sender: UIButton) {
        print("\(self.minValueLabel.text)\(self.maxValueLabel.text)")
        
        let isValidCategory = Validator.validateName(name: txtCategory.text?.toTrim() ?? "", message: "Please select Category")
        guard isValidCategory.0 == true else {
            Singleton.showMessage(message: isValidCategory.1, isError: .error)
            return
        }
        let isValidSubCat = Validator.validateName(name: txtBrand.text?.toTrim() ?? "", message: "Please select SubCategory")
        guard isValidSubCat.0 == true else {
            Singleton.showMessage(message: isValidSubCat.1, isError: .error)
            return
        }
        let minValue = self.minValueLabel.text?.replacingOccurrences(of: "$", with: "")
        let maxValue = self.maxValueLabel.text?.replacingOccurrences(of: "$", with: "")
        viewModel1?.filterApi(subcatId: self.subCategoryID ?? "", minPrice: minValue ?? "", maxPrice: maxValue ?? "", dispensaryId: dispensaryId)
        
    }
    
    @IBAction func sliderAction(_ sender: MultiSlider) {
       
    }
}
//-------------------------------------------------------------------------------------------------------
//MARK: ExtensionsTableView

extension FilterVC: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if txtCategory.isFirstResponder{
//            return category.count
            return viewModel?.category?.count ?? 0
        }else{
//            return brand.count
            return viewModel?.subCategory?.count ?? 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if txtCategory.isFirstResponder{
//            return category[row]
            return viewModel?.category?[row].category_name
        }else{
//            return brand[row]
            return viewModel?.subCategory?[row].name
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if txtCategory.isFirstResponder{
//            self.txtCategory.text = category[row]
            self.txtCategory.text = viewModel?.category?[row].category_name
            let categoryID = "\(viewModel?.category?[row].category_id ?? 0)"
            print(categoryID)
            self.categoryID = categoryID
            viewModel?.subCategoryListApi(id: categoryID)
        }else{
//            self.txtBrand.text = brand[row]
            self.txtBrand.text = viewModel?.subCategory?[row].name
            let subCategoryID = "\(viewModel?.subCategory?[row].subcat_id ?? 0)"
            print(subCategoryID)
            self.subCategoryName = viewModel?.subCategory?[row].name
            self.subCategoryID = subCategoryID
        }
    }
}
extension FilterVC: AddProductVMObserver{
    func productCategoryApi() {
        self.txtBrand.text = viewModel?.subCategory?.first?.name
        let subCategoryID = "\(viewModel?.subCategory?.first?.subcat_id ?? 0)"
        self.subCategoryID = subCategoryID
    }
    
    func createProductAPI() {
//        <#code#>
    }
    
    func dispensaryListApi() {
//        <#code#>
    }
    
    func searchHomeApi(postCount: Int) {
//        <#code#>
    }
    
    
}
extension FilterVC: FilterVMObserver{
    func filterApi(postCount: Int) {
        if postCount != 0{
            let vc = ProductSubCategoryVC()
//            vc.subcatName = self.subCategoryName
//            vc.subCatID = self.subCategoryID
//            vc.productID = self.subCategoryID
//            vc.dispensaryId = self.dispensaryId
            vc.filterData = self.viewModel1?.filterData ?? []
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
