//
//  ProfileVC.swift
//  Budtender
//
//  Created by apple on 10/08/23.
//

import UIKit
import SideMenu
import SVProgressHUD
import SDWebImage
import GoogleMobileAds

class ProfileVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var topAdsView: UIView!
    @IBOutlet weak var bottomAdsView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Variables
    
    var viewModel: ProfileVM?
    var bannerView: GADBannerView!
    var secondBannerView: GADBannerView!

    
    var userGuest = [("Ic_Dispensary","Dispensary"),("Ic_Cart","Cart"),("Ic_My Orders","My Orders"),("Ic_Favorites"," Favorites"),("Ic_ChangePassword","Change Password"),("Ic_Delete Account","Delete Account"),("Ic_Terms & Conditions","Terms & Conditions"),("Ic_Privacy Policy","Privacy Policy"),("Ic_Logout","Logout"),("",""),("legal","Support"),("support","Legal")]
    var userGuestGoogle = [("Ic_Dispensary","Dispensary"),("Ic_Cart","Cart"),("Ic_My Orders","My Orders"),("Ic_Favorites"," Favorites"),("Ic_Delete Account","Delete Account"),("Ic_Terms & Conditions","Terms & Conditions"),("Ic_Privacy Policy","Privacy Policy"),("Ic_Logout","Logout"),("",""),("legal","Support"),("support","Legal")]

    var business = [("Ic_Manage Dispensary","Manage Dispensary"),("Ic_Products","Products"),("Ic_My Orders","My Orders"),("Ic_Notification","Notifications"),("Ic_ChangePassword","Change Password"),("Ic_Delete Account","Delete Account"),("Ic_Terms & Conditions","Terms & Conditions"),("Ic_Privacy Policy","Privacy Policy"),("Ic_Logout","Logout"),("",""),("legal","Support"),("support","Legal")]
    var businessGoogle = [("Ic_Manage Dispensary","Manage Dispensary"),("Ic_Products","Products"),("Ic_My Orders","My Orders"),("Ic_Notification","Notifications"),("Ic_Delete Account","Delete Account"),("Ic_Terms & Conditions","Terms & Conditions"),("Ic_Privacy Policy","Privacy Policy"),("Ic_Logout","Logout"),("",""),("legal","Support"),("support","Legal")]
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            self.loadAdsView()
            self.topAdsView.isHidden = false
            self.bottomAdsView.isHidden = false
            self.topViewHeight.constant = 50
            self.bottomViewHeight.constant = 50
        } else {
            self.topAdsView.isHidden = true
            self.bottomAdsView.isHidden = true
            self.topViewHeight.constant = 0
            self.bottomViewHeight.constant = 0
        }
        
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        self.profileTableView.register(UINib(nibName: "ProfileTVCell", bundle: nil), forCellReuseIdentifier: "ProfileTVCell")
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imagetTapgesture))
        profileImage.addGestureRecognizer(imageTapGesture)
        let NameTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.nameTapgesture))
        nameLabel.addGestureRecognizer(NameTapGesture)
        setViewModel()
//        getProfileApi()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(UserDefaultsCustom.getUserData())
        self.profileImage.setImage(image: UserDefaultsCustom.getUserData()?.image,placeholder: UIImage(named: "profilePlaceholder"))
        self.nameLabel.text = UserDefaultsCustom.getUserData()?.name
        self.emailLabel.text = UserDefaultsCustom.getUserData()?.email
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            self.emailLabel.text = "Business Profile"
        }
