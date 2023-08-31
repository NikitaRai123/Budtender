//
//  AddDispensaryVC.swift
//  Budtender
//
//  Created by apple on 29/08/23.
//

import UIKit
class AddDispensaryVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    
    @IBOutlet weak var addDispensaryLabel: UILabel!
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var txtDispensaryName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtPostalCode: UITextField!
    @IBOutlet weak var txtWebsite: UITextField!
    @IBOutlet weak var txtLicense: UITextField!
    @IBOutlet weak var txtExpiration: UITextField!
    @IBOutlet weak var expirationDropDownButton: UIButton!
    @IBOutlet weak var mondayHoursView: BusinessWeekDaysView!
    @IBOutlet weak var tuesdayHoursView: BusinessWeekDaysView!
    @IBOutlet weak var wednesdayHoursView: BusinessWeekDaysView!
    @IBOutlet weak var thursdayHoursView: BusinessWeekDaysView!
    @IBOutlet weak var fridayHoursView: BusinessWeekDaysView!
    @IBOutlet weak var saturdayHoursView: BusinessWeekDaysView!
    @IBOutlet weak var sundayHoursView: BusinessWeekDaysView!
    
    var imagePickerController = UIImagePickerController()
    var isSelect:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        openDatePicker()
        txtExpiration.delegate = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if isSelect == "AddDispensary"{
            self.addDispensaryLabel.text = "Add Dispensary"
            self.createButton.setTitle("Create", for: .normal)
            
        }else{
            self.addDispensaryLabel.text = "Edit Dispensary"
            self.createButton.setTitle("Save", for: .normal)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        productImage.image  = tempImage
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func openDatePicker(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        txtExpiration.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDatePicker))
        toolbar.setItems([doneButton], animated: true)
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        txtExpiration.inputAccessoryView = .none
    }
    @objc func dismissDatePicker() {
        view.endEditing(true)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.expirationDropDownButton.setImage(UIImage(named: "Ic_ShowDropDown"), for: .normal)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.expirationDropDownButton.setImage(UIImage(named: "Ic_DropDown"), for: .normal)
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        //formatter.dateStyle = .short
        txtExpiration.text = formatter.string(from: sender.date)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cameraAction(_ sender: UIButton) {
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
    
    
    
    
}
