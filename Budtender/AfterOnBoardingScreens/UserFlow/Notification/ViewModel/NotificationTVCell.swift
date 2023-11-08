//
//  NotificationTVCell.swift
//  Budtender
//
//  Created by apple on 21/08/23.
//

import UIKit
import SDWebImage

class NotificationTVCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func setup(notification notificationData: NotificationElement) {
        
        profileImage.setImage(image: notificationData.image, placeholder: UIImage(named: "dispensaryPlaceholder"))
        titleLabel.text = notificationData.description
        timeLabel.text = notificationData.created
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
