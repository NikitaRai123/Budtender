//
//  DeletePopUpVC.swift
//  Budtender
//
//  Created by apple on 29/08/23.
//

import UIKit
protocol DeletePopUpVCDelegate{
    func delete(dispensaryID: Int)
}

class DeletePopUpVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var dispensaryID: Int?
    var delegate: DeletePopUpVCDelegate?
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dispensaryID)
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func crossAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func yesAction(_ sender: UIButton) {
//        dismiss(animated: true)
        self.delegate?.delete(dispensaryID: dispensaryID ?? 0 )
    }
    
    @IBAction func noAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
