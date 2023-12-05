//
//  MyCartVC.swift
//  Budtender
//
//  Created by apple on 17/08/23.
//

import UIKit

class MyCartVC: UIViewController {
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Outlets
    
    @IBOutlet weak var addPickupDetailView: UIView!
    @IBOutlet weak var pickupDetailBgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var myCartTableView: UITableView!
    @IBOutlet weak var noRecordsFound: UILabel!
    @IBOutlet weak var viewPlaceHolderForPickup: UIView!
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Variables
    
    var comeFrom:String?
    var isPickupDetail = true
    var isFromSideMenu = false
    var ProductDetail: ProductSubCategoryData?
    var dealcode: String? = nil
    
    var isRequesting: Bool = false {
        didSet {
            if isRequesting {
                isNoRecordsEnabled(false)
                myCartTableView.isHidden = true
                self.viewPlaceHolderForPickup.isHidden = true
                self.addPickupDetailView.isHidden = true
                self.pickupDetailBgViewHeight.constant = 0
                
            } else {
                
                if ProductDetail != nil {
                    myCartTableView.isHidden = false
                    viewPlaceHolderForPickup.isHidden = false
                    if isPickupDetail {
                        self.addPickupDetailView.isHidden = true
                        self.pickupDetailBgViewHeight.constant = 0
                    } else {
                        addPickupDetailView.isHidden = false
                        pickupDetailBgViewHeight.constant = 40
                    }
                    isNoRecordsEnabled(false)
                } else {
                    isNoRecordsEnabled(true)
                }
                
            }
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Custom
    func isNoRecordsEnabled(_ isEnable: Bool) {
        noRecordsFound.isHidden = !isEnable
    }
    
    func requestForCartListing() {
        
        func setupProductResponseData(_ response: NSDictionary) {
            debugPrint(response)
            if let parsedData = try? JSONSerialization.data(withJSONObject:  response, options: .prettyPrinted){
                do {
                    let result = try JSONDecoder().decode(ApiResponseModel<ProductSubCategoryData>.self, from: parsedData)
                    self.ProductDetail = result.data
                    self.myCartTableView.reloadData()
                    
                } catch {
                    print(error)
                }
            }
        }
        
        func setupPickupResponseData(_ response: NSDictionary) {
            debugPrint(response)
            if let parsedData = try? JSONSerialization.data(withJSONObject:  response, options: .prettyPrinted){
                do {
                    let result = try JSONDecoder().decode(ApiResponseModel<ProductSubCategoryData>.self, from: parsedData)
                    self.ProductDetail = result.data
                    self.myCartTableView.reloadData()
                    
                } catch {
                    print(error)
                }
            }
        }
        
        isRequesting = true
        
        ActivityIndicator.sharedInstance.showActivityIndicator()
        
        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(ApiConstant.cartListing, params: [:], headers: ["Authorization": "Bearer \(UserDefaultsCustom.getUserData()?.auth_token ?? "")"], success: { (response0) in
            print(response0)
            
            AFWrapperClass.sharedInstance.requestPostWithMultiFormData(ApiConstant.userPickupdetails, params: [:], headers: ["Authorization": "Bearer \(UserDefaultsCustom.getUserData()?.auth_token ?? "")"], success: { (response1) in
                print(response1)
                
                self.dealcode = (response1["deal_code"] as? String)?.replacingOccurrences(of: "%", with: "")
                self.isPickupDetail = false
                self.addPickupDetailView.isHidden = true
                self.pickupDetailBgViewHeight.constant = 0
                self.comeFrom = ""
                self.setTableFooter(withPickup: false)
                ActivityIndicator.sharedInstance.hideActivityIndicator()
                setupProductResponseData(response0)
                self.isRequesting = false
                
            }, failure: { (error) in
                
                self.isNoRecordsEnabled(true)
                setupProductResponseData(response0)
                self.isRequesting = false
                
                ActivityIndicator.sharedInstance.hideActivityIndicator()
                print(error.debugDescription)
                Singleton.shared.showErrorMessage(error:  error.localizedDescription, isError: .error)
            })
            
        }, failure: { (error) in
            
            self.isRequesting = false
            self.isNoRecordsEnabled(true)
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            print(error.debugDescription)
            //Singleton.shared.showErrorMessage(error:  error.localizedDescription, isError: .error)
        })
    }
    
    func requestToPerformAnOrder(withProductId productId: String, quantity qty: String, totalAmount amount: String, discountAmount discount: String) {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        
        let parameter: [String: Any] = [
            "product_id": productId,
            "qty": qty,
            "total_amount": amount,
            "discount_amount": discount
        ]
        
        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(ApiConstant.createOrder, params: parameter, headers: ["Authorization": "Bearer \(UserDefaultsCustom.getUserData()?.auth_token ?? "")"], success: { (response0) in
            print(response0)
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                let vc = OrderConfirmPopUpVC()
                vc.delegate = self
                vc.modalPresentationStyle = .overFullScreen
                self.navigationController?.present(vc, true)
                //                self.navigationController?.popToRootViewController(animated: false)
            }
        }, failure: { (error) in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            print(error.debugDescription)
            Singleton.shared.showErrorMessage(error:  error.localizedDescription, isError: .error)
        })
    }
    
    func prepareOrderRequestDetails() -> (productId: String, qty: String, totalAmount: Double, discount: Double) {
        let product_id = String(ProductDetail?.product_id ?? .zero)
        let qty = ProductDetail?.qty ?? String()
        let totalAmount = (Double(ProductDetail?.price ?? String()) ?? .zero) * (Double(qty) ?? .zero)
        let discount = (((Double(dealcode ?? String()) ?? 1)/100) * totalAmount)
        return (product_id, qty, totalAmount, discount)
    }
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set("Apply Coupon", forKey: "couponCodeKey")
        UserDefaults.standard.set("ApplyCoupon", forKey: "imageNameKey")
        
        self.myCartTableView.delegate = self
        self.myCartTableView.dataSource = self
        self.myCartTableView.register(UINib(nibName: "MyCartTVCell", bundle: nil), forCellReuseIdentifier: "MyCartTVCell")
        setTableFooter(withPickup: false)
        
        noRecordsFound.font = UIFont(FONT_NAME.Helvetica_Normal, noRecordsFound.font.pointSize)
        requestForCartListing()
    }
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: SetTableFooter
    
