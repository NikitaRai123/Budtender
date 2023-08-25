//
//  ProfileVC.swift
//  Budtender
//
//  Created by apple on 10/08/23.
//

import UIKit
import SideMenu
class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    
    var userGuest = [("Ic_Dispensary","Dispensary"),("Ic_Cart","Cart"),("Ic_My Orders","My Orders"),("Ic_Favorites"," Favorites"),("Ic_Notification","Notification"),("Ic_ChangePassword","Change Password"),("Ic_Delete Account","Delete Account"),("Ic_Terms & Conditions","Terms & Conditions"),("Ic_Privacy Policy","Privacy Policy"),("Ic_SwitchBusinessAccount","Switch to Business account"),("Ic_Logout","Logout")]
    
    var business = [("Ic_Manage Dispensary","Manage Dispensary"),("Ic_Products","Products"),("Ic_My Orders","My Orders"),("Ic_Notification","Notifications"),("Ic_ChangePassword","Change Password"),("Ic_Delete Account","Delete Account"),("Ic_Terms & Conditions","Terms & Conditions"),("Ic_Privacy Policy","Privacy Policy"),("Ic_Logout","Logout")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        self.profileTableView.register(UINib(nibName: "ProfileTVCell", bundle: nil), forCellReuseIdentifier: "ProfileTVCell")
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imagetTapgesture))
        profileImage.addGestureRecognizer(imageTapGesture)
        let NameTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.nameTapgesture))
        nameLabel.addGestureRecognizer(NameTapGesture)
        
    }
    @objc func imagetTapgesture(){
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
extension ProfileVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            return userGuest.count
        }else if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            return business.count
        }else{
            return userGuest.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTVCell", for: indexPath) as! ProfileTVCell
            cell.titleImage.image = UIImage(named: userGuest[indexPath.row].0)
            cell.titleLabel.text = "\(userGuest[indexPath.row].1)"
            if indexPath.row == 9{
                cell.toggleSwitch.isHidden = false
            }else{
                cell.toggleSwitch.isHidden = true
            }
            return cell
        }else if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTVCell", for: indexPath) as! ProfileTVCell
            cell.titleImage.image = UIImage(named: userGuest[indexPath.row].0)
            cell.titleLabel.text = "\(userGuest[indexPath.row].1)"
            cell.toggleSwitch.isHidden = true
            cell.delegate = self
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTVCell", for: indexPath) as! ProfileTVCell
            cell.titleImage.image = UIImage(named: userGuest[indexPath.row].0)
            cell.titleLabel.text = "\(userGuest[indexPath.row].1)"
            if indexPath.row == 9{
                cell.toggleSwitch.isHidden = false
            }else{
                cell.toggleSwitch.isHidden = true
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            switch indexPath.row {
            case 1:
                let vc = MyCartVC()
                vc.comeFrom = "MyCart"
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 2:
                let vc = MyOrderVC()
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 3:
                let vc = FavoriteVC()
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 4:
                let vc = NotificationVC()
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 5:
                let vc = ChangePasswordVC()
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 6:
                let alertController = UIAlertController(title: "Delete Account", message: "Are you sure, you want to delete your account?", preferredStyle: .alert)
                let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let actionDelete = UIAlertAction(title: "Delete", style: .default) {_ in
                    let vc = LoginTypeVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                alertController.addAction(actionDelete)
                alertController.addAction(actionCancel)
                
            case 7:
                let vc = TermAndConditionVC()
                vc.comeFrom = "Terms & Conditions"
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 8:
                let vc = TermAndConditionVC()
                vc.comeFrom = "Privacy Policy"
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 10:
                let alertController = UIAlertController(title: "Logout", message: "Are you sure, you want to logout?", preferredStyle: .alert)
                
                let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let actionLogout = UIAlertAction(title: "Logout", style: .destructive) {_ in
                    let vc = LoginTypeVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                alertController.addAction(actionCancel)
                alertController.addAction(actionLogout)
                present(alertController, animated: true, completion: nil)
                
            default:
                break
            }
            
        }else if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
            switch indexPath.row {
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
                return
                
            case 8:
                return
                
            case 10:
                return
            default:
                break
            }
        }
        else{
            switch indexPath.row {
            case 1:
                let vc = ProductVC()
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 2:
                return
                
            case 3:
                let vc = NotificationVC()
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 4:
                let vc = ChangePasswordVC()
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 5:
                let alertController = UIAlertController(title: "Delete Account", message: "Are you sure, you want to delete your account?", preferredStyle: .alert)
                let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let actionDelete = UIAlertAction(title: "Delete", style: .default) {_ in
                    let vc = LoginTypeVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                alertController.addAction(actionDelete)
                alertController.addAction(actionCancel)
                present(alertController, animated: true, completion: nil)
                
            case 6:
                let vc = TermAndConditionVC()
                vc.comeFrom = "Terms & Conditions"
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 7:
                let vc = TermAndConditionVC()
                vc.comeFrom = "Privacy Policy"
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 8:
                let alertController = UIAlertController(title: "Logout", message: "Are you sure, you want to logout?", preferredStyle: .alert)
                let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let actionLogout = UIAlertAction(title: "Logout", style: .destructive) {_ in
                    let vc = LoginTypeVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                alertController.addAction(actionCancel)
                alertController.addAction(actionLogout)
                present(alertController, animated: true, completion: nil)
                
            default:
                break
            }
            
        }
    }
    
}
extension ProfileVC: ProfileTVCellDelegate{
    func didTapToggleSwitch(button: UISwitch) {
            let vc = BusinessSignUpVC()
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
