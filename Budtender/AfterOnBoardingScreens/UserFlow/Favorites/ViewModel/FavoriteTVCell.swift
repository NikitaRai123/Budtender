//
//  FavoriteTVCell.swift
//  Budtender
//
//  Created by apple on 22/08/23.
//

import UIKit
import Cosmos
protocol FavoriteTVCellDelegate: NSObjectProtocol {
    func didTapFavoriteButton(button: UIButton, cell:FavoriteTVCell?, id: String?)
}

class FavoriteTVCell: UITableViewCell {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var delegate: FavoriteTVCellDelegate?
    var dispensaryData: DispensaryData?
    var productData: ProductDetails?
    var id: String?
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.shadowRadius = 4
        self.bgView.shadowOpacity = 0.3
        self.bgView.shadowOffset = CGSize(width: 0, height: 0)
        self.bgView.shadowColor = .gray
    }
    
    func passData(data: DispensaryData){
        self.dispensaryData = data
    }
    
    func passProductData(data1: ProductDetails) {
        self.productData = data1
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    @IBAction func favoriteAction(_ sender: UIButton) {
        self.delegate?.didTapFavoriteButton(button: favoriteButton, cell: self, id: self.id)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
