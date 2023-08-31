//
//  DeletePopUpVC.swift
//  Budtender
//
//  Created by apple on 29/08/23.
//

import UIKit
class DeletePopUpVC: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func crossAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func yesAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func noAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
