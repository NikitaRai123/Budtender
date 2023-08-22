//
//  ProductDetailVC.swift
//  Budtender
//
//  Created by apple on 16/08/23.
//

import UIKit
class ProductDetailVC: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDetailLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @IBAction func pickupDispSelectAction(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @IBAction func addCartAction(_ sender: UIButton) {
        let vc = MyCartVC()
        vc.comeFrom = "MyCart"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
