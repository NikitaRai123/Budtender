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
        self.productDetailLabel.text = "\(self.ProductDetail?.product_name ?? "")\("-")\(self.ProductDetail?.brand_name ?? "")"
        self.amountLabel.text = "\("$")\(self.ProductDetail?.price ?? "")"
        self.quantityLabel.text = self.ProductDetail?.qty
        self.discriptionLabel.text = self.ProductDetail?.description
        self.productImage.setImage(image: self.ProductDetail?.image,placeholder: UIImage(named: "dispensaryPlaceholder"))
        if ProductDetail?.is_fav == "1"{
            likeBtn.setImage(UIImage(named: "Ic_Like"), for: .normal)
        }else{
            likeBtn.setImage(UIImage(named: "Ic_DisLike"), for: .normal)
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
            let vc = MyCartVC()
            vc.comeFrom = "MyCart"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            
        }else{
            let vc = SignUpVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func minusAction(_ sender: UIButton) {
       decrementCount()
      
        
    }
    @IBAction func plusAction(_ sender: UIButton) {
        incrementCount()
    }
    
    func incrementCount() {
        // Get the current count from the label and increment it by 1
        if let currentCount = Int(quantityLabel.text ?? "0") {
            let newCount = currentCount + 1
            quantityLabel.text = "\(newCount)"
        }
    }
    
    func decrementCount() {
        // Get the current count from the label
        if let currentCount = Int(quantityLabel.text ?? "0") {
            if currentCount > 1 {
                let newCount = currentCount - 1
                quantityLabel.text = "\(newCount)"
            }
        }
    }

}
extension ProductDetailVC: DetailVMObserver{
    func likeApi() {
        if viewModel?.favorite?.is_fav == "1"{
            self.likeBtn.setImage(UIImage(named: "Ic_Like"), for: .normal)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.likeBtn.setImage(UIImage(named: "Ic_DisLike"), for: .normal)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
