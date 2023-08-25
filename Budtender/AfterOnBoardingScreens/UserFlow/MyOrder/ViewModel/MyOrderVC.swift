//
//  MyOrderVC.swift
//  Budtender
//
//  Created by apple on 21/08/23.
//

import UIKit
class MyOrderVC: UIViewController {
    
    @IBOutlet weak var myOrderTableView: UITableView!
    var rating = 0
    var selectedIndex:[IndexPath] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myOrderTableView.delegate = self
        self.myOrderTableView.dataSource = self
        self.myOrderTableView.register(UINib(nibName: "MyOrderTVCell", bundle: nil), forCellReuseIdentifier: "MyOrderTVCell")
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension MyOrderVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderTVCell", for: indexPath) as! MyOrderTVCell
        if indexPath.row == 1{
            cell.contentView.backgroundColor = .white
        }
        if indexPath == self.selectedIndex.first{
            cell.ratingView.rating = Double(self.rating)
        }
        cell.delegate = self
        return cell
    }
}
extension MyOrderVC: MyOrderTVCellDelegate{
    func didTaprateDispensaryButton(_ indexPath: IndexPath) {
        self.selectedIndex = []
        let vc = RatingVC()
        vc.completion = { rating in
            self.rating = rating
            self.selectedIndex.append(indexPath)
            self.myOrderTableView.reloadRows(at: self.selectedIndex, with: .none)
        }
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    }
    
