//
//  ProductDetailVC.swift
//  Budtender
//
//  Created by apple on 16/08/23.
//

import UIKit
class ProductDetailVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDetailLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            sender.isSelected.toggle()
        }else{
            
        }
    }
    @IBAction func pickupDispSelectAction(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @IBAction func addCartAction(_ sender: UIButton) {
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            let vc = MyCartVC()
            vc.comeFrom = "MyCart"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            
        }else{
            let vc = SignUpVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
