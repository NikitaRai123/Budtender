//
//  ProductSubCategoryCVCell.swift
//  Budtender
//
//  Created by apple on 16/08/23.
//

import UIKit

class ProductSubCategoryCVCell: UICollectionViewCell {
    
    @IBOutlet weak var ImageBgView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
     
        self.ImageBgView.shadowRadius = 4
        self.ImageBgView.shadowOpacity = 0.5
        self.ImageBgView.shadowOffset = CGSize(width: 0, height: 0)
        self.ImageBgView.shadowColor = .gray
    }

}
