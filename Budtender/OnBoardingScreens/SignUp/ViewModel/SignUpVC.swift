//
//  SignUpVC.swift
//  Budtender
//
//  Created by apple on 09/08/23.
//

import UIKit
import SVProgressHUD
import FBSDKLoginKit
import GoogleSignIn
import AuthenticationServices
import Firebase
import FBSDKCoreKit


class SignUpVC: UIViewController,UITextFieldDelegate {
    //MARK: Outlets
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var privacyPolicySelectBtn: UIButton!
    var iconClick = true
    var viewModel: LoginVM?
    var profile_Image: UIImageView?
    var image: String?
  //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        txtPassword.isSecureTextEntry = true
        setViewModel()
    }
    
    func setup(){
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        self.privacyPolicySelectBtn.isSelected = false
    }
    func setViewModel(){
        self.viewModel = LoginVM(observer: self)
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Functions
    
    func validation() {
        
        let isValidFirstName = Validator.validateName(name: txtFirstName.text ?? "", message: "Please enter First Name")
        
        let isValidLastName = Validator.validateName(name: txtLastName.text ?? "", message: "Please enter Last Name")
        
        let isValidEmail = Validator.validateEmail(candidate: txtEmail.text?.toTrim() ?? "")
        
        let isValidPassword = Validator.validatePassword(password: txtPassword.text?.toTrim())

        guard isValidFirstName.0 == true else {
            Singleton.showMessage(message: isValidFirstName.1, isError: .error)
            return
        }
        guard isValidLastName.0 == true else {
            Singleton.showMessage(message: isValidLastName.1, isError: .error)
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
        if self.privacyPolicySelectBtn.isSelected == false{
            showMessage(message: "Please agree with Privacy Policy.", isError: .error)
        }else{
        
        
        
//        if txtEmail.text == ""{
//            ShowBanner.show(title: "Please enter email")
////            Budtender.showAlert(title: Constants.AppName, message: Constants.blankEmail, view: self)
//        }else if txtEmail.text?.isValidEmail == false {
//            ShowBanner.show(title: "Please enter Valid email")
////            Budtender.showAlert(title: Constants.AppName, message: Constants.validEmail, view: self)
//        }else if txtPassword.text == ""{
//            Budtender.showAlert(title: Constants.AppName, message: Constants.blankPassword, view: self)
//        }else if txtPassword?.isValidPassword() == false {
//            Budtender.showAlert(title: Constants.AppName, message: Constants.minimumRangeSet, view: self)
//        }else if txtFirstName.text == "" {
//            Budtender.showAlert(title: Constants.AppName, message: Constants.blankFirstName, view: self)
//        }else if txtFirstName?.isValidUserName() == false {
//            Budtender.showAlert(title: Constants.AppName, message: Constants.validName, view: self)
//        }else if txtLastName.text == "" {
//            Budtender.showAlert(title: Constants.AppName, message: Constants.blankLastName, view: self)
//        }else if txtLastName?.isValidUserName() == false {
//            Budtender.showAlert(title: Constants.AppName, message: Constants.validName, view: self)
//
//        }else if self.privacyPolicySelectBtn.isSelected == false{
//            Budtender.showAlert(title: Constants.AppName, message: "Please agree with Privacy Policy.", view: self)
//        }
//        else{
    
            var signModel = SignupModel()
            signModel.firstName = self.txtFirstName.text
            signModel.lastName = self.txtLastName.text
            signModel.email = self.txtEmail.text
            signModel.password = self.txtPassword.text
            signModel.is_type = "2"
            SVProgressHUD.show()
            UserApiModel().userSignUp(model: signModel) { response, error in
                SVProgressHUD.dismiss()
                if let jsonResponse = response{
                    if let parsedData = try? JSONSerialization.data(withJSONObject: jsonResponse,options: .prettyPrinted){
                        let userModel = try? JSONDecoder().decode(ApiResponseModel<UserModel>.self, from: parsedData)
                        if userModel?.status == 200 {
//                            Budtender.showAlertMessage(title: ApiConstant.appName, message: userModel?.message ?? "", okButton: "OK", controller: self) {
                                if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
                                    self.navigationController?.popViewController(animated: true)
                                    
                                }else if "business" == UserDefaults.standard.string(forKey: "LoginType"){
                                    
                                }else{
                                    UserDefaults.standard.set("customer", forKey: "LoginType")
                                    let vc = LoginVC()
                                    self.navigationController?.pushViewController(vc, animated: true)
                                    
                                }
//                            }
                        }else{
                            Singleton.shared.showErrorMessage(error:  response?["message"] as? String ?? "", isError: .error)
                        }
                    }
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
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self){
            [unowned self] result, error in
            guard error == nil else {
                // ...
                print("Error Data")
                return
            }
            let user = result?.user
            let idd = user?.userID
            print(idd)
            let idtoken = user?.idToken?.tokenString
            let email = user?.profile?.email
            let fName = user?.profile?.name
            let givenName = user?.profile?.givenName
            let givenProfile = user?.profile?.hasImage
            let family = user?.profile?.familyName
//            let firstName = UserDefaultsCustom.getUserData()?.firstName
//            let lastName = UserDefaultsCustom.getUserData()?.lastName
            let profile = UserDefaultsCustom.getUserData()?.image
            
            if let profile = user?.profile{
                let familyName = profile.familyName
                print(family)
            }
            
            if let profileImageUrl = user?.profile?.imageURL(withDimension: 200) {
                    // Load the profile image using SDWebImage or any other image loading library
                let urlString = profileImageUrl.absoluteString
                profile_Image?.setImage(image: urlString,placeholder: UIImage(named: "PlaceHolder"))
                    //.sd_setImage(with: profileImageUrl, completed: nil)
                print("urlString = \(urlString)")
                self.image = urlString
                }
            
            print("email=== \(email) id === \(idtoken) name === \(fName)")
            viewModel?.googleLoginApi(email: email ?? "", id: idd ?? "", firstName: "", lastName: "", name: fName ?? "", devideType: "1", isType: "1")
        }
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
         validation()
    }
    
    @IBAction func facebookAction(_ sender: UIButton) {
//        setFaceBook()
    }
    
    @IBAction func googleAction(_ sender: UIButton) {
        setGoogle()
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
    //-------------------------------------------------------------------------------------------------------
    
}
extension SignUpVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
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
             self.viewModel?.appleLoginApi(email: appleUserEmail, id: appleId, firstName: appleUserFirstName, lastName: appleUserLastName, name: name, devideType: "1", isType: "2")
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            print("Password credentials are: \(passwordCredential)")
        }
    }
}

extension SignUpVC: LoginVMObserver{
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
