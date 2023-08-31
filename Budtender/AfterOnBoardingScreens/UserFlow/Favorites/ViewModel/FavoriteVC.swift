//
//  FavoriteVC.swift
//  Budtender
//
//  Created by apple on 22/08/23.
//

import UIKit
class FavoriteVC: UIViewController {

    @IBOutlet weak var dispensaryButton: UIButton!
    @IBOutlet weak var dispensaryView: UIView!
    @IBOutlet weak var productButton: UIButton!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var isSelected:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.favoriteTableView.delegate = self
        self.favoriteTableView.dataSource = self
        self.favoriteTableView.register(UINib(nibName: "FavoriteTVCell", bundle: nil), forCellReuseIdentifier: "FavoriteTVCell")
        
        self.favoriteTableView.delegate = self
        self.favoriteTableView.dataSource = self
        self.favoriteTableView.register(UINib(nibName: "ProductTVCell", bundle: nil), forCellReuseIdentifier: "ProductTVCell")
        
        self.isSelected = "Dispensary"
        dispensaryView.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        productView.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
        dispensaryButton.setTitleColor(UIColor(r: 60.0, g: 74.0, b: 44.0, a: 1), for: .normal)
        productButton.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func dispensaryAction(_ sender: UIButton) {
        
        self.isSelected = "Dispensary"
        self.favoriteTableView.reloadData()
        dispensaryView.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        productView.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
        dispensaryButton.setTitleColor(UIColor(r: 60.0, g: 74.0, b: 44.0, a: 1), for: .normal)
        productButton.setTitleColor(.black, for: .normal)
    }
    @IBAction func productAction(_ sender: UIButton) {
        self.isSelected = "Product"
        self.favoriteTableView.reloadData()
        productView.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        dispensaryView.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
        productButton.setTitleColor(UIColor(r: 60.0, g: 74.0, b: 44.0, a: 1), for: .normal)
        dispensaryButton.setTitleColor(.black, for: .normal)
    }
}

extension FavoriteVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSelected == "Dispensary"{
            return 2
        }else{
            return 2
        }    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSelected == "Dispensary"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTVCell", for: indexPath) as! FavoriteTVCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTVCell", for: indexPath) as! ProductTVCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension FavoriteVC: FavoriteTVCellDelegate{
    func didTapFavoriteButton(button: UIButton) {
        return
    }
    
    
}
