//
//  MyCartFooterView.swift
//  Budtender
//
//  Created by apple on 18/08/23.
//

import UIKit

protocol MyCartFooterViewDelegate: NSObjectProtocol {
    func didTapapplyCouponButton(button: UIButton,label:UILabel, view:UIView)
}

class MyCartFooterView: UIView {
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var pickUpDetailStackView: UIStackView!
    @IBOutlet weak var pickUpDetailStackHeight: NSLayoutConstraint!
    @IBOutlet weak var userIdImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var applyCouponLabel: UILabel!
    @IBOutlet weak var applyCouponButton: UIButton!
    @IBOutlet weak var subtotalAmountLabel: UILabel!
    @IBOutlet weak var discountAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var discountView: UIView!
    
    var delegate: MyCartFooterViewDelegate?
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func prepareOrderSummary(fromProduct product: ProductSubCategoryData, dealcode: String?) -> (productId: String, qty: String, totalAmount: Double, discount: Double) {
        
        let product_id = String(product.product_id ?? .zero)
        let qty = product.qty ?? String()
        let totalAmount = (Double(product.price ?? String()) ?? .zero) * (Double(qty) ?? .zero)
        let discount = (((Double(dealcode ?? String()) ?? 1)/100) * totalAmount)
        return (product_id, qty, totalAmount, discount)
    }
    
    func setup(product: ProductSubCategoryData, dealcode: String) {
        let (productId, qty, totalAmount, discount) = prepareOrderSummary(fromProduct: product, dealcode: dealcode)
        debugPrint(productId)
        subtotalAmountLabel.text = String(totalAmount)
        discountAmountLabel.text = String(discount)
        totalAmountLabel.text = String(totalAmount - discount)
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func ApplyCouponArrowAction(_ sender: UIButton) {
        self.delegate?.didTapapplyCouponButton(button: applyCouponButton, label: applyCouponLabel, view: discountView)
    }
    
    //------------------------------------------------------
}
