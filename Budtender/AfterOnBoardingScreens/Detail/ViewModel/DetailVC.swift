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
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        sender.isSelected.toggle()
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
