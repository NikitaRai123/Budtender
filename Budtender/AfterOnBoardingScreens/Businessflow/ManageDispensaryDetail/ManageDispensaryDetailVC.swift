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
    @IBOutlet weak var productBackgroundLAbel: UILabel!
    @IBOutlet weak var product2View: UIView!
    @IBOutlet weak var imageSecondView: UIView!
    
    
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
    var viewModel: ProductSubCategoryVM?
    var productModel : [ProductDetail]?
    
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
    }

    func setData(){
        self.productImage.setImage(image: self.image, placeholder: UIImage(named: "dispensaryPlaceholder"))
        self.placeLabel.text = self.country
        print("\(startTiming)\(endTiming)\(day)")
        self.timeLabel.text = "\(self.startTiming ?? "")\(" - ")\(self.endTiming ?? "")\("(")\(self.day ?? "")\(")")"
        print(self.timeLabel.text)
        self.addressLabel.text = self.address
        self.emailLabel.text = self.email
        self.websiteAddressLabel.text = self.website
        self.licenceNumberLabel.text = self.license
        self.expirationDateLabel.text = self.expiration
        self.cityStatePostalLabel.text = "\(self.city ?? "")\("/")\(self.state ?? "")\("/")\(self.postal ?? "")"
        self.productNameLabel.text = self.name
        
        if productCount == 0{
            productBackgroundLabelView.isHidden = false
            productBackgroundLAbel.text = "No Products Found"
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
        }
        
    }
  
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func phoneAction(_ sender: UIButton) {
        let phone = self.phone
        print(self.phone)
        if let phoneCallURL = URL(string: "tel://\(phone ?? "")") {
            let application = UIApplication.shared
            if application.canOpenURL(phoneCallURL) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func viewOnMapAction(_ sender: UIButton) {
    }
    
    @IBAction func websiteViewonMapAction(_ sender: UIButton) {
    }
    
    @IBAction func viewAllAction(_ sender: UIButton) {
        let vc = ProductVC()
        self.pushViewController(vc, true)
    }
}

