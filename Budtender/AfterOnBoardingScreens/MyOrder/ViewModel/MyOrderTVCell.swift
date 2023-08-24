//
//  MyOrderTVCell.swift
//  Budtender
//
//  Created by apple on 21/08/23.
//

import UIKit
import Cosmos
protocol MyOrderTVCellDelegate: NSObjectProtocol {
    func didTaprateDispensaryButton(_ indexPath: IndexPath)
}
class MyOrderTVCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rateDispensaryButton: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    
    var delegate: MyOrderTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    @IBAction func rateDispensaryAction(_ sender: UIButton) {
        if let indexPath = self.indexPath {
            self.delegate?.didTaprateDispensaryButton(indexPath)
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
