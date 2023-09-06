//
//  DealsDetailVC.swift
//  Budtender
//
//  Created by apple on 24/08/23.
//

import UIKit
class DealsDetailVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var copyCodeButton: UIButton!
    @IBOutlet weak var expireInLabel: UILabel!
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidload
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Action
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func copyCodeAction(_ sender: UIButton) {
    }
}
