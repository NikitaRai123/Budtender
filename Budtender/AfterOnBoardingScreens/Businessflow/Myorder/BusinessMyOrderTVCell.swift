//
//  BusinessMyOrderTVCell.swift
//  Budtender
//
//  Created by apple on 29/08/23.
//

import UIKit

protocol BusinessOrderTVCellDelegate: NSObjectProtocol {
   
    func didTaprateDispensaryButton(_ indexPath: IndexPath)
    func didTappedCompletedRejected(orderId: String, type: String)
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
    @IBOutlet weak var buttonsView: UIStackView!
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Variables
    
    var delegate: BusinessOrderTVCellDelegate?
    var orderData: OrderData?
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup(withData orderData: OrderData, type: String) {
        self.orderData = orderData
        
        self.profileImage.setImage(image: orderData.pickup_details?.image, placeholder: UIImage(named: "dispensaryPlaceholder"))
        nameLabel.text = orderData.pickup_details?.name
        
        self.productImage.setImage(image: orderData.product_details?.image, placeholder: UIImage(named: "dispensaryPlaceholder"))
        productNameLabel.text = "\(orderData.product_details?.product_name ?? "") - \(orderData.product_details?.brand_name ?? "") - \(orderData.product_details?.weight ?? "") - \(orderData.product_details?.qty ?? "")"
//        discriptionLabel.text = orderData.product_details?.description
        priceLabel.text = "$\(orderData.product_details?.price ?? String())"
        self.buttonsView.isHidden = type == "2" ? false : true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func completeButtonAction(_ sender: UIButton) {
        self.delegate?.didTappedCompletedRejected(orderId: "\(self.orderData?.order_id ?? 0)", type: "1")
    }
    
    @IBAction func rejectButtonAction(_ sender: UIButton) {
        self.delegate?.didTappedCompletedRejected(orderId: "\(self.orderData?.order_id ?? 0)", type: "2")
    }
    
}
