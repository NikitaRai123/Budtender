//
//  MyOrderTVCell.swift
//  Budtender
//
//  Created by apple on 21/08/23.
//

import UIKit
import Cosmos
import SDWebImage

protocol MyOrderTVCellDelegate: NSObjectProtocol {
   
    func didTaprateDispensaryButton(_ indexPath: IndexPath)
}

class MyOrderTVCell: UITableViewCell {
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Outlets
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rateDispensaryButton: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Variables
    
    var delegate: MyOrderTVCellDelegate?
    var orderData: OrderData?
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Memory
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        ratingView.settings.updateOnTouch = true
        ratingView.settings.disablePanGestures = true
        ratingView.isUserInteractionEnabled = true
        
        ratingView.didTouchCosmos = { value in
            debugPrint(value)
            self.perform(rate: value, completionBlock: nil)
        }
    }
        
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup(withData orderData: OrderData) {
        self.orderData = orderData
        
        self.productImage.setImage(image: orderData.product_details?.image, placeholder: UIImage(named: "dispensaryPlaceholder"))
        
        nameLabel.text = orderData.product_details?.product_name
        titleLabel.text = orderData.product_details?.brand_name
        priceLabel.text = "$\(orderData.product_details?.price ?? String())"
        ratingView.rating = Double(orderData.rating ?? .zero)
    }
    
    func perform(rate rating: Double, completionBlock: (()->Void)?) {
        
        ActivityIndicator.sharedInstance.showActivityIndicator()
        
        let parameter: [String: Any] = [
            "dispensarys_id": 20,
            "product_id": orderData?.product_details?.product_id ?? .zero,
            "rating": rating
        ]
        
        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(ApiConstant.addRating, params: parameter, headers: ["Authorization": "Bearer \(AppDefaults.token ?? "")"], success: { (response0) in
            
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            print(response0)
            
            if let parsedData = try? JSONSerialization.data(withJSONObject: response0, options: .prettyPrinted) {
                if let orderModal = DataDecoder.decodeData(parsedData, type: MyOrderData.self) {
                    if orderModal.status == 200 {
                        /*Budtender.showAlertMessage(title: ApiConstant.appName, message: userModel?.message ?? "", okButton: "OK", controller: self) {
                         self.navigationController?.popViewController(animated: true)
                         }*/
                        completionBlock?()
                    } else {
                        
                        self.ratingView.rating = Double(self.orderData?.rating ?? .zero)
                        Singleton.shared.showErrorMessage(error:  response0["message"] as? String ?? "", isError: .error)
                        completionBlock?()
                    }
                }
            }
            
        }, failure: { (error) in
            
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            Singleton.shared.showErrorMessage(error:  error.localizedDescription, isError: .error)
            completionBlock?()
        })
    }
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func rateDispensaryAction(_ sender: UIButton) {
        if let indexPath = self.indexPath {
            self.delegate?.didTaprateDispensaryButton(indexPath)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //------------------------------------------------------
}
