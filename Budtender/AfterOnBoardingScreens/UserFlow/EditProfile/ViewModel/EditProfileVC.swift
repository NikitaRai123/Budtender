//
//  EditProfileVC.swift
//  Budtender
//
//  Created by apple on 22/08/23.
//

import UIKit
class EditProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var lastNameView: UIView!
    
    var imagePickerController = UIImagePickerController()
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            firstNameLabel.text = "Business Name"
            firstNameImage.image = UIImage(named: "Ic_BusinessName")
            txtFirstName.placeholder = "Please enter business name"
            lastNameView.isHidden = true
        }
        else if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            lastNameView.isHidden = false
        }else{
            let alertController = UIAlertController(title: "Alert", message: "Please create account to show detail", preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let actionLogin = UIAlertAction(title: "Login", style: .default) {_ in
                let vc = LoginTypeVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            alertController.addAction(actionLogin)
            alertController.addAction(actionCancel)
            present(alertController, animated: true, completion: nil)
        }
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Functions
    
    func validation() {
        if txtFirstName.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankFirstName, view: self)
        }else if txtFirstName?.isValidUserName() == false {
            Budtender.showAlert(title: Constants.AppName, message: Constants.validName, view: self)
        }else if txtLastName.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankLastName, view: self)
        }else if txtLastName?.isValidUserName() == false {
            Budtender.showAlert(title: Constants.AppName, message: Constants.validName, view: self)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileImage.image  = tempImage
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editPhotoAction(_ sender: UIButton) {
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
    
    @IBAction func saveAction(_ sender: UIButton) {
       // validation()
    }
}
