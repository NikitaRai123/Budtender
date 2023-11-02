//
//  MyCartTVCell.swift
//  Budtender
//
//  Created by apple on 17/08/23.
//

import UIKit
protocol MyCartTVCellDelegate: NSObjectProtocol {
    func didTapCrossBtn(button: UIButton)
    func didTapMinusBtn(button: UIButton)
    func didTapPlusBtn(button: UIButton)
}
class MyCartTVCell: UITableViewCell {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var imageBgView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var delegate: MyCartTVCellDelegate?
    
    //------------------------------------------------------
    
    //MARK: Customs
        
    var productDetail: ProductSubCategoryData?
    
    func setData(_ productDetail: ProductSubCategoryData) {
        self.productDetail = productDetail
        
        self.productImage.setImage(image: productDetail.image,placeholder: UIImage(named: "dispensaryPlaceholder"))
        self.titleLabel.text = "\(productDetail.product_name ?? "")\("-")\(productDetail.brand_name ?? "")"
        self.countLabel.text = productDetail.qty
        self.priceLabel.text = "\("$")\(productDetail.price ?? "")"
    }
    
    func incrementCount() {
        if let currentCount = Int(self.productDetail?.qty ?? "0") {
            let newCount = currentCount + 1
            self.productDetail?.qty = String(newCount)
            countLabel.text = "\(newCount)"
        }
    }
    
    func decrementCount() {
        // Get the current count from the label
        if let currentCount = Int(self.productDetail?.qty ?? "0") {
            if currentCount > 1 {
                let newCount = currentCount - 1
                self.productDetail?.qty = String(newCount)
                countLabel.text = "\(newCount)"
            }
        }
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
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func crossAction(_ sender: UIButton) {
        self.delegate?.didTapCrossBtn(button: crossButton)
    }
    
    @IBAction func minusAction(_ sender: UIButton) {
        decrementCount()
        self.delegate?.didTapMinusBtn(button: minusButton)
    }
    
    @IBAction func plusAction(_ sender: UIButton) {
        incrementCount()
        self.delegate?.didTapPlusBtn(button: plusButton)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
