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
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func ApplyCouponArrowAction(_ sender: UIButton) {
        self.delegate?.didTapapplyCouponButton(button: applyCouponButton, label: applyCouponLabel, view: discountView)
    }
}
