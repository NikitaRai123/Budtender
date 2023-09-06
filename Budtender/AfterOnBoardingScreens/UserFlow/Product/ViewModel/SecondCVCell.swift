//
//  SecondCVCell.swift
//  Budtender
//
//  Created by apple on 11/08/23.
//

import UIKit
class SecondCVCell: UICollectionViewCell {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.bgView.shadowRadius = 4
        self.bgView.shadowOpacity = 0.5
        self.bgView.shadowOffset = CGSize(width: 0, height: 0)
        self.bgView.shadowColor = .gray
       
    }

}
