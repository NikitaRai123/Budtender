//
//  BusinessMyOrderTVCell.swift
//  Budtender
//
//  Created by apple on 29/08/23.
//

import UIKit

protocol BusinessOrderTVCellDelegate: NSObjectProtocol {
   
    func didTaprateDispensaryButton(_ indexPath: IndexPath)
}

class BusinessMyOrderTVCell: UITableViewCell {
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Variables
    
    var delegate: BusinessOrderTVCellDelegate?
    var orderData: OrderData?
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup(withData orderData: OrderData) {
        self.orderData = orderData
        
        self.profileImage.setImage(image: orderData.pickup_details?.image, placeholder: UIImage(named: "dispensaryPlaceholder"))
        nameLabel.text = orderData.pickup_details?.name
        
        self.productImage.setImage(image: orderData.product_details?.image, placeholder: UIImage(named: "dispensaryPlaceholder"))
        productNameLabel.text = orderData.product_details?.product_name
        discriptionLabel.text = orderData.product_details?.description
        priceLabel.text = "$\(orderData.product_details?.price ?? String())"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
