//
//  NotificationVC.swift
//  Budtender
//
//  Created by apple on 21/08/23.
//

import UIKit
class NotificationVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var notificationTableView: UITableView!
    //-------------------------------------------------------------------------------------------------------
    //MARK: Variables
    
    var notification = [("Img_Notification","Brain Cumin You have placed an order for pickup from Dispensary17.","2 min ago"),("Img_Notification","Brain Cumin You have placed an order for pickup from Dispensary17.","2 min ago")]
    var userName = ["Brain Cumin","Brain Cumin"]
    var message = ["You have placed an order for pickup from Dispensary17.","You have placed an order for pickup from Dispensary17."]
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.notificationTableView.delegate = self
        self.notificationTableView.dataSource = self
        self.notificationTableView.register(UINib(nibName: "NotificationTVCell", bundle: nil), forCellReuseIdentifier: "NotificationTVCell")
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: ACtions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
//-------------------------------------------------------------------------------------------------------
//MARK: ExtensionsTableView

extension NotificationVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTVCell", for: indexPath) as! NotificationTVCell
        cell.profileImage.image = UIImage(named: notification[indexPath.row].0)
        cell.titleLabel.text = "\(notification[indexPath.row].1)"
        cell.timeLabel.text = "\(notification[indexPath.row].2)"
        cell.titleLabel.setAttributed(str1: "\(userName[indexPath.row])", font1: UIFont.boldSystemFont(ofSize: 14), color1: .black, str2: "\(message[indexPath.row])", font2: UIFont.setCustom(.Poppins_Light, 14), color2: .black)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
