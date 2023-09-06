//
//  ProfileTVCell.swift
//  Budtender
//
//  Created by apple on 11/08/23.
//

import UIKit
protocol ProfileTVCellDelegate: NSObjectProtocol {
    func didTapToggleSwitch(button: UISwitch)
}
class ProfileTVCell: UITableViewCell {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    var delegate: ProfileTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func toggleSwitch(_ sender: UIButton) {
        self.delegate?.didTapToggleSwitch(button: toggleSwitch)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
