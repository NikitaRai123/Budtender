//
//  PickUpVC.swift
//  Budtender
//
//  Created by apple on 18/08/23.
//

import UIKit
class PickUpVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var uploadIdButton: UIButton!
    @IBOutlet weak var uploadIdImage: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtphoneNumber: UITextField!
    @IBOutlet weak var txtBirthday: UITextField!
    @IBOutlet weak var txtPickUpTime: UITextField!
    //-------------------------------------------------------------------------------------------------------
    //MARK: Variables
    
    var imagePickerController = UIImagePickerController()
    let timePicker = UIDatePicker()
    var completion : (() -> Void)? = nil
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openDatePicker()
        txtBirthday.delegate = self
        txtPickUpTime.delegate = self
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Functions
    
    func validation() {
        if txtName.text == "" {
        Budtender.showAlert(title: Constants.AppName, message: Constants.blankFirstName, view: self)
    }else if txtName?.isValidUserName() == false {
        Budtender.showAlert(title: Constants.AppName, message: Constants.validName, view: self)
    }else if txtBirthday.text == ""{
        Budtender.showAlert(title: Constants.AppName, message: Constants.blankBirthday, view: self)
    }else if txtphoneNumber.text == ""{
        Budtender.showAlert(title: Constants.AppName, message: Constants.blankPhoneNumber, view: self)
    }else if txtphoneNumber.text == ""{
        Budtender.showAlert(title: Constants.AppName, message: Constants.blankPickUpTime, view: self)
    }else{
        if let vc = self.completion{
            self.navigationController?.popViewController(animated: true)
            completion!()
        }
    }
    }
    func openDatePicker(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        timePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        timePicker.preferredDatePickerStyle = .wheels
        txtBirthday.inputView = datePicker
        txtPickUpTime.inputView = timePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDatePicker))
        toolbar.setItems([doneButton], animated: true)
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        timePicker.addTarget(self, action: #selector(timePickerValueChanged), for: .valueChanged)
        txtBirthday.inputAccessoryView = .none
        txtPickUpTime.inputAccessoryView = .none
    }
    @objc func dismissDatePicker() {
        view.endEditing(true)
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        //formatter.dateStyle = .short
        txtBirthday.text = formatter.string(from: sender.date)
    }
    @objc func timePickerValueChanged(_ sender: UIDatePicker) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            txtPickUpTime.text = timeFormatter.string(from: sender.date)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        uploadIdImage.image  = tempImage
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func uploadIdAction(_ sender: UIButton) {
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
        if let vc = self.completion{
            self.navigationController?.popViewController(animated: true)
            completion!()
            
        }
    }
}
