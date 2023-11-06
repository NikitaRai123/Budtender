//
//  MyOrderVC.swift
//  Budtender
//
//  Created by apple on 21/08/23.
//

import UIKit

class MyOrderVC: UIViewController {
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Outlets
    
    @IBOutlet weak var myOrderTableView: UITableView!
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Variables
    
    var rating = 0
    var selectedIndex:[IndexPath] = []
    var orders: [OrderData] = []
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func performOrderList() {
        
        ActivityIndicator.sharedInstance.showActivityIndicator()
        
        let parameter: [String: Any] = [
            "limit": 20,
            "page": 1
        ]
        
        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(ApiConstant.orderList, params: parameter, headers: ["Authorization": "Bearer \(AppDefaults.token ?? "")"], success: { (response0) in
            
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            
            if let parsedData = try? JSONSerialization.data(withJSONObject: response0, options: .prettyPrinted) {
                let userModel = try? JSONDecoder().decode(ApiResponseModel<[OrderData]>.self, from: parsedData)
                if userModel?.status == 200 {
                    /*Budtender.showAlertMessage(title: ApiConstant.appName, message: userModel?.message ?? "", okButton: "OK", controller: self) {
                        self.navigationController?.popViewController(animated: true)
                    }*/
                    self.orders = userModel?.data ?? []
                    self.myOrderTableView.reloadData()
                    
                } else {
                    Singleton.shared.showErrorMessage(error:  response0["message"] as? String ?? "", isError: .error)
                }
            }
            
        }, failure: { (error) in
            
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            Singleton.shared.showErrorMessage(error:  error.localizedDescription, isError: .error)
        })
    }
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myOrderTableView.delegate = self
        self.myOrderTableView.dataSource = self
        self.myOrderTableView.register(UINib(nibName: "MyOrderTVCell", bundle: nil), forCellReuseIdentifier: "MyOrderTVCell")
        
        DispatchQueue.main.async {
            self.performOrderList()
        }
    }
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
       self.navigationController?.popViewController(animated: true)
    }
}

//-------------------------------------------------------------------------------------------------------

//MARK: ExtensionsTableView

extension MyOrderVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderTVCell", for: indexPath) as! MyOrderTVCell
        /*if indexPath.row == 1{
            cell.contentView.backgroundColor = .white
        }
        let order = orders[indexPath.row]
        cell.setup(withData: order)
        if indexPath == self.selectedIndex.first {
            cell.ratingView.rating = Double(self.rating)
        }*/
        let order = orders[indexPath.row]
        cell.setup(withData: order)
        cell.delegate = self
        return cell
    }
}

//-------------------------------------------------------------------------------------------------------

//MARK: ButtonActionFromProtocolDelegate

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
    
