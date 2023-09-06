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
