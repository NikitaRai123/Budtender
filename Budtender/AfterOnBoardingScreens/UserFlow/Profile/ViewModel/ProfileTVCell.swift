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
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    var delegate: ProfileTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    @IBAction func toggleSwitch(_ sender: UIButton) {
        self.delegate?.didTapToggleSwitch(button: toggleSwitch)
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            toggleSwitch.isOn = true
        }else{
            toggleSwitch.isOn = false
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
