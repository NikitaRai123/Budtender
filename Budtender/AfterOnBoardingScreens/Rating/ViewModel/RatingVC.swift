//
//  RatingVC.swift
//  Budtender
//
//  Created by apple on 22/08/23.
//

import UIKit
class RatingVC: UIViewController {
    
    @IBOutlet weak var rateOneBtn: UIButton!
    @IBOutlet weak var rateTwoBtn: UIButton!
    @IBOutlet weak var rateThreeBtn: UIButton!
    @IBOutlet weak var rateFourBtn: UIButton!
    @IBOutlet weak var rateFiveBtn: UIButton!
    var index:Int = 0
    var completion : (( _ int:Int) -> Void)? = nil
    var rating = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
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
        
        if let completion = self.completion{
            self.navigationController?.popViewController(animated: true)
            
            completion(rating)
        }
    }
    
}
