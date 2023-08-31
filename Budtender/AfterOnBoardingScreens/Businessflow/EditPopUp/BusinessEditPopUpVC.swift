//
//  BusinessEditPopUpVC.swift
//  Budtender
//
//  Created by apple on 28/08/23.
//

import UIKit
protocol BusinessEditPopUpVCDelegate: NSObjectProtocol {
    func didTapeditButton(_ button: UIButton)
    func didTapdeleteButton(_ button: UIButton)
    func didTapcancelbutton(_ button: UIButton)
}
class BusinessEditPopUpVC: UIViewController {
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cancelbutton: UIButton!
    
    var delegate: BusinessEditPopUpVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func cancelAction(_ sender: UIButton) {
            self.delegate?.didTapcancelbutton(cancelbutton)
        
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        self.delegate?.didTapeditButton(editButton)
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        self.delegate?.didTapdeleteButton(deleteButton)
    }
}
