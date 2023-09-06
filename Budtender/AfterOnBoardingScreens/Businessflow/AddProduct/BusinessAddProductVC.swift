//
//  BusinessAddProductVC.swift
//  Budtender
//
//  Created by apple on 28/08/23.
//

import UIKit
import GrowingTextView
class BusinessAddProductVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    
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
    
    var imagePickerController = UIImagePickerController()
    var category = ["Vape pens","Flower/Bud","Concentrates","Edibles","CBD","Gear","Cultivation"]
    var dispensary = ["Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum"]
    var brandName = ["Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum","Lorem ipsum"]
    var comefrom:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtProductCategory.delegate = self
        txtDispensary.delegate = self
        txtBrandName.delegate = self
        createPickerView()
        dismissPickerView()
        action()
    }
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
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        txtProductCategory.inputView = pickerView
        txtDispensary.inputView = pickerView
        txtBrandName.inputView = pickerView
     
    }
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        txtProductCategory.inputAccessoryView = toolBar
        txtDispensary.inputAccessoryView = toolBar
        txtBrandName.inputAccessoryView = toolBar
    }
    @objc func action() {
        view.endEditing(true)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.categoryDropDownButton.setImage(UIImage(named: "Ic_ShowDropDown"), for: .normal)
        self.dispensaryDropDownButton.setImage(UIImage(named: "Ic_ShowDropDown"), for: .normal)
        self.brandNameDropDownButton.setImage(UIImage(named: "Ic_ShowDropDown"), for: .normal)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.categoryDropDownButton.setImage(UIImage(named: "Ic_DropDown"), for: .normal)
        self.dispensaryDropDownButton.setImage(UIImage(named: "Ic_DropDown"), for: .normal)
        self.brandNameDropDownButton.setImage(UIImage(named: "Ic_DropDown"), for: .normal)
     
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
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImageButtonAction(_ sender: UIButton) {
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
        self.navigationController?.popViewController(animated: true)
    }
}
extension BusinessAddProductVC: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if txtProductCategory.isFirstResponder{
            return category.count
        }else  if txtDispensary.isFirstResponder{
            return dispensary.count
        }else{
            return brandName.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if txtProductCategory.isFirstResponder{
            return category[row]
        }else  if txtDispensary.isFirstResponder{
            return dispensary[row]
        }else{
            return brandName[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if txtProductCategory.isFirstResponder{
            self.txtProductCategory.text = category[row]
        }else  if txtDispensary.isFirstResponder{
            self.txtDispensary.text = dispensary[row]
        }else{
            self.txtBrandName.text = brandName[row]
        }
    }
}





