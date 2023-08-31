//
//  ManageDispensaryDetailVC.swift
//  Budtender
//
//  Created by apple on 30/08/23.
//

import UIKit
class ManageDispensaryDetailVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeSatusLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var websiteAddressLabel: UILabel!
    @IBOutlet weak var licenceNumberLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var productFirstImage: UIImageView!
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
    
    @IBAction func phoneAction(_ sender: UIButton) {
    }
    
    @IBAction func viewOnMapAction(_ sender: UIButton) {
    }
    
    @IBAction func websiteViewonMapAction(_ sender: UIButton) {
    }
    
    @IBAction func viewAllAction(_ sender: UIButton) {
    }
}
