//
//  MyOrderDetailVC.swift
//  Budtender
//
//  Created by apple on 29/08/23.
//

import UIKit
class MyOrderDetailVC: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
        self.detailTableView.register(UINib(nibName: "MyOrderDetailTVCell", bundle: nil), forCellReuseIdentifier: "MyOrderDetailTVCell")
        setTableFooter()
    }
    private func setTableFooter() {
        DispatchQueue.main.async { [self] in
            guard let footer = UINib(nibName: "MyCartFooterView", bundle: nil).instantiate(withOwner: self, options: nil).first as? MyCartFooterView else{return}
                footer.backgroundColor = .clear
               // footer.pickUpDetailStackHeight.constant = 0
                footer.frame = CGRect(x: 0, y: 0, width: self.detailTableView.frame.width, height: 480)
                self.detailTableView.tableFooterView = footer
        }
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension MyOrderDetailVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderDetailTVCell", for: indexPath) as! MyOrderDetailTVCell
        return cell
    }
    
    
}
