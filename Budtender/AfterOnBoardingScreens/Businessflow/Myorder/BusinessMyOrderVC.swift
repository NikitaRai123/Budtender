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
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var pendingLabel: UILabel!
    @IBOutlet weak var rejectedLabel: UILabel!
    @IBOutlet weak var completedLineLabel: UILabel!
    @IBOutlet weak var pendingLineLabel: UILabel!
    @IBOutlet weak var rejectedLineLabel: UILabel!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var pendingButton: UIButton!
    @IBOutlet weak var rejectedButton: UIButton!
    
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Variables
    
    var rating = 0
    var selectedIndex:[IndexPath] = []
    var orders: [OrderData] = []
    lazy var refresher = IQPullToRefresh(scrollView: myOrderTableView, refresher: self, moreLoader: self)
    var currentPage: Int = 1
    var type: String = "1"
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func performOrderList(ofPage page: Int, isLoaderNeeded: Bool = false, completionBlock: @escaping()->Void) {
            
        if isLoaderNeeded {
            ActivityIndicator.sharedInstance.showActivityIndicator()
        }
        
        let parameter: [String: Any] = [
            "type": self.type,
            "limit": 20,
            "page": page
        ]
        
        var apiname: String = String()
        
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            apiname = ApiConstant.businessOrderListV2
        } else {
            apiname = ApiConstant.orderList
        }
        
        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(apiname, params: parameter, headers: ["Authorization": "Bearer \(UserDefaultsCustom.getUserData()?.auth_token ?? "")"], success: { (response0) in
            
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
                        self.myOrderTableView.reloadData()
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
    
    
    func hitCompletedRejectedApi(orderId: String, type: String) {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        let params :[String:Any] = [
            "order_id"   : orderId,
            "type"   : type
        ]
        print("parameters:-  \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.addOrderstatus, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce in Home screen : \(response)")
                if succeeded == true {
                    self.showMessage(message: response["message"] as? String ?? "" , isError: .success)
                    DispatchQueue.main.async {
                        self.performOrderList(ofPage: self.currentPage, isLoaderNeeded: true) {
                        }
                    }
                } else {
                    self.showMessage(message: response["message"] as? String ?? "" , isError: .error)
                }
            }
        }
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
        self.setCompletedButton(isSelected: true)
        self.setPendingButton(isSelected: false)
        self.setRejectedButton(isSelected: false)

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
    
    func setCompletedButton(isSelected: Bool) {
        self.completedButton.isSelected = isSelected
        self.completedLabel.textColor = isSelected ? .black : .lightGray
        self.completedLineLabel.backgroundColor = isSelected ? #colorLiteral(red: 0.253179878, green: 0.2832922339, blue: 0.1949392855, alpha: 1) : .clear
    }
    
    
    func setPendingButton(isSelected: Bool) {
        self.pendingButton.isSelected = isSelected
        self.pendingLabel.textColor = isSelected ? .black : .lightGray
        self.pendingLineLabel.backgroundColor = isSelected ? #colorLiteral(red: 0.253179878, green: 0.2832922339, blue: 0.1949392855, alpha: 1) : .clear
    }
    
    
    func setRejectedButton(isSelected: Bool) {
        self.rejectedButton.isSelected = isSelected
        self.rejectedLabel.textColor = isSelected ? .black : .lightGray
        self.rejectedLineLabel.backgroundColor = isSelected ? #colorLiteral(red: 0.253179878, green: 0.2832922339, blue: 0.1949392855, alpha: 1) : .clear
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Actions
    
    
    @IBAction func completedButtonAction(_ sender: UIButton) {
        if self.type != "1" {
            self.type = "1"
            self.setCompletedButton(isSelected: true)
            self.setPendingButton(isSelected: false)
            self.setRejectedButton(isSelected: false)
            self.orders.removeAll()
            DispatchQueue.main.async {
                self.performOrderList(ofPage: self.currentPage, isLoaderNeeded: true) {
                }
            }
        }
    }
    
    
    @IBAction func pendingButtonAction(_ sender: UIButton) {
        if self.type != "2" {
            self.type = "2"
            self.setPendingButton(isSelected: true)
            self.setCompletedButton(isSelected: false)
            self.setRejectedButton(isSelected: false)
            self.orders.removeAll()
            DispatchQueue.main.async {
                self.performOrderList(ofPage: self.currentPage, isLoaderNeeded: true) {
                }
            }
        }
    }
    
    
    @IBAction func rejectedButtonAction(_ sender: UIButton) {
        if self.type != "3" {
            self.type = "3"
            self.setRejectedButton(isSelected: true)
            self.setPendingButton(isSelected: false)
            self.setCompletedButton(isSelected: false)
            self.orders.removeAll()
            DispatchQueue.main.async {
                self.performOrderList(ofPage: self.currentPage, isLoaderNeeded: true) {
                }
            }
        }
    }
    
    
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
        cell.setup(withData: order, type: self.type)
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
    func didTappedCompletedRejected(orderId: String, type: String) {
        self.hitCompletedRejectedApi(orderId: orderId, type: type)
    }
    
    
    func didTaprateDispensaryButton(_ indexPath: IndexPath) {
    }
}
    
