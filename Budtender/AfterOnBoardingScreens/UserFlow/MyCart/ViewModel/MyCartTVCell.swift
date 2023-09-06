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
        self.delegate?.didTapMinusBtn(button: minusButton)
    }
    
    @IBAction func plusAction(_ sender: UIButton) {
        self.delegate?.didTapPlusBtn(button: plusButton)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
