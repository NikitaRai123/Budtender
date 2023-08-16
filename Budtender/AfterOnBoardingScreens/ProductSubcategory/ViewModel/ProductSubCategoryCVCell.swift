//
//  ProductSubCategoryCVCell.swift
//  Budtender
//
//  Created by apple on 16/08/23.
//

import UIKit

class ProductSubCategoryCVCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
     
        self.bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.bgView.layer.shadowColor = UIColor.gray.cgColor
        self.bgView.layer.shadowOpacity = 4
        self.bgView.layer.shadowRadius = 8
    }

}
