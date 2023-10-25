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
    var viewModel: EditProfileVM?
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
    }
    
    func setViewModel(){
        self.viewModel = EditProfileVM(observer: self)
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            firstNameLabel.text = "Business Name"
            firstNameImage.image = UIImage(named: "Ic_BusinessName")
            txtFirstName.placeholder = "Please enter business name"
            lastNameView.isHidden = true
            viewModel?.getProfileApi()
        }
        else if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            lastNameView.isHidden = false
            viewModel?.getProfileApi()
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
        if let tempImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImage.image  = tempImage
        } else if let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image  = tempImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
                            self?.profileImage.image = data1.image
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
    
    @IBAction func editPhotoAction(_ sender: UIButton) {
        
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
    
    @IBAction func saveAction(_ sender: UIButton) {
       // validation()
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            let isValidName = Validator.validateName(name: txtFirstName.text?.toTrim() ?? "", message: "Please enter Business name")
            guard isValidName.0 == true else {
                Singleton.showMessage(message: isValidName.1, isError: .error)
                return
            }
            viewModel?.editProfileApi(name: txtFirstName.text ?? "", firstName: "", lastName: "", profileImage: "", isType: "1")
            
        }else if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            let isValidName = Validator.validateName(name: txtFirstName.text?.toTrim() ?? "", message: "Please enter First name")
            let isValidLastName = Validator.validateName(name: txtLastName.text?.toTrim() ?? "", message: "Please enter Last name")
            guard isValidName.0 == true else {
                Singleton.showMessage(message: isValidName.1, isError: .error)
                return
            }
            guard isValidLastName.0 == true else {
                Singleton.showMessage(message: isValidLastName.1, isError: .error)
                return
            }
            viewModel?.editProfileApi(name: "", firstName: txtFirstName.text ?? "", lastName: txtLastName.text ?? "", profileImage: "", isType: "2")
            
        }
    }
}
extension EditProfileVC: EditProfileVMObserver{
    func observerEditProfileApi() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func observerGetProfileApi() {
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            let data = UserDefaultsCustom.getUserData()
            self.profileImage.setImage(image: data?.image,placeholder: UIImage(named: "profilePlaceholder"))
            self.txtFirstName.text = data?.name
        }else if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            let data = UserDefaultsCustom.getUserData()
            self.profileImage.setImage(image: data?.image,placeholder: UIImage(named: "profilePlaceholder"))
            self.txtFirstName.text = data?.first_name
            self.txtLastName.text = data?.last_name
        }
        
       
        
    }
    
    
}
