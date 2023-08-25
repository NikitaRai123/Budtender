//
//  TermAndConditionVC.swift
//  Budtender
//
//  Created by apple on 25/08/23.
//

import UIKit
import WebKit
class TermAndConditionVC: UIViewController {
    
    @IBOutlet weak var termAndconditionWebView: WKWebView!
    @IBOutlet weak var termAndconditionLabel: UILabel!
    
    var comeFrom:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        termAndconditionLabel.text = comeFrom
        termAndconditionWebView.load(NSURLRequest(url: NSURL(string: "https://www.google.com/")! as URL) as URLRequest)
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
