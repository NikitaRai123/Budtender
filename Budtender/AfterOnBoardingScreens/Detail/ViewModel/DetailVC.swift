//
//  DetailVC.swift
//  Budtender
//
//  Created by apple on 10/08/23.
//

import UIKit
class DetailVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var openTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
                } else {
                    automaticallyAdjustsScrollViewInsets = false
                }
        openTimeLabel.setAttributed(str1: "Open now", font1: UIFont.setCustom(.Poppins_Regular, 13), color1: .gray, str2:  " - 10am – 8pm (Today)", font2: UIFont.setCustom(.Poppins_Regular, 13), color2: .gray)

    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @IBAction func phoneAction(_ sender: UIButton) {
    }
    
    @IBAction func viewOnMapAction(_ sender: UIButton) {
    }
    
    @IBAction func viewAllAction(_ sender: UIButton) {
    }
    

}
