//
//  ProfileTVCell.swift
//  Budtender
//
//  Created by apple on 11/08/23.
//

import UIKit

class ProfileTVCell: UITableViewCell {
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var toggleSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
