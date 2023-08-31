//
//  DetailVC.swift
//  Budtender
//
//  Created by apple on 10/08/23.
//

import UIKit
import Cosmos
class DetailVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var productFirstImage: UILabel!
    @IBOutlet weak var productSecondImage: UIImageView!
    @IBOutlet weak var firstImageDiscLabel: UILabel!
    @IBOutlet weak var firstImagePriceLabel: UILabel!
    @IBOutlet weak var secondImageDiscLabel: UILabel!
    @IBOutlet weak var secondImagePriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
                } else {
                    automaticallyAdjustsScrollViewInsets = false
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
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            sender.isSelected.toggle()
        }else if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
            showAlert()
        }else{}
    }
    @IBAction func phoneAction(_ sender: UIButton) {
    }
    
    @IBAction func viewOnMapAction(_ sender: UIButton) {
    }
    
    @IBAction func viewAllAction(_ sender: UIButton) {
        let vc = ProductVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
