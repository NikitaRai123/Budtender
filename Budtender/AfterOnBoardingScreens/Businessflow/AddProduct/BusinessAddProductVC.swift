//
//  BusinessAddProductVC.swift
//  Budtender
//
//  Created by apple on 28/08/23.
//

import UIKit
import GrowingTextView
class BusinessAddProductVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var addProductLabel: UILabel!
    @IBOutlet weak var editImageButton: UIButton!
    @IBOutlet weak var uploadImageButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var txtProductCategory: UITextField!
    @IBOutlet weak var txtSubCategory: UITextField!
    @IBOutlet weak var txtDispensary: UITextField!
    @IBOutlet weak var txtProductName: UITextField!
    @IBOutlet weak var txtBrandName: UITextField!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var categoryDropDownButton: UIButton!
    @IBOutlet weak var dispensaryDropDownButton: UIButton!
    @IBOutlet weak var brandNameDropDownButton: UIButton!
    @IBOutlet weak var textView: GrowingTextView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var subCategoryGropDownBtn: UIButton!
    //-------------------------------------------------------------------------------------------------------
    //MARK: Variables
    
    var imagePickerController = UIImagePickerController()
    var category = ["Vape pens","Flower/Bud","Concentrates","Edibles","CBD","Gear","Cultivation"]
    var dispensary = ["Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum"]
    var brandName = ["Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum"]
    var comefrom:String?
    
    var viewModel: AddProductVM?
    var categoryID: String?
    var dispensaryID: String?
    var subCategoryID: String?
    //-------------------------------------------------------------------------------------------------------
    //MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtProductCategory.delegate = self
        txtDispensary.delegate = self
        txtSubCategory.delegate = self
        createPickerView()
        dismissPickerView()
        action()
        setViewModel()
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        if comefrom == "AddProduct"{
            self.addProductLabel.text = "Add Product"
            self.editImageButton.isHidden = true
            self.addButton.setTitle("Add", for: .normal)
            
        }else{
            self.addProductLabel.text = "Edit Product"
            self.editImageButton.isHidden = false
            self.addButton.setTitle("Save", for: .normal)
            self.uploadImageButton.setImage(UIImage(named: "EditProductImage"), for: .normal)
            self.uploadImageButton.isUserInteractionEnabled = false
        }
    }
    
    func setViewModel(){
        self.viewModel = AddProductVM(observer: self)
        viewModel?.productListApi()
        viewModel?.dispensaryListApi(isStatus: "1")
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Function
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        txtProductCategory.inputView = pickerView
        txtDispensary.inputView = pickerView
        txtSubCategory.inputView = pickerView
     
    }
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        txtProductCategory.inputAccessoryView = toolBar
        txtDispensary.inputAccessoryView = toolBar
        txtSubCategory.inputAccessoryView = toolBar
    }
    @objc func action() {
        view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        productImage.image  = tempImage
        self.productImage.cornerRadius = 10
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func validation() {
        if txtProductCategory.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankProductCategory, view: self)
        }else if txtSubCategory.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankSubcategory, view: self)
        }else if txtDispensary.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankDispensary, view: self)
        }else if txtProductName.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankProductName, view: self)
        }else if txtBrandName.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankBrandName, view: self)
        }else if txtQuantity.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankQuantity, view: self)
        }else if txtWeight.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankWeight, view: self)
        }else if txtPrice.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankPrice, view: self)
        }else if textView.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankDescription, view: self)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: TextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.categoryDropDownButton.setImage(UIImage(named: "Ic_ShowDropDown"), for: .normal)
        self.dispensaryDropDownButton.setImage(UIImage(named: "Ic_ShowDropDown"), for: .normal)
        self.subCategoryGropDownBtn.setImage(UIImage(named: "Ic_ShowDropDown"), for: .normal)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.categoryDropDownButton.setImage(UIImage(named: "Ic_DropDown"), for: .normal)
        self.dispensaryDropDownButton.setImage(UIImage(named: "Ic_DropDown"), for: .normal)
        self.subCategoryGropDownBtn.setImage(UIImage(named: "Ic_DropDown"), for: .normal)
     
    }
    
    func openGalaryPhoto(tag:Int = 0) {
        self.viewModel?.imagePicker.setImagePicker(imagePickerType: .both, mediaType: .image, tag: tag, controller: self)
        self.viewModel?.imagePicker.imageCallBack = {[weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data1 = data {
                        if tag == 1 {
                            self?.viewModel?.editImage = data1
                            self?.productImage.image = data1.image
                            print("imageee ===== \(data1.image)")
                        }
                    }
                case .error(let message):
                    Singleton.shared.showErrorMessage(error: message, isError: .error)
                }
            }
        }
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImageButtonAction(_ sender: UIButton) {
        self.openGalaryPhoto(tag: 1)
        
        
        
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        let action = UIAlertAction(title: "Camera", style: .default){ [self] action in
//            if UIImagePickerController.isSourceTypeAvailable(.camera) {
//                imagePickerController.sourceType = .camera;
//                imagePickerController.allowsEditing = true
//                self.imagePickerController.delegate = self
//                self.present(imagePickerController, animated: true, completion: nil)
//            }
//            else{
//                let alert = UIAlertController(title: "Camera not found", message: "This device has no camera", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default,handler: nil))
//                present(alert, animated: true,completion: nil)
//            }
//        }
//        let action1 = UIAlertAction(title: "Gallery", style: .default){ action in
//            self.imagePickerController.allowsEditing = false
//            self.imagePickerController.sourceType = .photoLibrary
//            self.imagePickerController.delegate = self
//            self.present(self.imagePickerController, animated: true, completion: nil)
//        }
//        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
//        alert.addAction(action)
//        alert.addAction(action1)
//        alert.addAction(action2)
//        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func editImageButtonAction(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Camera", style: .default){ [self] action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera;
                imagePickerController.allowsEditing = true
                self.imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Camera not found", message: "This device has no camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default,handler: nil))
                present(alert, animated: true,completion: nil)
            }
        }
        let action1 = UIAlertAction(title: "Gallery", style: .default){ action in
            self.imagePickerController.allowsEditing = false
            self.imagePickerController.sourceType = .photoLibrary
            self.imagePickerController.delegate = self
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        //validation()
        print("\(categoryID)\(dispensaryID)\(subCategoryID)")
        if viewModel?.editImage == nil{
            Singleton.showMessage(message: "Please add Image", isError: .error)
            return
        }
        
        let isValidProduct = Validator.validateName(name: txtProductCategory.text?.toTrim() ?? "", message: "Please select Product Category")
        guard isValidProduct.0 == true else {
            Singleton.showMessage(message: isValidProduct.1, isError: .error)
            return
        }
        
        let isValidSubCategory = Validator.validateName(name: txtSubCategory.text?.toTrim() ?? "", message: "Please select SubCategory")
        guard isValidSubCategory.0 == true else {
            Singleton.showMessage(message: isValidSubCategory.1, isError: .error)
            return
        }
        let isValidDispensary = Validator.validateName(name: txtDispensary.text?.toTrim() ?? "", message: "Please select Dispensary")
        guard isValidDispensary.0 == true else {
            Singleton.showMessage(message: isValidDispensary.1, isError: .error)
            return
        }
        let isValidProductName = Validator.validateName(name: txtProductName.text?.toTrim() ?? "", message: "Please enter Product Name")
        guard isValidProductName.0 == true else {
            Singleton.showMessage(message: isValidProductName.1, isError: .error)
            return
        }
        let isValidBrandName = Validator.validateName(name: txtBrandName.text?.toTrim() ?? "", message: "Please enter Brand Name")
        guard isValidBrandName.0 == true else {
            Singleton.showMessage(message: isValidBrandName.1, isError: .error)
            return
        }
        let isValidQuantity = Validator.validateName(name: txtQuantity.text?.toTrim() ?? "", message: "Please enter Quantity")
        guard isValidQuantity.0 == true else {
            Singleton.showMessage(message: isValidQuantity.1, isError: .error)
            return
        }
        let isValidWeight = Validator.validateName(name: txtWeight.text?.toTrim() ?? "", message: "Please enter Weight")
        guard isValidWeight.0 == true else {
            Singleton.showMessage(message: isValidWeight.1, isError: .error)
            return
        }
        
        let isValidPrice = Validator.validateName(name: txtPrice.text?.toTrim() ?? "", message: "Please enter Price")
        guard isValidPrice.0 == true else {
            Singleton.showMessage(message: isValidPrice.1, isError: .error)
            return
        }
        
        let isValidDescription = Validator.validateDescription(words: textView.text)
        guard isValidDescription.0 == true else {
            Singleton.showMessage(message: isValidDescription.1, isError: .error)
            return
        }
        
        viewModel?.addProductApi(isStatus: "1", categoryID: self.categoryID ?? "", subCatID: self.subCategoryID ?? "", dispensaryID: self.dispensaryID ?? "", productNAme: txtProductName.text ?? "", brandName: txtBrandName.text ?? "", qty: txtQuantity.text ?? "", weight: txtWeight.text ?? "", price: txtPrice.text ?? "", description: textView.text ?? "", image: "")
       
    }
}
//-------------------------------------------------------------------------------------------------------
//MARK: ExtensionPickerView

