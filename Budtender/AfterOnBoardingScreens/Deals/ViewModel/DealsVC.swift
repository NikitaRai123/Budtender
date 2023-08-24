//
//  DealsVC.swift
//  Budtender
//
//  Created by apple on 24/08/23.
//

import UIKit
class DealsVC: UIViewController {

    @IBOutlet weak var dealsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dealsTableView.delegate = self
        self.dealsTableView.dataSource = self
        self.dealsTableView.register(UINib(nibName: "DealsTVCell", bundle: nil), forCellReuseIdentifier: "DealsTVCell")
           }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension DealsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DealsTVCell", for: indexPath) as! DealsTVCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DealsDetailVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
