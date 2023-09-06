//
//  CouponVC.swift
//  Budtender
//
//  Created by apple on 17/08/23.
//

import UIKit
class CouponVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    @IBOutlet weak var couponTableView: UITableView!
    @IBOutlet weak var txtCouponNumber: UITextField!
    var index:Int = 0
    var completion : (( _ str:String) -> Void)? = nil
    var couponcode = "BUDTENDER20"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.couponTableView.delegate = self
        self.couponTableView.dataSource = self
        self.couponTableView.register(UINib(nibName: "CouponTVCell", bundle: nil), forCellReuseIdentifier: "CouponTVCell")
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkAction(_ sender: UIButton) {
    }
    
    @IBAction func applyAction(_ sender: UIButton) {
        
        if let completion = self.completion{
            self.navigationController?.popViewController(animated: true)
            
            completion(couponcode ?? "")
        }
        
        
    }
    
}
extension CouponVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CouponTVCell", for: indexPath) as! CouponTVCell
        if indexPath.row == self.index{
            cell.selectedButton.setImage(UIImage(named: "Ic_SelectCoupon"), for:.normal)
        }else{
            cell.selectedButton.setImage(UIImage(named: "Ic_UnSelectCoupon"), for:.normal)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        self.couponcode = "BUDTENDER20"
        couponTableView.reloadData()
    }
    
}
