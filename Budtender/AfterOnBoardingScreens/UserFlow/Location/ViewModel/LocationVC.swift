//
//  LocationVC.swift
//  Budtender
//
//  Created by apple on 09/08/23.
//

import UIKit
import MapKit
class LocationVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func useCurrentLocationAction(_ sender: UIButton) {
    }
    
    @IBAction func changeAction(_ sender: UIButton) {
        let vc = ChangeLocationVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func confirmLocationAction(_ sender: UIButton) {
    }
}
