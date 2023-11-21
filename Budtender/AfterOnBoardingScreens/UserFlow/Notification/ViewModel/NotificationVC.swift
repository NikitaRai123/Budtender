//
//  NotificationVC.swift
//  Budtender
//
//  Created by apple on 21/08/23.
//

import UIKit
import IQPullToRefresh

class NotificationVC: UIViewController, MoreLoadable, Refreshable {
        
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Outlets
    
    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var noRecordsFound: UILabel!
    
    var notifications: [NotificationElement] = []
        
    //-------------------------------------------------------------------------------------------------------
    //MARK: Variables
    
    var rating = 0
    var selectedIndex:[IndexPath] = []
    var orders: [OrderData] = [] {
        didSet {
            guard noRecordsFound != nil else { return }
            noRecordsFound.isHidden = orders.count != .zero
        }
    }
    lazy var refresher = IQPullToRefresh(scrollView: notificationTableView, refresher: self, moreLoader: self)
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
        
        if "business" == currentLoginType {
            apiname = ApiConstant.getNotificationList
        }
        
        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(apiname, params: parameter, headers: ["Authorization": "Bearer \(AppDefaults.token ?? "")"], success: { (response0) in
            
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            print(response0)
            
            if let parsedData = try? JSONSerialization.data(withJSONObject: response0, options: .prettyPrinted) {
                if let orderModal = DataDecoder.decodeData(parsedData, type: NotificationList.self) {
                    if orderModal.status == 200 {
                        /*Budtender.showAlertMessage(title: ApiConstant.appName, message: userModel?.message ?? "", okButton: "OK", controller: self) {
                         self.navigationController?.popViewController(animated: true)
                         }*/
                        if page <= 1 {
                            self.notifications = orderModal.data ?? []
                        } else {
                            self.notifications.append(contentsOf: orderModal.data ?? [])
                            if orderModal.lastPage == false {
                                self.currentPage += 1
                            }
                        }
                        if self.notifications.count > 0 {
                            self.noRecordsFound.isHidden = true
                        } else {
                            self.noRecordsFound.isHidden = false
                        }
                        self.notificationTableView.reloadData()
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
        
        self.notificationTableView.delegate = self
        self.notificationTableView.dataSource = self
        self.notificationTableView.register(UINib(nibName: "NotificationTVCell", bundle: nil), forCellReuseIdentifier: "NotificationTVCell")
        
        refresher.refreshControl.tintColor = .black
        refresher.loadMoreControl.tintColor = .black
        refresher.enablePullToRefresh = true
        refresher.enableLoadMore = true
        noRecordsFound.font = UIFont(FONT_NAME.Poppins_Regular, noRecordsFound.font.pointSize)
        
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

extension NotificationVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTVCell", for: indexPath) as! NotificationTVCell
        let notification = notifications[indexPath.row]
        cell.setup(notification: notification)
        return cell
    }
}
    
