//
//  HomeVC.swift
//  Budtender
//
//  Created by apple on 09/08/23.
//

import UIKit
import MapKit
import SideMenu

class HomeVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var homeTableView: UITableView!
    var selectedIndex:Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.homeTableView.register(UINib(nibName: "HomeTVCell", bundle: nil), forCellReuseIdentifier: "HomeTVCell")
    }

    @IBAction func sideBarAction(_ sender: UIButton) {
    let vc = ProfileVC()
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.leftSide = true
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = UIScreen.main.bounds.width - 80
        menu.blurEffectStyle = UIBlurEffect.Style.dark
        present(menu, animated: true, completion: nil)
    }
    
    @IBAction func locationAction(_ sender: UIButton) {
        let vc = LocationVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        let vc = SearchVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension HomeVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVCell", for: indexPath) as! HomeTVCell
        if indexPath.row == self.selectedIndex{
                cell.bgView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 1, blue: 0.9450980392, alpha: 1)
            }else{
                cell.bgView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        if indexPath.row == 1{
            cell.closedButton.setTitle("   Open Now   ", for: .normal)
            cell.closedButton.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2980392157, blue: 0.1725490196, alpha: 1)
        }else{
            cell.closedButton.setTitle("   Closed   ", for: .normal)
            cell.closedButton.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.01176470588, blue: 0.01176470588, alpha: 1)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [self] in
            let vc = DetailVC()
            self.navigationController?.pushViewController(vc, animated: true)
           
        }
        homeTableView.reloadData()
    }
}
