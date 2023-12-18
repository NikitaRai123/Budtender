//
//  DetailVC.swift
//  Budtender
//
//  Created by apple on 10/08/23.
//

import UIKit
import Cosmos
class DetailVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var productSecondImage: UIImageView!
    @IBOutlet weak var firstImageDiscLabel: UILabel!
    @IBOutlet weak var firstImagePriceLabel: UILabel!
    @IBOutlet weak var secondImageDiscLabel: UILabel!
    @IBOutlet weak var secondImagePriceLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var productFirstImage: UIImageView!
    @IBOutlet weak var product2View: UIView!
    @IBOutlet weak var product1View: UIView!
    @IBOutlet weak var image2View: UIView!
    @IBOutlet weak var timeFirstLabel: UILabel!
    @IBOutlet weak var timeSecondLabel: UILabel!
    @IBOutlet weak var timeThirdLabel: UILabel!
    @IBOutlet weak var timeFourthLabel: UILabel!
    @IBOutlet weak var timeFifthLabel: UILabel!
    @IBOutlet weak var timeSixthLabel: UILabel!
    @IBOutlet weak var timeSeventhLabel: UILabel!
    @IBOutlet weak var ProductsView: UIView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var productButtonOne: UIButton!
    @IBOutlet weak var productButtonTwo: UIButton!
    
    var DetailData: HomeDispensaryData?
    var productDetails: [ProductSubCategoryData]?
    var dispensaryTime: DispensorytimeData?
    var viewModel : DetailVM?
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
                } else {
                    automaticallyAdjustsScrollViewInsets = false
                }
        setData()
        setViewModel()
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Functions
    
    func setViewModel(){
        self.viewModel = DetailVM(observer: self)
    }
 
    func showAlert() {
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
    
    func setData() {
        self.profileImage.setImage(image: DetailData?.image,placeholder: UIImage(named: "dispensaryPlaceholder"))
        self.productNameLabel.text = DetailData?.name
        self.addressLabel.text = "\(DetailData?.address ?? "")\(",")\(DetailData?.postal_code ?? "")\(",")\(DetailData?.country ?? "")"
        self.emailLabel.text = DetailData?.email
        self.websiteLabel.text = DetailData?.website
        let startTime = DetailData?.dispensorytime?.state_time
        let endTime = DetailData?.dispensorytime?.end_time
        let day = DetailData?.dispensorytime?.day_name
        ratingView.settings.fillMode = .full
        ratingView.rating = Double(self.DetailData?.rating ?? "") ?? 0.0


        self.timeLabel.text = "\(startTime ?? "")\(" - ")\(endTime ?? "")\("(")\(day ?? "")\(")")"
        print(self.timeLabel.text)
        if self.DetailData?.is_fav == "1" {
            self.likeBtn.setImage(UIImage(named: "Ic_Like"), for: .normal)
        } else {
            self.likeBtn.setImage(UIImage(named: "Ic_DisLike"), for: .normal)
        }
            
        if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
            self.likeBtn.isHidden = true
        } else {
            self.likeBtn.isHidden = false
        }

        
        //Mark: Dispensary timing
        print(dispensaryTime?.day_name)
        print(productDetails?.count)
        
        
        if productDetails?.count == 0 {
            product1View.isHidden = true
            product2View.isHidden = true
            ProductsView.isHidden = true
            productButtonOne.isUserInteractionEnabled = false
            productButtonTwo.isUserInteractionEnabled = false
//            productBackgroundLabelView.isHidden = false
//            productBackgroundLAbel.text = "No Products Found"
        } else if productDetails?.count == 1 {
            self.productFirstImage.setImage(image:productDetails?[0].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
            self.firstImageDiscLabel.text = productDetails?[0].product_name
            self.firstImagePriceLabel.text = "\("$")\(productDetails?[0].price ?? "")"
            productButtonOne.isUserInteractionEnabled = true
            productButtonTwo.isUserInteractionEnabled = false
            productSecondImage.isHidden = true
            secondImageDiscLabel.isHidden = true
            secondImagePriceLabel.isHidden = true
            self.product2View.backgroundColor = #colorLiteral(red: 0.9529957175, green: 0.9487085938, blue: 0.965298593, alpha: 1)
            self.image2View.backgroundColor = #colorLiteral(red: 0.9529957175, green: 0.9487085938, blue: 0.965298593, alpha: 1)
        } else if productDetails?.count == 2 {
            self.productFirstImage.setImage(image: productDetails?[0].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
            self.firstImageDiscLabel.text = productDetails?[0].product_name
            self.firstImagePriceLabel.text = "\("$")\(productDetails?[0].price ?? "")"
            self.productSecondImage.setImage(image:  productDetails?[1].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
            self.secondImageDiscLabel.text = productDetails?[1].product_name
            self.secondImagePriceLabel.text = "\("$")\(productDetails?[1].price ?? "")"
            productButtonOne.isUserInteractionEnabled = true
            productButtonTwo.isUserInteractionEnabled = true
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            let id = "\(self.DetailData?.id ?? 0)"
            if DetailData?.is_fav != "1"{
                self.viewModel?.favoriteApi(dispensaryId: id, productId: "", isFav: "1", isStatus: "2")
            }else{
                self.viewModel?.favoriteApi(dispensaryId: id, productId: "", isFav: "0", isStatus: "2")
            }
            
        }else if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
            showAlert()
        }else{}
    }
    
    @IBAction func phoneAction(_ sender: UIButton) {
        let phone = self.DetailData?.phone_number
        print(phone)
        if let phoneCallURL = URL(string: "tel://\(phone ?? "")") {
            let application = UIApplication.shared
            if application.canOpenURL(phoneCallURL) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func viewOnMapAction(_ sender: UIButton) {
////        let current = LocationManager.shared.currentLocation?.coordinate
////        let source = "saddr=\(current?.latitude ?? 0.0),\(current?.longitude ?? 0.0)&"
        
        let destination = "daddr=\(self.DetailData?.latitude ?? ""),\(self.DetailData?.longitude ?? "")"
        if let path = URL(string: "maps://?\(destination)") {
            print(path)
            UIApplication.shared.open(path, options: [:], completionHandler: nil)
        }
        
//        if let url = URL(string: "comgooglemaps://?saddr=&daddr=\(self.DetailData?.latitude ?? ""),\(self.DetailData?.longitude ?? "")&directionsmode=driving") {
//                UIApplication.shared.open(url, options: [:])
//            }

    }
    
    @IBAction func productButtonOneAction(_ sender: UIButton) {
        let vc = ProductDetailVC()
        vc.ProductDetail = self.productDetails?[0]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func productButtonTwoAction(_ sender: UIButton) {
        let vc = ProductDetailVC()
        vc.ProductDetail = self.productDetails?[1]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func viewAllAction(_ sender: UIButton) {
        let vc = ProductVC()
        vc.isUSerSelected = true
        vc.dispensaryId = "\(self.DetailData?.id ?? 0)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func websiteAction(_ sender: UIButton) {
        let urlString = DetailData?.website
        if let url = URL(string: urlString ?? ""), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if let httpURL = URL(string: "http://" + (urlString ?? "")), UIApplication.shared.canOpenURL(httpURL) {
            UIApplication.shared.open(httpURL)
        } else {
            showMessage(message: "Unable to open the URL", isError: .error)
            print("Unable to open the URL")
        }
    }
    
}


extension DetailVC: DetailVMObserver {
    func likeApi() {
        if viewModel?.favorite?.is_fav == "1"{
            self.DetailData?.is_fav = "1"
            self.likeBtn.setImage(UIImage(named: "Ic_Like"), for: .normal)
//            self.navigationController?.popViewController(animated: true)
        }else{
            self.DetailData?.is_fav = "0"
            self.likeBtn.setImage(UIImage(named: "Ic_DisLike"), for: .normal)
//            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
