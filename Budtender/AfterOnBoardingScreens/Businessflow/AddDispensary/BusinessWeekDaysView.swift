//
//  BusinessWeekDaysView.swift
//  Budtender
//
//  Created by apple on 30/08/23.
//

import UIKit
class BusinessWeekDaysView: UIView , UITextFieldDelegate{
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBOutlet weak var txtOpen: UITextField!
    @IBOutlet weak var txtClose: UITextField!
    @IBOutlet weak var openCloseView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        commitInit()
    }
    private func commitInit(){
        Bundle.main.loadNibNamed("BusinessWeekDaysView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    func switchOn() {
        self.statusLabel.text = "Open"
        self.openCloseView.isHidden = false
        self.txtOpen.isUserInteractionEnabled = true
        //self.closedTF.isHidden = false
        self.txtClose.isUserInteractionEnabled = true
    }
    
        func switchOff() {
        self.statusLabel.text = "Closed"
        self.openCloseView.isHidden = true
        self.txtOpen.isUserInteractionEnabled = false
        //self.closedTF.isHidden = true
        self.txtClose.isUserInteractionEnabled = false
    }

    @IBAction func toggleAction(_ sender: UISwitch) {
        if toggleSwitch.isOn == true {
            switchOn()
        } else {
            switchOff()
            txtOpen.text = ""
            txtClose.text = ""
        }
    }
   
}



