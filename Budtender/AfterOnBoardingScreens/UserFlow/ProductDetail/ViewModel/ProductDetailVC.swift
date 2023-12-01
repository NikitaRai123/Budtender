//
//  ProductDetailVC.swift
//  Budtender
//
//  Created by apple on 16/08/23.
//

import UIKit
class ProductDetailVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDetailLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    
    var ProductDetail: ProductSubCategoryData?
    var viewModel : DetailVM?
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setViewModel()
    }
    
    func setViewModel(){
        self.viewModel = DetailVM(observer: self)
    }
    
    func setData(){
        self.productDetailLabel.text = "\(self.ProductDetail?.product_name ?? "")\("-")\(self.ProductDetail?.brand_name ?? "") (\(self.ProductDetail?.weight ?? ""))"
        self.amountLabel.text = "\("$")\(self.ProductDetail?.price ?? "")"
//        self.quantityLabel.text = self.ProductDetail?.qty
        self.discriptionLabel.text = self.ProductDetail?.description
        self.productImage.setImage(image: self.ProductDetail?.image,placeholder: UIImage(named: "dispensaryPlaceholder"))
        if ProductDetail?.is_fav == "1"{
            likeBtn.setImage(UIImage(named: "Ic_Like"), for: .normal)
        }else{
            likeBtn.setImage(UIImage(named: "Ic_DisLike"), for: .normal)
        }
        
        if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
            self.likeBtn.isHidden = true
        } else {
            self.likeBtn.isHidden = false
        }
        
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            let id = "\(ProductDetail?.product_id ?? 0)"
            if ProductDetail?.is_fav != "1"{
                self.viewModel?.favoriteApi(dispensaryId: "", productId: id, isFav: "1", isStatus: "1")
            }else{
                self.viewModel?.favoriteApi(dispensaryId: "", productId: id, isFav: "0", isStatus: "1")
            }
            //            sender.isSelected.toggle()
            
        }else{
            
        }
    }
    
    @IBAction func pickupDispSelectAction(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @IBAction func addCartAction(_ sender: UIButton) {
        
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            
            /*let vc = MyCartVC()
            vc.comeFrom = "MyCart"
            self.navigationController?.pushViewController(vc, animated: true)
             */
            
            let product_id = ProductDetail?.product_id ?? .zero
            let params:[String:Any] = [
                "count"             : quantityLabel.text ?? "",
                "product_id"             : product_id
            ]
            print("params are : \(params)")
            ActivityIndicator.sharedInstance.showActivityIndicator()
            
            AFWrapperClass.sharedInstance.requestPostWithMultiFormData(ApiConstant.addCart, params: params, headers: ["Authorization": "Bearer \(UserDefaultsCustom.getUserData()?.auth_token ?? "")"], success: { (response) in
                print(response)
                
                ActivityIndicator.sharedInstance.hideActivityIndicator()
                let vc = MyCartVC()
                vc.ProductDetail = self.ProductDetail
                vc.comeFrom = "MyCart"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, failure: { (error) in
                
                ActivityIndicator.sharedInstance.hideActivityIndicator()
                print(error.debugDescription)
                Singleton.shared.showErrorMessage(error:  error.localizedDescription, isError: .error)
            })
            
        } else if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            
        } else {
            let alertController = UIAlertController(title: "Alert", message: "Please login to use this functionality", preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let actionLogin = UIAlertAction(title: "Login", style: .default) {_ in
                let vc = LoginTypeVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            alertController.addAction(actionLogin)
            alertController.addAction(actionCancel)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func minusAction(_ sender: UIButton) {
        if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
            let alertController = UIAlertController(title: "Alert", message: "Please login to use this functionality", preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let actionLogin = UIAlertAction(title: "Login", style: .default) {_ in
                let vc = LoginTypeVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            alertController.addAction(actionLogin)
            alertController.addAction(actionCancel)
            present(alertController, animated: true, completion: nil)
        } else {
            decrementCount()
        }
    }
    @IBAction func plusAction(_ sender: UIButton) {
        if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
            let alertController = UIAlertController(title: "Alert", message: "Please login to use this functionality", preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let actionLogin = UIAlertAction(title: "Login", style: .default) {_ in
                let vc = LoginTypeVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            alertController.addAction(actionLogin)
            alertController.addAction(actionCancel)
            present(alertController, animated: true, completion: nil)
        } else {
            incrementCount()
        }
    }
    
    func incrementCount() {
        // Get the current count from the label and increment it by 1
        if let currentCount = Int(quantityLabel.text ?? "0") {
            let newCount = currentCount + 1
//            ProductDetail?.qty = String(newCount)
            quantityLabel.text = "\(newCount)"
        }
    }
    
    func decrementCount() {
        // Get the current count from the label
        if let currentCount = Int(quantityLabel.text ?? "0") {
            if currentCount > 1 {
                let newCount = currentCount - 1
//                ProductDetail?.qty = String(newCount)
                quantityLabel.text = "\(newCount)"
            }
        }
    }
    
}

extension ProductDetailVC: DetailVMObserver{
    func likeApi() {
        if viewModel?.favorite?.is_fav == "1"{
            self.likeBtn.setImage(UIImage(named: "Ic_Like"), for: .normal)
            self.ProductDetail?.is_fav = "1"
//            self.navigationController?.popViewController(animated: true)
        } else {
            self.likeBtn.setImage(UIImage(named: "Ic_DisLike"), for: .normal)
            self.ProductDetail?.is_fav = "0"
//            self.navigationController?.popViewController(animated: true)
        }
    }
}
