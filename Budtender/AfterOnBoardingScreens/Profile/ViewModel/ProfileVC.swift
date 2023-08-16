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
    
    var profile = [("Ic_Dispensary","Dispensary"),("Ic_Deals","Deals"),("Ic_Cart","Cart"),("Ic_My Orders","My Orders"),("Ic_Favorites"," Favorites"),("Ic_Notification","Notification"),("Ic_Delete Account","Delete Account"),("Ic_Terms & Conditions","Terms & Conditions"),("Ic_Privacy Policy","Privacy Policy"),("Ic_SwitchBusinessAccount","Switch to Business account"),("Ic_Logout","Logout")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        self.profileTableView.register(UINib(nibName: "ProfileTVCell", bundle: nil), forCellReuseIdentifier: "ProfileTVCell")
    }
}
extension ProfileVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTVCell", for: indexPath) as! ProfileTVCell
        cell.titleImage.image = UIImage(named: profile[indexPath.row].0)
        cell.titleLabel.text = "\(profile[indexPath.row].1)"
        if indexPath.row == 9{
            cell.toggleSwitch.isHidden = false
        }else{
            cell.toggleSwitch.isHidden = true
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 3{
//            let vc = ChangePasswordScreenVC()
//            self.navigationController?.pushViewController(vc, animated: true)
//                    }else if indexPath.row == 0 {
//                        let vc = MyOrderScreenVC()
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
//        else if indexPath.row == 2 {
//            let vc = MyCardsScreenVC()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        else if indexPath.row == 1 {
//            let vc = MyAddressScreenVC()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        }
    }

