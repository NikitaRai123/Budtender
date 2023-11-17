//
//  ManageDispensaryDetailVC.swift
//  Budtender
//
//  Created by apple on 30/08/23.
//

import UIKit
class ManageDispensaryDetailVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeSatusLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var websiteAddressLabel: UILabel!
    @IBOutlet weak var licenceNumberLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var productFirstImage: UIImageView!
    @IBOutlet weak var productSecondImage: UIImageView!
    @IBOutlet weak var firstImageDiscLabel: UILabel!
    @IBOutlet weak var firstImagePriceLabel: UILabel!
    @IBOutlet weak var secondImageDiscLabel: UILabel!
    @IBOutlet weak var secondImagePriceLabel: UILabel!
    @IBOutlet weak var cityStatePostalLabel: UILabel!
    @IBOutlet weak var productBackgroundLabelView: UIView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productBackgroundLAbel: UILabel!
    @IBOutlet weak var product2View: UIView!
    @IBOutlet weak var imageSecondView: UIView!
    @IBOutlet weak var timeFirstLabel: UILabel!
    @IBOutlet weak var timeSecondLabel: UILabel!
    @IBOutlet weak var timeThirdLabel: UILabel!
    @IBOutlet weak var timeFourthLabel: UILabel!
    @IBOutlet weak var timeFifthLabel: UILabel!
    @IBOutlet weak var timeSixthLabel: UILabel!
    @IBOutlet weak var timeSeventhLabel: UILabel!
    @IBOutlet weak var productViewHeight: NSLayoutConstraint!
    
    
    var name: String?
    var country: String?
    var phone: String?
    var startTiming: String?
    var endTiming: String?
    var day: String?
    var address: String?
    var email: String?
    var website: String?
    var license: String?
    var expiration: String?
    var city: String?
    var postal: String?
    var state: String?
    var image: String?
    var subCatID: String?
    var productID: String?
    var productCount: Int?
    var latitude: String?
    var longitude: String?
    var viewModel: ProductSubCategoryVM?
    var productModel : [ProductDetails]?
    var dispensaryTiming: [Dispensorytime]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(productCount)
        print(productModel)
        productBackgroundLabelView.isHidden = true
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
                } else {
                    automaticallyAdjustsScrollViewInsets = false
                }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setData()
        print(dispensaryTiming?.count)
        
    }

    func setData(){
        self.productImage.setImage(image: self.image, placeholder: UIImage(named: "dispensaryPlaceholder"))
        self.placeLabel.text = self.country
        print("\(startTiming)\(endTiming)\(day)")
//        self.timeLabel.text = "\(self.startTiming ?? "")\(" - ")\(self.endTiming ?? "")\("(")\(self.day ?? "")\(")")"
        print(self.timeLabel.text)
        self.addressLabel.text = self.address
        self.emailLabel.text = self.email
        self.websiteAddressLabel.text = self.website
        self.licenceNumberLabel.text = self.license
        self.expirationDateLabel.text = self.expiration
        self.cityStatePostalLabel.text = "\(self.city ?? "")\("/")\(self.state ?? "")\("/")\(self.postal ?? "")"
        self.productNameLabel.text = self.name
        
        
        //Mark: Dispensary timing
        print("\(dispensaryTiming?.first?.day_name)\(dispensaryTiming?[1].day_name)\(dispensaryTiming?[2].day_name)\(dispensaryTiming?[3].day_name)\(dispensaryTiming?[4].day_name)\(dispensaryTiming?[5].day_name)\(dispensaryTiming?[6].day_name)")
        
        
        if dispensaryTiming?.first?.is_switchon == "true"{
            self.timeFirstLabel.text = "\(dispensaryTiming?.first?.state_time ?? "")\(" - ")\(dispensaryTiming?.first?.end_time ?? "")\("(")\(dispensaryTiming?.first?.day_name ?? "")\(")")"
            timeFirstLabel.isHidden = false
            timeSecondLabel.isHidden = true
            timeThirdLabel.isHidden = true
            timeFourthLabel.isHidden = true
            timeFifthLabel.isHidden = true
            timeSixthLabel.isHidden = true
            timeSeventhLabel.isHidden = true
        }else{
            timeFirstLabel.isHidden = true
        }
        
  
        if dispensaryTiming?[1].is_switchon == "true"{
            self.timeSecondLabel.text = "\(dispensaryTiming?[1].state_time ?? "")\(" - ")\(dispensaryTiming?[1].end_time ?? "")\("(")\(dispensaryTiming?[1].day_name ?? "")\(")")"
            timeSecondLabel.isHidden = false
            timeThirdLabel.isHidden = true
            timeFourthLabel.isHidden = true
            timeFifthLabel.isHidden = true
            timeSixthLabel.isHidden = true
            timeSeventhLabel.isHidden = true
        }else{
            timeSecondLabel.isHidden = true
        }
        
        
        if dispensaryTiming?[2].is_switchon == "true"{
            self.timeThirdLabel.text = "\(dispensaryTiming?[2].state_time ?? "")\(" - ")\(dispensaryTiming?[2].end_time ?? "")\("(")\(dispensaryTiming?[2].day_name ?? "")\(")")"
            timeThirdLabel.isHidden = false
            timeFourthLabel.isHidden = true
            timeFifthLabel.isHidden = true
            timeSixthLabel.isHidden = true
            timeSeventhLabel.isHidden = true
        }else{
            timeThirdLabel.isHidden = true
        }
        
        
        if dispensaryTiming?[3].is_switchon == "true"{
            self.timeFourthLabel.text = "\(dispensaryTiming?[3].state_time ?? "")\(" - ")\(dispensaryTiming?[3].end_time ?? "")\("(")\(dispensaryTiming?[3].day_name ?? "")\(")")"
            timeFourthLabel.isHidden = false
            timeFifthLabel.isHidden = true
            timeSixthLabel.isHidden = true
            timeSeventhLabel.isHidden = true
        }else{
            timeFourthLabel.isHidden = true
        }
        
       if dispensaryTiming?[4].is_switchon == "true"{
            self.timeFifthLabel.text = "\(dispensaryTiming?[4].state_time ?? "")\(" - ")\(dispensaryTiming?[4].end_time ?? "")\("(")\(dispensaryTiming?[4].day_name ?? "")\(")")"
           timeFifthLabel.isHidden = false
            timeSixthLabel.isHidden = true
            timeSeventhLabel.isHidden = true
       }else{
           timeFifthLabel.isHidden = true
       }
  
        if dispensaryTiming?[5].is_switchon == "true"{
            self.timeSixthLabel.text = "\(dispensaryTiming?[5].state_time ?? "")\(" - ")\(dispensaryTiming?[5].end_time ?? "")\("(")\(dispensaryTiming?[5].day_name ?? "")\(")")"
            timeSixthLabel.isHidden = false
            timeSeventhLabel.isHidden = true
        }else{
            timeSixthLabel.isHidden = true
        }
        
        if dispensaryTiming?[6].is_switchon == "true"{
            self.timeSeventhLabel.text = "\(dispensaryTiming?[6].state_time ?? "")\(" - ")\(dispensaryTiming?[6].end_time ?? "")\("(")\(dispensaryTiming?[6].day_name ?? "")\(")")"
            timeSeventhLabel.isHidden = false
        }
        
        
        //MARK: ProductData
        self.productView.isHidden = false
        self.productViewHeight.constant = 296
        if productCount == 0{
            productBackgroundLabelView.isHidden = false
            productBackgroundLAbel.text = "No Products Found"
            self.productView.isHidden = true
            self.productViewHeight.constant = 0
        }else if productCount == 1{
            self.productFirstImage.setImage(image:productModel?[0].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
            self.firstImageDiscLabel.text = productModel?[0].product_name
            self.firstImagePriceLabel.text = "\("$")\(productModel?[0].price ?? "")"
            productSecondImage.isHidden = true
            secondImageDiscLabel.isHidden = true
            secondImagePriceLabel.isHidden = true
            self.product2View.backgroundColor = #colorLiteral(red: 0.9529957175, green: 0.9487085938, blue: 0.965298593, alpha: 1)
            self.imageSecondView.backgroundColor = #colorLiteral(red: 0.9529957175, green: 0.9487085938, blue: 0.965298593, alpha: 1)
        }else if productCount == 2{
            self.productFirstImage.setImage(image: productModel?[0].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
            self.firstImageDiscLabel.text = productModel?[0].product_name
            self.firstImagePriceLabel.text = "\("$")\(productModel?[0].price ?? "")"
            self.productSecondImage.setImage(image:  productModel?[1].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
            self.secondImageDiscLabel.text = productModel?[1].product_name
            self.secondImagePriceLabel.text = "\("$")\(productModel?[1].price ?? "")"
        } else {
            
        }
        
    }
  
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func phoneAction(_ sender: UIButton) {
        let phone = self.phone
        if let phoneCallURL = URL(string: "tel://\(phone ?? "")") {
            let application = UIApplication.shared
            if application.canOpenURL(phoneCallURL) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func viewOnMapAction(_ sender: UIButton) {
        let destination = "daddr=\(self.latitude ?? ""),\(self.longitude ?? "")"
        if let path = URL(string: "maps://?\(destination)") {
            print(path)
            UIApplication.shared.open(path, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func websiteViewonMapAction(_ sender: UIButton) {
    }
    
    @IBAction func viewAllAction(_ sender: UIButton) {
        let vc = ProductVC()
        self.pushViewController(vc, true)
    }
    
    @IBAction func websiteAction(_ sender: UIButton) {
        let urlString = self.website
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

