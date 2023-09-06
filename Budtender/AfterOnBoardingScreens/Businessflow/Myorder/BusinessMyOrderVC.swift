//
//  BusinessMyOrderVC.swift
//  Budtender
//
//  Created by apple on 29/08/23.
//

import UIKit
class BusinessMyOrderVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var myOrderTableView: UITableView!
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.myOrderTableView.delegate = self
        self.myOrderTableView.dataSource = self
        self.myOrderTableView.register(UINib(nibName: "BusinessMyOrderTVCell", bundle: nil), forCellReuseIdentifier: "BusinessMyOrderTVCell")
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
//-------------------------------------------------------------------------------------------------------
//MARK: ExtensionTableView

extension BusinessMyOrderVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessMyOrderTVCell", for: indexPath) as! BusinessMyOrderTVCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MyOrderDetailVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
