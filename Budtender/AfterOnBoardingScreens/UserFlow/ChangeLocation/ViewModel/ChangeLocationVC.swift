//
//  ChangeLocationVC.swift
//  Budtender
//
//  Created by apple on 10/08/23.
//

import UIKit

class ChangeLocationVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var crossButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateCrossButtonVisibility()
    }
    func updateCrossButtonVisibility() {
        crossButton.isHidden = false
        crossButton.isHidden = txtSearch.text?.isEmpty ?? true
    }

    @IBAction func crossAction(_ sender: UIButton) {
        txtSearch.text = ""
        crossButton.isHidden = true
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
