//
//  PrivacyPolicyVC.swift
//  Budtender
//
//  Created by apple on 09/08/23.
//

import UIKit
import WebKit

class PrivacyPolicyVC: UIViewController {

    @IBOutlet weak var privacyPolicyWebview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        privacyPolicyWebview.load(NSURLRequest(url: NSURL(string: "https://www.google.com/")! as URL) as URLRequest)
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
