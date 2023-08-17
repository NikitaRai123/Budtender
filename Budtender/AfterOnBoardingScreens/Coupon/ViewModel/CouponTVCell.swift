//
//  CouponTVCell.swift
//  Budtender
//
//  Created by apple on 17/08/23.
//

import UIKit
class CouponTVCell: UITableViewCell {
    
    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var couponLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedButton.isUserInteractionEnabled = false
    }
    
    @IBAction func selectedAction(_ sender: UIButton) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
