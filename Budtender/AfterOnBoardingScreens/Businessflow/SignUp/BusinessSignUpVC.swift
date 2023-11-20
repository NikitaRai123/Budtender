//
//  BusinessSignUpVC.swift
//  Budtender
//
//  Created by apple on 25/08/23.
//

import UIKit
import GoogleSignIn
import Firebase
//import FacebookLogin
import FBSDKLoginKit
import FBSDKCoreKit
import AuthenticationServices

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
    var viewModel1: LoginVM?
    var profile_Image: UIImageView?
    var image: String?
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()

    }
    
    func setViewModel(){
        self.viewModel = BusinessSignUpVM(observer: self)
        self.viewModel1 = LoginVM(observer: self)
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
    
    
    //MARK: GOOGLE API
    
    func setGoogle(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        print(config)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { user, error in
        }
        
        /*GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { (result: GIDGoogleUser?, error: Error?) in
            guard error == nil else {
                // ...
                print("Error Data")
                return
            }
            //let user = result?.user
            let idd = result?.userID
            print(idd)
            let idtoken = result?.idToken?.tokenString
            let email = result?.profile?.email
            let fName = result?.profile?.name
            let givenName = result?.profile?.givenName
            let givenProfile = result?.profile?.hasImage
            let family = result?.profile?.familyName
//            let firstName = UserDefaultsCustom.getUserData()?.firstName
//            let lastName = UserDefaultsCustom.getUserData()?.lastName
            let profile = UserDefaultsCustom.getUserData()?.image
            
            if let profile = result?.profile{
                let familyName = profile.familyName
                print(family)
            }
            
            if let profileImageUrl = result?.profile?.imageURL(withDimension: 200) {
                    // Load the profile image using SDWebImage or any other image loading library
                let urlString = profileImageUrl.absoluteString
                profile_Image?.setImage(image: urlString,placeholder: UIImage(named: "PlaceHolder"))
                    //.sd_setImage(with: profileImageUrl, completed: nil)
                print("urlString = \(urlString)")
                self.image = urlString
                }
            
            print("email=== \(email) id === \(idtoken) name === \(fName)")
            viewModel1?.googleLoginApi(email: email ?? "", id: idd ?? "", firstName: "", lastName: "", name: fName ?? "", devideType: "1", isType: "1")
        }*/
    }
    
    // MARK: Facebook Login
    
    func setFaceBook() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { [weak self] (result, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let result = result, !result.isCancelled else {
                print("User cancelled login")
                return
            }
            
            self?.fetchUserData()
        }
    }

    func fetchUserData() {
        let connection = GraphRequestConnection()
        
        let graphRequest = GraphRequest(
            graphPath: "me",
            parameters: ["fields": "id, first_name, last_name, email"]
        )
        
        connection.add(graphRequest) { [weak self] response, result, error in
            if let error = error {
                print("Graph API error: \(error.localizedDescription)")
                return
            }
            
            if let resultDict = result as? [String: Any] {
                let userID = resultDict["id"] as? String ?? ""
                let firstName = resultDict["first_name"] as? String ?? ""
                let lastName = resultDict["last_name"] as? String ?? ""
                let email = resultDict["email"] as? String ?? ""
                let imageUrl = Profile.current?.imageURL(forMode: .normal, size: CGSize(width: 500, height: 500))?.absoluteString
//                self?.viewModel?.googleLoginApi(type: "2", token: userID, firstName: firstName, lastName: lastName, email: email, profileImage: imageUrl ?? "", devideType: "1")
            }
        }
        
        connection.start()
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
        //        setFaceBook()
    }
    
    @IBAction func googleAction(_ sender: UIButton) {
        self.setGoogle()
    }
    
    @IBAction func appleAction(_ sender: UIButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension BusinessSignUpVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let appleId = appleIDCredential.user
            print("Apple ID: \(appleId)")
            
            let appleUserFirstName = appleIDCredential.fullName?.givenName ?? ""
            print("First Name: \(appleUserFirstName)")
            
            let appleUserLastName = appleIDCredential.fullName?.familyName ?? ""
            print("Last Name: \(appleUserLastName)")
            
            let appleUserEmail = appleIDCredential.email ?? ""
            print("Email: \(appleUserEmail)")
            
            let name = "\(appleUserFirstName) \(appleUserLastName)"
            print("Full Name: \(name)")
            
            // Write your code
             self.viewModel1?.appleLoginApi(email: appleUserEmail, id: appleId, firstName: appleUserFirstName, lastName: appleUserLastName, name: name, devideType: "1", isType: "2")
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            print("Password credentials are: \(passwordCredential)")
        }
    }
}
extension BusinessSignUpVC: BusinessSignUpVMObserver{
    func observerSignUpApi() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
extension BusinessSignUpVC: LoginVMObserver{
    func observeGoogleLoginApi() {
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
//                                UserDefaults.standard.set("3", forKey: "UserType")
            let vc = ProductVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
//                                UserDefaults.standard.set("2", forKey: "UserType")
            let vc = HomeVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