//        getProfileApi()
    }
    
    func setViewModel(){
        self.viewModel = ProfileVM(observer: self)
    }
    
    
    func loadAdsView() {
        let adSize = GADAdSizeFromCGSize(CGSize(width: UIScreen.main.bounds.width, height: 50))
        bannerView = GADBannerView(adSize: adSize)
        bannerView.delegate = self
        secondBannerView = GADBannerView(adSize: adSize)
        secondBannerView.delegate = self
        addBannerViewToView(bannerView)
        addSecondBannerViewToView(secondBannerView)
    }
    
    //MARK:- add Banner to view
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        topAdsView.addSubview(bannerView)
    }
    
    func addSecondBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bottomAdsView.addSubview(bannerView)
    }
    
    
    func getProfileApi(){
        var signModel = SignupModel()
        SVProgressHUD.show()
        UserApiModel().getProfile(model: signModel) { response, error in
            SVProgressHUD.dismiss()
            if let jsonResponse = response{
                if let parsedData = try? JSONSerialization.data(withJSONObject: jsonResponse,options: .prettyPrinted){
                    let userDict = try? JSONDecoder().decode(ApiResponseModel<UserData>.self, from: parsedData)
                    if userDict?.status == 200 {
                        self.nameLabel.text = "\(userDict?.data?.first_name ?? "Dharmani") \(userDict?.data?.last_name ?? "Apps")"
                        self.emailLabel.text = userDict?.data?.email ?? ""
                        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2
                        self.profileImage.layer.masksToBounds = true
                        
                    }
                }
            }
        }
    }
    
    @objc func imagetTapgesture() {
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            let vc = EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
            showAlert()
        }else{
            let vc = EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func nameTapgesture(){
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            let vc = EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
            showAlert()
        }else{
            let vc = EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func showAlert(){
        let alertController = UIAlertController(title: "Alert", message: "Please login to use this functionality", preferredStyle: .alert)
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
//MARK: ExtensionTableView

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            if UserDefaultsCustom.getUserData()?.google_id == nil && UserDefaultsCustom.getUserData()?.apple_id == nil {
                return userGuest.count
            }else{
                return userGuestGoogle.count
            }
        }else if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            if UserDefaultsCustom.getUserData()?.google_id == nil && UserDefaultsCustom.getUserData()?.apple_id == nil {
                return business.count
            } else {
                return businessGoogle.count
            }
        }else{
            return userGuest.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTVCell", for: indexPath) as! ProfileTVCell
            if UserDefaultsCustom.getUserData()?.google_id == nil && UserDefaultsCustom.getUserData()?.apple_id == nil {
                cell.titleImage.image = UIImage(named: userGuest[indexPath.row].0)
                cell.titleLabel.text = "\(userGuest[indexPath.row].1)"
                cell.delegate = self
                cell.toggleSwitch.isHidden = true
//                if indexPath.row == 9{
//                    cell.toggleSwitch.isHidden = false
//                }else{
//                    cell.toggleSwitch.isHidden = true
//                }
            }else{
                cell.titleImage.image = UIImage(named: userGuestGoogle[indexPath.row].0)
                cell.titleLabel.text = "\(userGuestGoogle[indexPath.row].1)"
                cell.delegate = self
                cell.toggleSwitch.isHidden = true
//                if indexPath.row == 8{
//                    cell.toggleSwitch.isHidden = false
//                }else{
//                    cell.toggleSwitch.isHidden = true
//                }
            }
            return cell
        } else if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTVCell", for: indexPath) as! ProfileTVCell
            if UserDefaultsCustom.getUserData()?.google_id == nil && UserDefaultsCustom.getUserData()?.apple_id == nil {
                cell.titleImage.image = UIImage(named: business[indexPath.row].0)
                cell.titleLabel.text = "\(business[indexPath.row].1)"
                cell.toggleSwitch.isHidden = true
                cell.delegate = self
//                profileTableView.isScrollEnabled = false
            }else{
                cell.titleImage.image = UIImage(named: businessGoogle[indexPath.row].0)
                cell.titleLabel.text = "\(businessGoogle[indexPath.row].1)"
                cell.toggleSwitch.isHidden = true
                cell.delegate = self
//                profileTableView.isScrollEnabled = false
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTVCell", for: indexPath) as! ProfileTVCell
            cell.titleImage.image = UIImage(named: userGuest[indexPath.row].0)
            cell.titleLabel.text = "\(userGuest[indexPath.row].1)"
            cell.delegate = self
            cell.toggleSwitch.isHidden = true
//            if indexPath.row == 9{
//                cell.toggleSwitch.isHidden = false
//            }else{
//                cell.toggleSwitch.isHidden = true
//            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            if UserDefaultsCustom.getUserData()?.google_id == nil  && UserDefaultsCustom.getUserData()?.apple_id == nil {
                switch indexPath.row {
                case 0:
//                    let vc = HomeVC()
//                    self.navigationController?.pushViewController(vc, animated: true)
                    self.dismiss(animated: true)
                case 1:
                    let vc = MyCartVC()
                    vc.comeFrom = "MyCart"
                    vc.isFromSideMenu = true
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 2:
                    let vc = MyOrderVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 3:
                    let vc = FavoriteVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
//                case 4:
//                    let vc = NotificationVC()
//                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 4:
                    let vc = ChangePasswordVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 5:
                    print("Delete Account")
                    let alertController = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete your account?", preferredStyle: .alert)
                    let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    let actionDelete = UIAlertAction(title: "Delete", style: .default) {_ in
                        self.viewModel?.hitDeleteApi(isType: "2")
    //                    let vc = LoginTypeVC()
    //                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                    alertController.addAction(actionDelete)
                    alertController.addAction(actionCancel)
                    present(alertController, animated: true, completion: nil)
                    
                case 6:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Terms & Conditions"
                    vc.link = "http://161.97.132.85/budtender/terms&Conditions.php"
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 7:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Privacy Policy"
                    vc.link = "http://161.97.132.85/budtender/aboutUs.php"
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 8:
                    let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
                    
                    let actionCancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
                    let actionLogout = UIAlertAction(title: "Yes", style: .destructive) {_ in
                        self.viewModel?.hitLogOutApi()
    //                    let vc = LoginTypeVC()
    //                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                    alertController.addAction(actionCancel)
                    alertController.addAction(actionLogout)
                    present(alertController, animated: true, completion: nil)

                case 9: break
                case 10:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Support"
                    vc.link = "http://161.97.132.85/budtender/support.php"
                    self.navigationController?.pushViewController(vc, animated: true)

                case 11:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Legal"
                    vc.link = "http://161.97.132.85/budtender/legal.php"
                    self.navigationController?.pushViewController(vc, animated: true)

                default:
                    break
                }
            }else{
                switch indexPath.row {
                case 0:
//                    let vc = HomeVC()
//                    self.navigationController?.pushViewController(vc, animated: true)
                    self.dismiss(animated: true)
                case 1:
                    let vc = MyCartVC()
                    vc.comeFrom = "MyCart"
                    vc.isFromSideMenu = true
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 2:
                    let vc = MyOrderVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 3:
                    let vc = FavoriteVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
//                case 4:
//                    let vc = NotificationVC()
//                    self.navigationController?.pushViewController(vc, animated: true)
                    
//                case 5:
//                    let vc = ChangePasswordVC()
//                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 4:
                    print("Delete Account")
                    let alertController = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete your account?", preferredStyle: .alert)
                    let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    let actionDelete = UIAlertAction(title: "Delete", style: .default) {_ in
                        self.viewModel?.hitDeleteApi(isType: "2")
    //                    let vc = LoginTypeVC()
    //                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                    alertController.addAction(actionDelete)
                    alertController.addAction(actionCancel)
                    present(alertController, animated: true, completion: nil)
                    
                case 5:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Terms & Conditions"
                    vc.link = "http://161.97.132.85/budtender/terms&Conditions.php"
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 6:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Privacy Policy"
                    vc.link = "http://161.97.132.85/budtender/aboutUs.php"
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 7:
                    let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
                    
                    let actionCancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
                    let actionLogout = UIAlertAction(title: "Yes", style: .destructive) {_ in
                        self.viewModel?.hitLogOutApi()
    //                    let vc = LoginTypeVC()
    //                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                    alertController.addAction(actionCancel)
                    alertController.addAction(actionLogout)
                    present(alertController, animated: true, completion: nil)
                case 8: break
                case 9:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Support"
                    vc.link = "http://161.97.132.85/budtender/support.php"
                    self.navigationController?.pushViewController(vc, animated: true)

                case 10:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Legal"
                    vc.link = "http://161.97.132.85/budtender/legal.php"
                    self.navigationController?.pushViewController(vc, animated: true)

                default:
                    break
                }
            }
    
            
        }else if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
            switch indexPath.row {
            case 0:
                self.dismiss(animated: true)
                
            case 1:
                showAlert()
                
            case 2:
                showAlert()
                
            case 3:
                showAlert()
                
            case 4:
                showAlert()
                
            case 5:
                showAlert()
                
            case 6:
                showAlert()
                
            case 7:
                showAlert()
                return
                
            case 8:
                showAlert()
                return
                
            case 9:
                let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
                let actionNo = UIAlertAction(title: "No", style: .cancel, handler: nil)
                let actionYes = UIAlertAction(title: "Yes", style: .destructive) {_ in
                    let vc = LoginTypeVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                alertController.addAction(actionNo)
                alertController.addAction(actionYes)
                present(alertController, animated: true, completion: nil)
            case 10: break
            case 11:
                let vc = TermAndConditionVC()
                vc.comeFrom = "Support"
                vc.link = "http://161.97.132.85/budtender/support.php"
                self.navigationController?.pushViewController(vc, animated: true)

            case 12:
                let vc = TermAndConditionVC()
                vc.comeFrom = "Legal"
                vc.link = "http://161.97.132.85/budtender/legal.php"
                self.navigationController?.pushViewController(vc, animated: true)

            default:
                break
            }
        }
        else {
            if UserDefaultsCustom.getUserData()?.google_id == nil && UserDefaultsCustom.getUserData()?.apple_id == nil {
                switch indexPath.row {
                case 0:
                    let vc = ManageDispensaryVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 1:
                    let vc = ProductVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 2:
                    let vc = BusinessMyOrderVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 3:
                    let vc = NotificationVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 4:
                    let vc = ChangePasswordVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 5:
                    let alertController = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete your account?", preferredStyle: .alert)
                    let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    let actionDelete = UIAlertAction(title: "Delete", style: .default) {_ in
                        self.viewModel?.hitDeleteApi(isType: "1")
    //                    let vc = LoginTypeVC()
    //                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                    alertController.addAction(actionDelete)
                    alertController.addAction(actionCancel)
                    present(alertController, animated: true, completion: nil)
                    
                case 6:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Terms & Conditions"
                    vc.link = "http://161.97.132.85/budtender/terms&Conditions.php"
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 7:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Privacy Policy"
                    vc.link = "http://161.97.132.85/budtender/aboutUs.php"
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 8:
                    let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
                    let actionNo = UIAlertAction(title: "No", style: .cancel, handler: nil)
                    let actionYes = UIAlertAction(title: "Yes", style: .destructive) {_ in
                        self.viewModel?.hitLogOutApi()
    //                    let vc = LoginTypeVC()
    //                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                    alertController.addAction(actionNo)
                    alertController.addAction(actionYes)
                    present(alertController, animated: true, completion: nil)
                case 9: break
                case 10:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Support"
                    vc.link = "http://161.97.132.85/budtender/support.php"
                    self.navigationController?.pushViewController(vc, animated: true)

                case 11:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Legal"
                    vc.link = "http://161.97.132.85/budtender/legal.php"
                    self.navigationController?.pushViewController(vc, animated: true)

                default:
                    break
                }
            }else{
                switch indexPath.row {
                case 0:
                    let vc = ManageDispensaryVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 1:
                    let vc = ProductVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 2:
                    let vc = BusinessMyOrderVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 3:
                    let vc = NotificationVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
//                case 4:
//                    let vc = ChangePasswordVC()
//                    self.navigationController?.pushViewController(vc, animated: true)
//
                case 4:
                    let alertController = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete your account?", preferredStyle: .alert)
                    let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    let actionDelete = UIAlertAction(title: "Delete", style: .default) {_ in
                        self.viewModel?.hitDeleteApi(isType: "1")
    //                    let vc = LoginTypeVC()
    //                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                    alertController.addAction(actionDelete)
                    alertController.addAction(actionCancel)
                    present(alertController, animated: true, completion: nil)
                    
                case 5:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Terms & Conditions"
                    vc.link = "http://161.97.132.85/budtender/terms&Conditions.php"
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 6:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Privacy Policy"
                    vc.link = "http://161.97.132.85/budtender/aboutUs.php"
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 7:
                    let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
                    let actionNo = UIAlertAction(title: "No", style: .cancel, handler: nil)
                    let actionYes = UIAlertAction(title: "Yes", style: .destructive) {_ in
                        self.viewModel?.hitLogOutApi()
    //                    let vc = LoginTypeVC()
    //                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                    alertController.addAction(actionNo)
                    alertController.addAction(actionYes)
                    present(alertController, animated: true, completion: nil)
                case 8: break
                case 9:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Support"
                    vc.link = "http://161.97.132.85/budtender/support.php"
                    self.navigationController?.pushViewController(vc, animated: true)

                case 10:
                    let vc = TermAndConditionVC()
                    vc.comeFrom = "Legal"
                    vc.link = "http://161.97.132.85/budtender/legal.php"
                    self.navigationController?.pushViewController(vc, animated: true)

                default:
                    break
                }
            }
            
            
        }
    }
}

extension ProfileVC: ProfileTVCellDelegate{
    func didTapToggleSwitch(button: UISwitch) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [self] in
            UserDefaults.standard.set("business", forKey: "LoginType")
            setHomeScreen()
        }
    }
}
extension ProfileVC: ProfileVMObserver{
    func observerLogoutApi() {
        Singleton.shared.logoutFromDevice()
    }
    
    
}


//MARK:- Banner Delegate  Method(s)
extension ProfileVC: GADBannerViewDelegate{
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
        print("banner loaded")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
}