    private func setTableFooter(withPickup isPickupAppeared: Bool) {
        
        DispatchQueue.main.async { [self] in
            
            guard let footer = UINib(nibName: "MyCartFooterView", bundle: nil).instantiate(withOwner: self, options: nil).first as? MyCartFooterView else{return}
            footer.backgroundColor = .clear
            
            //footer.delegate = self
            if let pd = ProductDetail {
                footer.setup(product: pd, dealcode: dealcode ?? String())
            }
            
            if isPickupAppeared {
                
                footer.pickUpDetailStackView.isHidden = !isPickupAppeared
                footer.pickUpDetailStackHeight.constant = 180
                footer.pickupFilledupView.isHidden = !isPickupAppeared
                footer.discountView.isHidden = false
                footer.frame = CGRect(x: 0, y: 0, width: self.myCartTableView.frame.width, height: 480)
                
            } else {
                
                footer.pickUpDetailStackView.isHidden = isPickupAppeared
                footer.pickUpDetailStackHeight.constant = 0
                footer.pickupFilledupView.isHidden = !isPickupAppeared
                footer.discountView.isHidden = isPickupAppeared
                
                footer.frame = CGRect(x: 0, y: 0, width: self.myCartTableView.frame.width, height: 480)
                // footer.applyCouponLabel.text = UserDefaults.standard.string(forKey: "couponCodeKey")
                //footer.applyCouponButton.setImage(UIImage(named: UserDefaults.standard.string(forKey: "imageNameKey") ?? ""), for: .normal)
                self.myCartTableView.reloadData()
            }
            self.myCartTableView.tableFooterView = footer
        }
    }
    
