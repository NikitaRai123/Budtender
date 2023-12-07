//
//  MyCartFooterView.swift
//  Budtender
//
//  Created by apple on 18/08/23.
//

import UIKit
import SDWebImage

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
    @IBOutlet weak var pickupFilledupView: UIView!
    
    var delegate: MyCartFooterViewDelegate?
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func prepareOrderSummary(fromProduct product: ProductSubCategoryData, dealcode: String?) -> (productId: String, qty: String, totalAmount: Double, discount: Double) {
        
        let product_id = String(product.product_id ?? .zero)
        let qty = product.count ?? String()
        //let totalAmount = (Double(product.price ?? String()) ?? .zero) * (Double(qty) ?? .zero)
        //let discount = (((Double(dealcode ?? String()) ?? 1)/100) * totalAmount)
        let totalAmount = (Double(product.price ?? String()) ?? .zero)
        let discount = (Double(dealcode ?? String()) ?? .zero)
        return (product_id, qty, totalAmount, discount)
    }
    
    func prepareOrderSummary(fromOrder product: ProductDetailData, dealcode: String?) -> (productId: String, qty: String, totalAmount: Double, discount: Double) {
        
        let product_id = String(product.product_id ?? .zero)
        let qty = product.qty ?? String()
        //let totalAmount = (Double(product.price ?? String()) ?? .zero) * (Double(qty) ?? .zero)
        //let discount = (((Double(dealcode ?? String()) ?? 1)/100) * totalAmount)
        let totalAmount = (Double(product.price ?? String()) ?? .zero)
        let discount = (Double(dealcode ?? String()) ?? .zero)
        return (product_id, qty, totalAmount, discount)
    }

    func prepareOrderSummary(fromMyOrder order: OrderData, dealcode: String?) -> (productId: String, qty: String, totalAmount: Double, discount: Double) {
        let product = order.product_details
        let product_id = String(product?.product_id ?? .zero)
        let qty = product?.qty ?? String()
        //let totalAmount = (Double(product.price ?? String()) ?? .zero) * (Double(qty) ?? .zero)
        //let discount = (((Double(dealcode ?? String()) ?? 1)/100) * totalAmount)
        let totalAmount = (Double(order.total_amount ?? "") ?? 0.0)
        let discount = (Double(order.discount_amount ?? .zero))
        return (product_id, qty, totalAmount, discount)
    }
    
    func setup(product: ProductSubCategoryData, dealcode: String) {
        let (productId, qty, totalAmount, discount) = prepareOrderSummary(fromProduct: product, dealcode: dealcode)
        debugPrint(productId)
        debugPrint(qty)
        let subTotal = totalAmount * (Double(qty) ?? 1)
        subtotalAmountLabel.text = String("$\(subTotal)")
        //discountAmountLabel.text = String("\(discount)%")
        discountAmountLabel.text = String("\(dealcode)%")
        totalAmountLabel.text = String("$\(subTotal - (subTotal * (discount/100)))")
    }
   
    func setup(orderData: OrderData) {
        
        guard let product_details = orderData.product_details else { return }
        let dealcode = orderData.pickup_details?.dealCode ?? String("0")
        
//        let (productId, qty, totalAmount, discount) = prepareOrderSummary(fromOrder: product_details, dealcode: dealcode)
        let (productId, qty, totalAmount, discount) = prepareOrderSummary(fromMyOrder: orderData, dealcode: dealcode)

        debugPrint(productId)
        debugPrint(qty)
        subtotalAmountLabel.text = String("$\(totalAmount)")
        //discountAmountLabel.text = String("\(discount)%")
        discountAmountLabel.text = String("\(discount)%")
        totalAmountLabel.text = String("$\(totalAmount - discount)")

//        totalAmountLabel.text = String("$\(totalAmount - (totalAmount * (discount/100)))")
    }
   
    
    func setup(pickup name: String, birthdate: String, phone:String, time: String, image: UIImage) {
        nameLabel.text = name
        birthdayLabel.text = birthdate
        phoneNumberLabel.text = phone
        timeLabel.text = time
        userIdImage.image = image
    }
    
    func setup(pickup name: String, birthdate: String, phone:String, time: String, image: String) {
        nameLabel.text = name
        birthdayLabel.text = birthdate
        phoneNumberLabel.text = phone
        timeLabel.text = time
        userIdImage.setImage(image: image, placeholder: UIImage(named: "dispensaryPlaceholder"))
    }
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func ApplyCouponArrowAction(_ sender: UIButton) {
        self.delegate?.didTapapplyCouponButton(button: applyCouponButton, label: applyCouponLabel, view: discountView)
    }
    
    //------------------------------------------------------
}
