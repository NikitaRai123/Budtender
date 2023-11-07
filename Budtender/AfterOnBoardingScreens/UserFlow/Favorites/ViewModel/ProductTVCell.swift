//
//  ProductTVCell.swift
//  Budtender
//
//  Created by apple on 22/08/23.
//

import UIKit

protocol ProductTVCellDelegate {
    func likeUnlike(id: String?)
}


class ProductTVCell: UITableViewCell {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imagebgView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeDislikeButton: UIButton!
    
    
    var delegate: ProductTVCellDelegate?
    var id: String?
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.shadowRadius = 4
        self.bgView.shadowOpacity = 0.3
        self.bgView.shadowOffset = CGSize(width: 0, height: 0)
        self.bgView.shadowColor = .gray
        
        self.imagebgView.shadowRadius = 4
        self.imagebgView.shadowOpacity = 0.4
        self.imagebgView.shadowOffset = CGSize(width: 0, height: 0)
        self.imagebgView.shadowColor = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func productFavUnfavButtonAction(_ sender: Any) {
        self.delegate?.likeUnlike(id: id)
    }
    
    
}
