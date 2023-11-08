//
//  MyOrderDetailVC.swift
//  Budtender
//
//  Created by apple on 29/08/23.
//

import UIKit
class MyOrderDetailVC: UIViewController {
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var orderData: OrderData?
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
        self.detailTableView.register(UINib(nibName: "MyOrderDetailTVCell", bundle: nil), forCellReuseIdentifier: "MyOrderDetailTVCell")
        setTableFooter()
    }
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: TableFooter
    
    /*private func setTableFooter() {
        DispatchQueue.main.async { [self] in
            guard let footer = UINib(nibName: "MyCartFooterView", bundle: nil).instantiate(withOwner: self, options: nil).first as? MyCartFooterView else{return}
                footer.backgroundColor = .clear
               // footer.pickUpDetailStackHeight.constant = 0
                footer.frame = CGRect(x: 0, y: 0, width: self.detailTableView.frame.width, height: 480)
                self.detailTableView.tableFooterView = footer
        }
    }*/
    
    private func setTableFooter() {
        
        DispatchQueue.main.async { [self] in
            
            guard let footer = UINib(nibName: "MyCartFooterView", bundle: nil).instantiate(withOwner: self, options: nil).first as? MyCartFooterView else{return}
            footer.backgroundColor = .clear
            
            //footer.delegate = self
            if let orderData = orderData {
                footer.setup(orderData: orderData)
            }
            
            /*footer.pickUpDetailStackView.isHidden = false
            footer.pickUpDetailStackHeight.constant = 0
            footer.pickupFilledupView.isHidden = true
            footer.discountView.isHidden = false*/
            
            footer.pickUpDetailStackView.isHidden = false
            footer.pickUpDetailStackHeight.constant = 180
            footer.pickupFilledupView.isHidden = false
            footer.discountView.isHidden = false
            
            let name = orderData?.pickup_details?.name ?? String()
            let birthdate = orderData?.pickup_details?.birthday ?? String()
            let phone = orderData?.pickup_details?.phoneNumber ?? String()
            let time = orderData?.pickup_details?.pickupTime ?? String()
            let image = orderData?.pickup_details?.image ?? String()
            
            footer.setup(pickup: name, birthdate: birthdate, phone: phone, time: time, image: image)
            footer.frame = CGRect(x: 0, y: 0, width: self.detailTableView.frame.width, height: 480)
                            
            // footer.applyCouponLabel.text = UserDefaults.standard.string(forKey: "couponCodeKey")
            //footer.applyCouponButton.setImage(UIImage(named: UserDefaults.standard.string(forKey: "imageNameKey") ?? ""), for: .normal)
            
            self.detailTableView.reloadData()
            self.detailTableView.tableFooterView = footer
        }
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Action
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//-------------------------------------------------------------------------------------------------------

//MARK: ExtensionTableView

extension MyOrderDetailVC: UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderDetailTVCell", for: indexPath) as! MyOrderDetailTVCell
        if let orderData = orderData {
            cell.setup(order: orderData)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
