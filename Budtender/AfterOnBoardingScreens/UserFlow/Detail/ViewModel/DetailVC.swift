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
    var DetailData: HomeDispensaryData?
    var productDetails: [ProductDetailData]?
    var dispensaryTime: DispensorytimeData?
    
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
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Functions
    
    func showAlert(){
        let alertController = UIAlertController(title: "Alert", message: "Please create account to show detail", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let actionLogin = UIAlertAction(title: "Login", style: .default) {_ in
            let vc = LoginTypeVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alertController.addAction(actionLogin)
        alertController.addAction(actionCancel)
        present(alertController, animated: true, completion: nil)
    }
    
    func setData(){
        self.profileImage.setImage(image: DetailData?.image,placeholder: UIImage(named: "dispensaryPlaceholder"))
        self.productNameLabel.text = DetailData?.name
        self.addressLabel.text = "\(DetailData?.address ?? "")\(",")\(DetailData?.postal_code ?? "")\(",")\(DetailData?.country ?? "")"
        self.emailLabel.text = DetailData?.email
        self.websiteLabel.text = DetailData?.website
        let startTime = DetailData?.dispensorytime?.state_time
        let endTime = DetailData?.dispensorytime?.end_time
        let day = DetailData?.dispensorytime?.day_name

        self.timeLabel.text = "\(startTime ?? "")\(" - ")\(endTime ?? "")\("(")\(day ?? "")\(")")"
        print(self.timeLabel.text)
        
        
        //Mark: Dispensary timing
        print(dispensaryTime?.day_name)

        
        
        
        print(productDetails?.count)
        
        
        if productDetails?.count == 0{
            product1View.isHidden = true
            product2View.isHidden = true
            ProductsView.isHidden = true
//            productBackgroundLabelView.isHidden = false
//            productBackgroundLAbel.text = "No Products Found"
        }else if productDetails?.count == 1{
            self.productFirstImage.setImage(image:productDetails?[0].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
            self.firstImageDiscLabel.text = productDetails?[0].product_name
            self.firstImagePriceLabel.text = "\("$")\(productDetails?[0].price ?? "")"
            productSecondImage.isHidden = true
            secondImageDiscLabel.isHidden = true
            secondImagePriceLabel.isHidden = true
            self.product2View.backgroundColor = #colorLiteral(red: 0.9529957175, green: 0.9487085938, blue: 0.965298593, alpha: 1)
            self.image2View.backgroundColor = #colorLiteral(red: 0.9529957175, green: 0.9487085938, blue: 0.965298593, alpha: 1)
        }else if productDetails?.count == 2{
            self.productFirstImage.setImage(image: productDetails?[0].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
            self.firstImageDiscLabel.text = productDetails?[0].product_name
            self.firstImagePriceLabel.text = "\("$")\(productDetails?[0].price ?? "")"
            self.productSecondImage.setImage(image:  productDetails?[1].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
            self.secondImageDiscLabel.text = productDetails?[1].product_name
            self.secondImagePriceLabel.text = "\("$")\(productDetails?[1].price ?? "")"
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            sender.isSelected.toggle()
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
    }
    
    @IBAction func viewAllAction(_ sender: UIButton) {
        let vc = ProductVC()
        vc.isUSerSelected = true
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
