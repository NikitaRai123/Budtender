//
//  RatingVC.swift
//  Budtender
//
//  Created by apple on 22/08/23.
//

import UIKit

class RatingVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var rateOneBtn: UIButton!
    @IBOutlet weak var rateTwoBtn: UIButton!
    @IBOutlet weak var rateThreeBtn: UIButton!
    @IBOutlet weak var rateFourBtn: UIButton!
    @IBOutlet weak var rateFiveBtn: UIButton!
    //-------------------------------------------------------------------------------------------------------
    //MARK: Variables
    
    var index:Int = 0
    var completion : (( _ int:Int) -> Void)? = nil
    var rating = 1
    var orderData: OrderData?
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rating = orderData?.rating ?? 0
        self.setUI()
    }
    
    
    func setUI() {
        if self.rating == 1 {
            rateOneBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
            rateTwoBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
            rateThreeBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
            rateFourBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
            rateFiveBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
        } else if self.rating == 2 {
            rateTwoBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
            rateOneBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
            rateThreeBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
            rateFourBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
            rateFiveBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
        } else if self.rating == 3 {
            rateThreeBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
            rateTwoBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
            rateOneBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
            rateFourBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
            rateFiveBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
        } else if self.rating == 4 {
            rateFourBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
            rateTwoBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
            rateThreeBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
            rateOneBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
            rateFiveBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
        } else if self.rating == 5 {
            rateFiveBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
            rateTwoBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
            rateThreeBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
            rateFourBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
            rateOneBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
        } else {
            rateOneBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
            rateTwoBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
            rateThreeBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
            rateFourBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
            rateFiveBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
        }
        
    }
    
    
    func addRatingApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        let pDetail = self.orderData?.product_details
        let params :[String:Any] = [
            "rating"   : "\(self.rating)",
            "product_id"   : "\(pDetail?.product_id ?? 0)",
            "dispensarys_id": pDetail?.dispensory_id ?? ""
        ]
        print("parameters:-  \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.addRating, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce in Home screen : \(response)")
                if succeeded == true {
                    self.showMessage(message: response["message"] as? String ?? "" , isError: .success)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.showMessage(message: response["message"] as? String ?? "" , isError: .error)
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
    
    @IBAction func rateOneAction(_ sender: UIButton) {
        self.rating = 1
        rateOneBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
        rateTwoBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
        rateThreeBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
        rateFourBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
        rateFiveBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
    }
    
    @IBAction func rateTwoAction(_ sender: UIButton) {
        self.rating = 2
        rateTwoBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
        rateOneBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
        rateThreeBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
        rateFourBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
        rateFiveBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
    }
    @IBAction func rateThreeAction(_ sender: UIButton) {
        self.rating = 3
        rateThreeBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
        rateTwoBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
        rateOneBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
        rateFourBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
        rateFiveBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
    }
    @IBAction func rateFourAction(_ sender: UIButton) {
        self.rating = 4
        rateFourBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
        rateTwoBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
        rateThreeBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
        rateOneBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
        rateFiveBtn.setImage(UIImage(named: "Img_UnSelectRating"), for: .normal)
    }
    @IBAction func rateFiveeAction(_ sender: UIButton) {
        self.rating = 5
        rateFiveBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
        rateTwoBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
        rateThreeBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
        rateFourBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
        rateOneBtn.setImage(UIImage(named: "Img_SelectRating"), for: .normal)
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        if self.rating > 0 {
            self.addRatingApi()
        } else {
            Budtender.showAlert(title: Constants.AppName, message: "Please add rating.", view: self)
        }
        
//        if let completion = self.completion{
//            self.navigationController?.popViewController(animated: true)
//            completion(rating)
//        }
    }
}
