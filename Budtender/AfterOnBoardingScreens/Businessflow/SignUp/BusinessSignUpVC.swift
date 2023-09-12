//
//  BusinessSignUpVC.swift
//  Budtender
//
//  Created by apple on 25/08/23.
//

import UIKit
class BusinessSignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var txtBusinessName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var privacyPolicySelectBtn: UIButton!

    var imagePickerController = UIImagePickerController()
    var viewModel: BusinessSignUpVM?
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()

    }
    
    func setViewModel(){
        self.viewModel = BusinessSignUpVM(observer: self)
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Function
    
    func validation() {
        if txtEmail.text == ""{
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankEmail, view: self)
        }else if txtEmail.text?.isValidEmail == false {
            Budtender.showAlert(title: Constants.AppName, message: Constants.validEmail, view: self)
        }else if txtPassword.text == ""{
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankPassword, view: self)
        }else if txtPassword?.isValidPassword() == false {
            Budtender.showAlert(title: Constants.AppName, message: Constants.minimumRangeSet, view: self)
        }else if txtBusinessName.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankFirstName, view: self)
        }else if txtBusinessName?.isValidUserName() == false {
            Budtender.showAlert(title: Constants.AppName, message: Constants.validName, view: self)
        }else{
//             if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
//                 self.navigationController?.popViewController(animated: true)
//
//            }else if "business" == UserDefaults.standard.string(forKey: "LoginType"){
//                let vc = LoginVC()
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else{
//                UserDefaults.standard.set("customer", forKey: "LoginType")
                    let vc = LoginVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                
            //}
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        print(tempImage)
        profileImage.image  = tempImage
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
    
    @IBAction func cameraAction(_ sender: UIButton) {
        
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
    @IBAction func hidePasswordAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        txtPassword.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func privacyPolicySelectAction(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @IBAction func privacyPolicyAction(_ sender: UIButton) {
        let vc = TermAndConditionVC()
        vc.comeFrom = "Privacy Policy"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        
        let isValidName = Validator.validateName(name: txtBusinessName.text?.toTrim() ?? "", message: "Please enter business name")
        let isValidEmail = Validator.validateEmail(candidate: txtEmail.text?.toTrim() ?? "")
        
        let isValidPassword = Validator.validatePassword(password: txtPassword.text?.toTrim())

        guard isValidName.0 == true else {
            Singleton.showMessage(message: isValidName.1, isError: .error)
            return
        }
        guard isValidEmail.0 == true else {
            Singleton.showMessage(message: isValidEmail.1, isError: .error)
            return
        }

        guard isValidPassword.0 == true else {
            Singleton.showMessage(message: isValidPassword.1, isError: .error)
            return
        }
        guard privacyPolicySelectBtn.isSelected == true else {
            Singleton.showMessage(message: "Please accept Privacy Policy", isError: .error)
            print("Please accept terms and conditions")
            return
        }
    
        viewModel?.businessSignUpApi(firstName: "", lastName: "", email: txtEmail.text ?? "", password: self.txtPassword.text ?? "" , isType: "1", profileImage: "", name: txtBusinessName.text ?? "")
        
        
        
        
       // validation()
//        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
//            self.navigationController?.popViewController(animated: true)
//
//       }else if "business" == UserDefaults.standard.string(forKey: "LoginType"){
//           let vc = LoginVC()
//           self.navigationController?.pushViewController(vc, animated: true)
//       }else{
//           UserDefaults.standard.set("customer", forKey: "LoginType")
//               let vc = LoginVC()
//               self.navigationController?.pushViewController(vc, animated: true)
       //}
    }
    
    @IBAction func facebookAction(_ sender: UIButton) {
    }
    
    @IBAction func googleAction(_ sender: UIButton) {
    }
    
    @IBAction func appleAction(_ sender: UIButton) {
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension BusinessSignUpVC: BusinessSignUpVMObserver{
    func observerSignUpApi() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
