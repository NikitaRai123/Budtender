//
//  DealsDetailVC.swift
//  Budtender
//
//  Created by apple on 24/08/23.
//

import UIKit
class DealsDetailVC: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var copyCodeButton: UIButton!
    
    @IBOutlet weak var expireInLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func copyCodeAction(_ sender: UIButton) {
    }
    
}
