//
//  LoginVC.swift
//  Budtender
//
//  Created by apple on 08/08/23.
//

import UIKit
import SVProgressHUD
import GoogleSignIn
import Firebase
import AuthenticationServices
import FBSDKLoginKit
import FBSDKCoreKit


class LoginVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var rememberMeBtn: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var rememberMeSelected = false
    
    var viewModel: LoginVM?
    var profileImage: UIImageView?
    var image: String?
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rememberMeBtn.isSelected = rememberMeSelected
        self.navigationController?.isNavigationBarHidden = true
        //        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
        //            self.guestUserButton.isHidden = true
        //            self.orLabel.isHidden = true
        //            self.guestUserButtonHeightCons.constant = 0
        //        }else{
        //            self.guestUserButton.isHidden = false
        //            self.orLabel.isHidden = false
        //            self.guestUserButtonHeightCons.constant = 50
        //        }
        
        setViewModel()
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        txtEmail.text =  UserDefaults.standard.value(forKey: "USER_EMAIL") as? String
        txtPassword.text =  UserDefaults.standard.value(forKey: "USER_PASSWORD") as? String
        txtPassword.isSecureTextEntry = true
        self.rememberMeBtn.isSelected = txtEmail.text?.count ?? 0 > 0
    }
    
    func setViewModel(){
        self.viewModel = LoginVM(observer: self)
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Function
    
    func getEmail() -> String{
        if let email =  UserDefaults.standard.value(forKey:"email")
        {
            rememberMeSelected = true
            return email as! String
        }
        else
        {
            rememberMeSelected = false
            return ""
        }
    }
    
    func getPassword() -> String{
        if let password =  UserDefaults.standard.value(forKey:"password")
        {
            rememberMeSelected = true
            return password as! String
        }
        else
        {
            rememberMeSelected = false
            return ""
        }
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func btnRemember(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    //MARK: Functions
    
    func validation() {
        
        
        let isValidEmail = Validator.validateEmail(candidate: txtEmail.text?.toTrim() ?? "")
        
        let isValidPassword = Validator.validatePassword(password: txtPassword.text?.toTrim())
        
        guard isValidEmail.0 == true else {
            Singleton.showMessage(message: isValidEmail.1, isError: .error)
            return
        }
        
        guard isValidPassword.0 == true else {
            Singleton.showMessage(message: isValidPassword.1, isError: .error)
            return
        }
        
        
        //        if txtEmail.text == ""{
        //            ShowBanner.show(title: "Please enter Email")
        ////            Budtender.showAlert(title: Constants.AppName, message: Constants.blankEmail, view: self)
        //        }else if txtEmail.text?.isValidEmail == false {
        //            ShowBanner.show(title: "Please enter valid Email")
        ////            Budtender.showAlert(title: Constants.AppName, message: Constants.validEmail, view: self)
        //        }else if txtPassword.text == ""{
        //            Budtender.showAlert(title: Constants.AppName, message: Constants.blankPassword, view: self)
        //        }else if txtPassword?.isValidPassword() == false {
        //            Budtender.showAlert(title: Constants.AppName, message: Constants.minimumRangeSet, view: self)
        //        }else{
        
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            var signModel = SignupModel()
            signModel.email = self.txtEmail.text
            signModel.password = self.txtPassword.text
            signModel.deviceType = "1"
            signModel.is_type = "1"
            signModel.deviceToken = AppDefaults.deviceToken
            SVProgressHUD.show()
            UserApiModel().userLogin(model: signModel) { response, error in
                SVProgressHUD.dismiss()
                if let jsonResponse = response {
                    if let parsedData = try? JSONSerialization.data(withJSONObject: jsonResponse,options: .prettyPrinted){
                        let userDict = try? JSONDecoder().decode(ApiResponseModel<UserData>.self, from: parsedData)
                        if userDict?.status == 200{
                            Singleton.shared.showErrorMessage(error:  response?["message"] as? String ?? "", isError: .success)
                            if self.rememberMeBtn.isSelected == true {
                                let text = self.txtEmail.text ?? ""
                                let pass = self.txtPassword.text ?? ""
                                UserDefaults.standard.set(text, forKey:"USER_EMAIL")
                                UserDefaults.standard.set(pass, forKey:"USER_PASSWORD")
                                print("\(text) \(pass)")
                            } else {
                                UserDefaults.standard.removeObject(forKey: "USER_EMAIL")
                                UserDefaults.standard.removeObject(forKey: "USER_PASSWORD")
                            }
                            if let data1 = userDict?.data{
                                UserDefaultsCustom.saveUserData(userData: data1)
                                print("\(userDict?.data?.first_name)   = =   userData.data")
                                print("\(userDict?.data?.auth_token)   = =   userData.data")
                            }
                            
                            
                            AppDefaults.userID = userDict?.data?.user_id //?? ""
                            print(AppDefaults.userID,"Idddd")
                            AppDefaults.userFirstName = userDict?.data?.first_name ?? ""
                            AppDefaults.userLastName = userDict?.data?.last_name ?? ""
                            AppDefaults.token = "Bearer \(userDict?.data?.auth_token ?? "")"
                            print(AppDefaults.token,"Token")
                            let vc = ProductVC()
                            self.navigationController?.pushViewController(vc, animated: true)
                            //                            if "business" == UserDefaults.standard.string(forKey: "LoginType") {
                            ////                                UserDefaults.standard.set("3", forKey: "UserType")
                            //                                let vc = ProductVC()
                            //                                self.navigationController?.pushViewController(vc, animated: true)
                            //                            }else{
                            ////                                UserDefaults.standard.set("2", forKey: "UserType")
                            //                                let vc = HomeVC()
                            //                                self.navigationController?.pushViewController(vc, animated: true)
                            //                            }
                            //                            self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            //                            self.showMessage(message: response.debugDescription, isError: .error)
                            Singleton.shared.showErrorMessage(error:  response?["message"] as? String ?? "", isError: .error)
                        }
                    }
                }
            }
        }else{
            var signModel = SignupModel()
            signModel.email = self.txtEmail.text
            signModel.password = self.txtPassword.text
            signModel.deviceType = "1"
            signModel.is_type = "2"
            signModel.deviceToken = AppDefaults.deviceToken
            SVProgressHUD.show()
            UserApiModel().userLogin(model: signModel) { response, error in
                SVProgressHUD.dismiss()
                if let jsonResponse = response {
                    if let parsedData = try? JSONSerialization.data(withJSONObject: jsonResponse,options: .prettyPrinted){
                        let userDict = try? JSONDecoder().decode(ApiResponseModel<UserData>.self, from: parsedData)
                        if userDict?.status == 200 {
                            Singleton.shared.showErrorMessage(error:  response?["message"] as? String ?? "", isError: .success)
                            if self.rememberMeBtn.isSelected == true {
                                let text = self.txtEmail.text ?? ""
                                let pass = self.txtPassword.text ?? ""
                                UserDefaults.standard.set(text, forKey:"USER_EMAIL")
                                UserDefaults.standard.set(pass, forKey:"USER_PASSWORD")
                                print("\(text) \(pass)")
                            } else {
                                UserDefaults.standard.removeObject(forKey: "USER_EMAIL")
                                UserDefaults.standard.removeObject(forKey: "USER_PASSWORD")
                            }
                            if let data1 = userDict?.data {
                                UserDefaultsCustom.saveUserData(userData: data1)
                                print("\(userDict?.data?.first_name)   = =   userData.data")
                                print("\(userDict?.data?.auth_token)   = =   userData.data")
                            }

                            AppDefaults.userID = userDict?.data?.user_id //?? ""
                            print(AppDefaults.userID,"Idddd")
                            AppDefaults.userFirstName = userDict?.data?.first_name ?? ""
                            AppDefaults.userLastName = userDict?.data?.last_name ?? ""
                            AppDefaults.token = "Bearer \(userDict?.data?.auth_token ?? "")"
                            print(AppDefaults.token,"Token")
                            let vc = HomeVC()
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                            //                            if "business" == UserDefaults.standard.string(forKey: "LoginType") {
                            ////                                UserDefaults.standard.set("3", forKey: "UserType")
                            //                                let vc = ProductVC()
                            //                                self.navigationController?.pushViewController(vc, animated: true)
                            //                            }else{
                            ////                                UserDefaults.standard.set("2", forKey: "UserType")
                            //                                let vc = HomeVC()
                            //                                self.navigationController?.pushViewController(vc, animated: true)
                            //                            }
                            //                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        }else{
                            //                            self.showMessage(message: response.debugDescription, isError: .error)
                            Singleton.shared.showErrorMessage(error:  response?["message"] as? String ?? "", isError: .error)
                        }
                        
                    }
                }
            }
        }
        
        
        //            let vc = HomeVC()
        //            if "business" == UserDefaults.standard.string(forKey: "LoginType") {
        //                UserDefaults.standard.set("3", forKey: "UserType")
        //            }else{
        //                UserDefaults.standard.set("2", forKey: "UserType")
        //            }
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        }
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
                //                    profile_Image?.setImage(image: urlString,placeholder: UIImage(named: "PlaceHolder"))
                //.sd_setImage(with: profileImageUrl, completed: nil)
                print("urlString = \(urlString)")
                self.image = urlString
            }
            
            print("email=== \(email) id === \(idtoken) name === \(fName)")
            viewModel?.googleLoginApi(email: email ?? "", id: idd ?? "", firstName: givenName ?? "", lastName: family ?? "", name: fName ?? "", devideType: "1", isType: "1")
        }
    }
    
    
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
    
    
    //------------------------------------------------------
    //MARK: Actions
    
    @IBAction func hidePasswordAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        txtPassword.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func rememberMeSelectAction(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        if UserDefaults.standard.string(forKey: "LoginType") == "business" {
            let vc = ForgotPasswordVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if UserDefaults.standard.string(forKey: "LoginType") == "customer" {
            let vc = ForgotPasswordVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{

        }
    }
    @IBAction func loginAction(_ sender: UIButton) {
         validation()
//        let vc = HomeVC()
//        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
////                                UserDefaults.standard.set("3", forKey: "UserType")
//            let vc = ProductVC()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }else{
////                                UserDefaults.standard.set("2", forKey: "UserType")
//            let vc = HomeVC()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }

    }
    
    @IBAction func facebookAction(_ sender: UIButton) {
//        setFaceBook()
    }
    
    @IBAction func googleAction(_ sender: UIButton) {
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
           setGoogle()
        }else{
            setGoogle()
        }
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
    
    @IBAction func continueAsGuestAction(_ sender: UIButton) {
        let vc = HomeVC()
        UserDefaults.standard.set("1", forKey: "UserType")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        if UserDefaults.standard.string(forKey: "LoginType") == "business" {
            let vc = BusinessSignUpVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if UserDefaults.standard.string(forKey: "LoginType") == "customer" {
            let vc = SignUpVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
        }
    }
    //------------------------------------------------------
    @IBAction func backAction(_ sender: UIButton) {
       let vc = LoginTypeVC()
        self.navigationController?.pushViewController(vc, animated: false)
    
    }
}

extension LoginVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
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
extension LoginVC: LoginVMObserver{
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
