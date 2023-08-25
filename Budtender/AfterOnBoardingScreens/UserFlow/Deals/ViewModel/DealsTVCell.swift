//
//  DealsTVCell.swift
//  Budtender
//
//  Created by apple on 24/08/23.
//

import UIKit
class DealsTVCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.bgView.shadowRadius = 4
        self.bgView.shadowOpacity = 0.4
        self.bgView.shadowOffset = CGSize(width: 0, height: 0)
        self.bgView.shadowColor = .gray
        
        let attributedString = NSMutableAttributedString(string: "25% OFF VAPES, EDIBLES & CONCENTRATES SALE! Every day, only at FARMACY SANTA ANA..")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.lineBreakMode = .byTruncatingTail
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        discriptionLabel.attributedText = attributedString
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
