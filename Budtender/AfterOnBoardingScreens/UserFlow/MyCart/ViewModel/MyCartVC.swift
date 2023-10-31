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
    //-------------------------------------------------------------------------------------------------------
    //MARK: Variables
    
    var comeFrom:String?
    var isPickupDetail = true
    var ProductDetail: ProductSubCategoryData?
    
    //------------------------------------------------------
    
    //MARK: Custom
    
    func requestForCartListing() {
                        
        ActivityIndicator.sharedInstance.showActivityIndicator()
        
        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(ApiConstant.cartListing, params: [:], headers: ["Authorization": "Bearer \(AppDefaults.token ?? "")"], success: { (response) in
            print(response)
            
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            
        }, failure: { (error) in
            
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            print(error.debugDescription)
            Singleton.shared.showErrorMessage(error:  error.localizedDescription, isError: .error)
        })
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
        
        setTableFooter()
        
        requestForCartListing()
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        if comeFrom == "MyCart"{
            addPickupDetailView.isHidden = false
            pickupDetailBgViewHeight.constant = 40
        }else{
            addPickupDetailView.isHidden = true
            pickupDetailBgViewHeight.constant = 0
        }
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: SetTableFooter
    
    private func setTableFooter() {
        DispatchQueue.main.async { [self] in
            guard let footer = UINib(nibName: "MyCartFooterView", bundle: nil).instantiate(withOwner: self, options: nil).first as? MyCartFooterView else{return}
            footer.backgroundColor = .clear
            //footer.delegate = self
            if comeFrom == "MyCart"{
                footer.pickUpDetailStackView.isHidden = isPickupDetail
                footer.pickUpDetailStackHeight.constant = 0
                footer.discountView.isHidden = true
                footer.frame = CGRect(x: 0, y: 0, width: self.myCartTableView.frame.width, height: 300)
                
            }else{
                footer.pickUpDetailStackView.isHidden = isPickupDetail
                footer.pickUpDetailStackHeight.constant = 180
                footer.discountView.isHidden = false
                footer.frame = CGRect(x: 0, y: 0, width: self.myCartTableView.frame.width, height: 480)
               // footer.applyCouponLabel.text = UserDefaults.standard.string(forKey: "couponCodeKey")
                //footer.applyCouponButton.setImage(UIImage(named: UserDefaults.standard.string(forKey: "imageNameKey") ?? ""), for: .normal)
                self.myCartTableView.reloadData()
            }
                self.myCartTableView.tableFooterView = footer
        }
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addPickupDetailAction(_ sender: UIButton) {
        let vc = PickUpVC()
        vc.completion = {
            self.isPickupDetail = false
            self.comeFrom = ""
            self.setTableFooter()
           // self.myCartTableView.reloadData()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func placeOrderAction(_ sender: UIButton) {
        if comeFrom == "MyCart"{
            
        }else{
            let vc = OrderConfirmPopUpVC()
            vc.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(vc, true)
        }
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
//-------------------------------------------------------------------------------------------------------
//MARK: ButtonActionFromDelegate

extension MyCartVC: MyCartTVCellDelegate{
    func didTapCrossBtn(button: UIButton) {
        return
    }
    
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
