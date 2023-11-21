//
//  MyOrderDetailTVCell.swift
//  Budtender
//
//  Created by apple on 29/08/23.
//

import UIKit

class MyOrderDetailTVCell: UITableViewCell {

    //-------------------------------------------------------------------------------------------------------

    //MARK: Outlets
    
    @IBOutlet weak var imageBgView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    //------------------------------------------------------
    
    //MARK: Custom

    func setup(order orderData: OrderData) {
        /**self.productDetailLabel.text = "\(self.ProductDetail?.product_name ?? "")\("-")\(self.ProductDetail?.brand_name ?? "") (\(self.ProductDetail?.weight ?? ""))"
         self.amountLabel.text = "\("$")\(self.ProductDetail?.price ?? "")"
         self.quantityLabel.text = self.ProductDetail?.qty
         self.discriptionLabel.text = self.ProductDetail?.description*/
        
        self.productImage.setImage(image: orderData.product_details?.image, placeholder: UIImage(named: "dispensaryPlaceholder"))
        self.nameLabel.text = "\(orderData.product_details?.product_name ?? "") - \(orderData.product_details?.brand_name ?? "") - \(orderData.product_details?.weight ?? "") - \(orderData.product_details?.qty ?? "")"
//        self.discriptionLabel.text = orderData.product_details?.description
        self.amountLabel.text =  "\("$")\(orderData.product_details?.price ?? "")"
        
        /*if orderData.product_details?.is_fav == "1"{
            likeBtn.setImage(UIImage(named: "Ic_Like"), for: .normal)
        }else{
            likeBtn.setImage(UIImage(named: "Ic_DisLike"), for: .normal)
        }*/
        
        /*if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
            self.likeBtn.isHidden = true
        } else {
            self.likeBtn.isHidden = false
        }*/
        
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageBgView.shadowRadius = 4
        self.imageBgView.shadowOpacity = 0.5
        self.imageBgView.shadowOffset = CGSize(width: 0, height: 0)
        self.imageBgView.shadowColor = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
