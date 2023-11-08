//
//  BusinessMyOrderVC.swift
//  Budtender
//
//  Created by apple on 29/08/23.
//

import UIKit
import IQPullToRefresh

class BusinessMyOrderVC: UIViewController, MoreLoadable, Refreshable {
        
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Outlets
    
    @IBOutlet weak var myOrderTableView: UITableView!
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Variables
    
    var rating = 0
    var selectedIndex:[IndexPath] = []
    var orders: [OrderData] = []
    lazy var refresher = IQPullToRefresh(scrollView: myOrderTableView, refresher: self, moreLoader: self)
    var currentPage: Int = 1
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func performOrderList(ofPage page: Int, isLoaderNeeded: Bool = false, completionBlock: @escaping()->Void) {
            
        if isLoaderNeeded {
            ActivityIndicator.sharedInstance.showActivityIndicator()
        }
        
        let parameter: [String: Any] = [
            "limit": 20,
            "page": page
        ]
        
        var apiname: String = String()
        
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            apiname = ApiConstant.businessOrderList
        } else {
            apiname = ApiConstant.orderList
        }
        
        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(apiname, params: parameter, headers: ["Authorization": "Bearer \(AppDefaults.token ?? "")"], success: { (response0) in
            
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            print(response0)
            
            if let parsedData = try? JSONSerialization.data(withJSONObject: response0, options: .prettyPrinted) {
                if let orderModal = DataDecoder.decodeData(parsedData, type: MyOrderData.self) {
                    if orderModal.status == 200 {
                        /*Budtender.showAlertMessage(title: ApiConstant.appName, message: userModel?.message ?? "", okButton: "OK", controller: self) {
                         self.navigationController?.popViewController(animated: true)
                         }*/
                        if page <= 1 {
                            self.orders = orderModal.data ?? []
                        } else {
                            self.orders.append(contentsOf: orderModal.data ?? [])
                            if orderModal.lastPage == false {
                                self.currentPage += 1
                            }
                        }
                        self.myOrderTableView.reloadData()
                        completionBlock()
                    } else {
                        Singleton.shared.showErrorMessage(error:  response0["message"] as? String ?? "", isError: .error)
                        completionBlock()
                    }
                }
            }
            
        }, failure: { (error) in
            
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            Singleton.shared.showErrorMessage(error:  error.localizedDescription, isError: .error)
            completionBlock()
        })
    }
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myOrderTableView.delegate = self
        self.myOrderTableView.dataSource = self
        self.myOrderTableView.register(UINib(nibName: "BusinessMyOrderTVCell", bundle: nil), forCellReuseIdentifier: "BusinessMyOrderTVCell")
        
        refresher.refreshControl.tintColor = .black
        refresher.loadMoreControl.tintColor = .black
        refresher.enablePullToRefresh = true
        refresher.enableLoadMore = true
        
        DispatchQueue.main.async {
            self.performOrderList(ofPage: self.currentPage, isLoaderNeeded: true) {
            }
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Refreshable
    
    func refreshTriggered(type: IQPullToRefresh.RefreshType, loadingBegin: @escaping (Bool) -> Void, loadingFinished: @escaping (Bool) -> Void) {
        let newPage = 1
        loadingBegin(true)
        self.performOrderList(ofPage: newPage) {
            loadingFinished(true)
        }
    }
    
    //------------------------------------------------------
    
    //MARK: MoreLoadable
    
    func loadMoreTriggered(type: IQPullToRefresh.LoadMoreType, loadingBegin: @escaping (Bool) -> Void, loadingFinished: @escaping (Bool) -> Void) {
        
        let newPage = currentPage + 1
        loadingBegin(true)
        self.performOrderList(ofPage: newPage) {
            loadingFinished(true)
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

extension BusinessMyOrderVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessMyOrderTVCell", for: indexPath) as! BusinessMyOrderTVCell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let order = orders[indexPath.row]
        let vc = MyOrderDetailVC()
        vc.orderData = order
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//-------------------------------------------------------------------------------------------------------

//MARK: ButtonActionFromProtocolDelegate

extension BusinessMyOrderVC: BusinessOrderTVCellDelegate {
    
    func didTaprateDispensaryButton(_ indexPath: IndexPath) {
    }
}
    