extension BusinessAddProductVC: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if txtProductCategory.isFirstResponder{
            print(viewModel?.category?.count)
            return viewModel?.category?.count ?? 0
//            return category.count
        }else  if txtSubCategory.isFirstResponder{
            return viewModel?.subCategory?.count ?? 0
//            return dispensary.count
        }else{
            return viewModel?.dispensaryList?.count ?? 0
//            return brandName.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if txtProductCategory.isFirstResponder{
            return viewModel?.category?[row].category_name
//            return category[row]
        }else  if txtSubCategory.isFirstResponder{
            return viewModel?.subCategory?[row].name
//            return dispensary[row]
        }else{
            return viewModel?.dispensaryList?[row].name
//            return brandName[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if txtProductCategory.isFirstResponder{
            self.txtProductCategory.text = viewModel?.category?[row].category_name
            let categoryID = "\(viewModel?.category?[row].category_id ?? 0)"
            print(categoryID)
            self.categoryID = categoryID
            viewModel?.subCategoryListApi(id: categoryID)
//            self.txtProductCategory.text = category[row]
        }else  if txtSubCategory.isFirstResponder{
            self.txtSubCategory.text = viewModel?.subCategory?[row].name
            let subCategoryID = "\(viewModel?.subCategory?[row].subcat_id ?? 0)"
            print(subCategoryID)
            self.subCategoryID = subCategoryID
//            self.txtSubCategory.text = dispensary[row]
        }else{
            self.txtDispensary.text = viewModel?.dispensaryList?[row].name
            let dispensaryId = "\(viewModel?.dispensaryList?[row].id ?? 0)"
            print(dispensaryId)
            self.dispensaryID = dispensaryId
//            self.txtBrandName.text = brandName[row]
        }
    }
}
extension BusinessAddProductVC: AddProductVMObserver{
    func createProductAPI() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func productCategoryApi() {
//        <#code#>
    }
    
    
}