    func poptoSpecificVC(viewController : Swift.AnyClass) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController.isKind(of: viewController) {
                self.navigationController!.popToViewController(aViewController, animated: false)
                break;
            }
        }
    }
    
    func deleteCartApi(productDetail: ProductSubCategoryData?) {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        let params :[String:Any] = [
            "product_id": "\(productDetail?.product_id ?? 0)"
        ]
        print("parameters:-  \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.deleteCart, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce in Home screen : \(response)")
                if succeeded == true {
                    self.showMessage(message: response["message"] as? String ?? "" , isError: .success)
                    self.navigationController?.popViewController(animated: true)
                } else {
//                    self.showMessage(message: response["message"] as? String ?? "" , isError: .error)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    //-------------------------------------------------------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addPickupDetailAction(_ sender: UIButton) {
        let vc = PickUpVC()
        vc.completion = { (name, birthdate, phone, time, image) in
            self.isPickupDetail = true
            self.comeFrom = ""
            self.setTableFooter(withPickup: true)
            if self.isPickupDetail {
                self.addPickupDetailView.isHidden = true
                self.pickupDetailBgViewHeight.constant = 0
            } else {
                self.addPickupDetailView.isHidden = false
                self.pickupDetailBgViewHeight.constant = 40
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                if let fv = self.myCartTableView.tableFooterView as? MyCartFooterView {
                    fv.setup(pickup: name, birthdate: birthdate, phone: phone, time: time, image: image)
                }
            })
            // self.myCartTableView.reloadData()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func placeOrderAction(_ sender: UIButton) {
        
        /*if comeFrom == "MyCart" {
         
         } else {
         let vc = OrderConfirmPopUpVC()
         vc.modalPresentationStyle = .overFullScreen
         self.navigationController?.present(vc, true)
         }*/
        
        if !isPickupDetail {
            Singleton.shared.showErrorMessage(error:  "Please add Pickup Details to proceed.", isError: .error)
            return
        }
        
        let (productId, qty, totalAmount, discountAmount) = prepareOrderRequestDetails()
        requestToPerformAnOrder(withProductId: productId, quantity: qty, totalAmount: String(totalAmount), discountAmount: String(discountAmount))
        
    }
}

//-------------------------------------------------------------------------------------------------------

//MARK: ExtensionTableView

extension MyCartVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartTVCell", for: indexPath) as! MyCartTVCell
        cell.delegate = self
        if let pd = ProductDetail {
            cell.setData(pd)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//-------------------------------------------------------------------------------------------------------

//MARK: ButtonActionFromDelegate

extension MyCartVC: MyCartTVCellDelegate{
    func didTapCrossBtn(productDetail: ProductSubCategoryData?) {
        self.deleteCartApi(productDetail: productDetail)
    }
    
    
//    func didTapCrossBtn(button: UIButton) {
//        return
//    }
    
    func didTapMinusBtn(button: UIButton) {
        return
    }
    
    func didTapPlusBtn(button: UIButton) {
        return
    }
}
//extension MyCartVC: MyCartFooterViewDelegate{
//
//    func didTapapplyCouponButton(button: UIButton, label: UILabel, view: UIView) {
//
//        if button.imageView?.image == UIImage(named: "ApplyCoupon"){
//            let vc = CouponVC()
//            vc.completion = {str in
//            label.text = str
//                view.isHidden = false
//            UserDefaults.standard.set(str, forKey: "couponCodeKey")
//            UserDefaults.standard.set("Ic_CrossBlack", forKey: "imageNameKey")
//            button.setImage(UIImage(named: "Ic_CrossBlack"), for: .normal)
//        }
//            self.navigationController?.pushViewController(vc, animated: true)
//        }else{
//           label.text = "Apply Coupon"
//            view.isHidden = true
//            button.setImage(UIImage(named: "ApplyCoupon"), for: .normal)
//            UserDefaults.standard.set("Apply Coupon", forKey: "couponCodeKey")
//            UserDefaults.standard.set("ApplyCoupon", forKey: "imageNameKey")
//        }
//
//    }
//
//}


extension MyCartVC: OrderConfirmPopUpDelegate {
    func dismissVC() {
//        self.navigationController?.popViewController(animated: false)
        if isFromSideMenu {
            self.navigationController?.popViewController(animated: false)
        } else {
            self.poptoSpecificVC(viewController: ProductVC.self)
        }
    }
}
