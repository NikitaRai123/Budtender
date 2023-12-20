//
//  MyOrderVC.swift
//  Budtender
//
//  Created by apple on 21/08/23.
//

import UIKit
import IQPullToRefresh
import GoogleMobileAds

class MyOrderVC: UIViewController, MoreLoadable, Refreshable {
        
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Outlets
    
    @IBOutlet weak var myOrderTableView: UITableView!
    @IBOutlet weak var topAdsView: UIView!
    @IBOutlet weak var bottomAdsView: UIView!
    @IBOutlet weak var noRecordsFound: UILabel!
    
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
    lazy var refresher = IQPullToRefresh(scrollView: myOrderTableView, refresher: self, moreLoader: self)
    var currentPage: Int = 1
    var bannerView: GADBannerView!
    var secondBannerView: GADBannerView!

    
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
        self.loadAdsView()
        self.myOrderTableView.delegate = self
        self.myOrderTableView.dataSource = self
        self.myOrderTableView.register(UINib(nibName: "MyOrderTVCell", bundle: nil), forCellReuseIdentifier: "MyOrderTVCell")
        
        refresher.refreshControl.tintColor = .black
        refresher.loadMoreControl.tintColor = .black
        refresher.enablePullToRefresh = true
        refresher.enableLoadMore = true
        noRecordsFound.font = UIFont(FONT_NAME.Poppins_Regular, noRecordsFound.font.pointSize)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.performOrderList(ofPage: self.currentPage, isLoaderNeeded: true) {
            }
        }
    }
    
    
    func loadAdsView() {
        let adSize = GADAdSizeFromCGSize(CGSize(width: UIScreen.main.bounds.width, height: 50))
        bannerView = GADBannerView(adSize: adSize)
        bannerView.delegate = self
        secondBannerView = GADBannerView(adSize: adSize)
        secondBannerView.delegate = self
        addBannerViewToView(bannerView)
        addSecondBannerViewToView(secondBannerView)
    }
    
    //MARK:- add Banner to view
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        topAdsView.addSubview(bannerView)
    }
    
    func addSecondBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bottomAdsView.addSubview(bannerView)
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
    func didTaprateDispensaryButton(orderData: OrderData?) {
        let vc = RatingVC()
        vc.orderData = orderData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
//    func didTaprateDispensaryButton(_ indexPath: IndexPath) {
//        
//        self.selectedIndex = []
//        let vc = RatingVC()
////        vc.rating = self
//        vc.completion = { rating in
//            self.rating = rating
//            self.selectedIndex.append(indexPath)
//            self.myOrderTableView.reloadRows(at: self.selectedIndex, with: .none)
//        }
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}
    

//MARK:- Banner Delegate  Method(s)
extension MyOrderVC: GADBannerViewDelegate{
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
        print("banner loaded")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
}

