//
//  FavoriteVC.swift
//  Budtender
//
//  Created by apple on 22/08/23.
//

import UIKit
class FavoriteVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var dispensaryButton: UIButton!
    @IBOutlet weak var dispensaryView: UIView!
    @IBOutlet weak var productButton: UIButton!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var isSelected:String?
    var viewModel: FavoriteVM?
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
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
        setViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.favoriteListApi(isStatus: "2")
       
    }
    
    func setViewModel() {
        self.viewModel = FavoriteVM(observer: self)
    }
    
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dispensaryAction(_ sender: UIButton) {
        self.isSelected = "Dispensary"
        viewModel?.favoriteList?.removeAll()
        viewModel?.favoriteListApi(isStatus: "2")
        self.favoriteTableView.reloadData()
        dispensaryView.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        productView.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
        dispensaryButton.setTitleColor(UIColor(r: 60.0, g: 74.0, b: 44.0, a: 1), for: .normal)
        productButton.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func productAction(_ sender: UIButton) {
        self.isSelected = "Product"
        viewModel?.favoriteList?.removeAll()
        viewModel?.productFavoriteListApi(isStatus: "1")
        self.favoriteTableView.reloadData()
        productView.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        dispensaryView.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
        productButton.setTitleColor(UIColor(r: 60.0, g: 74.0, b: 44.0, a: 1), for: .normal)
        dispensaryButton.setTitleColor(.black, for: .normal)
    }
}
//-------------------------------------------------------------------------------------------------------
//MARK: ExtensionsTableView

extension FavoriteVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSelected == "Dispensary"{
//            return 2
            return viewModel?.favoriteList?.count ?? 0
        }else{
//            return 2
            print(viewModel?.productFavoriteList?.count ?? 0)
            return viewModel?.productFavoriteList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSelected == "Dispensary"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTVCell", for: indexPath) as! FavoriteTVCell
            cell.delegate = self
            cell.productImage.setImage(image: viewModel?.favoriteList?[indexPath.row].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
            cell.productName.text = viewModel?.favoriteList?[indexPath.row].name
            cell.discriptionLabel.text = viewModel?.favoriteList?[indexPath.row].address
            cell.id = "\(viewModel?.favoriteList?[indexPath.row].id ?? 0)"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTVCell", for: indexPath) as! ProductTVCell
            cell.delegate = self
            cell.productImage.setImage(image: viewModel?.productFavoriteList?[indexPath.row].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
            cell.productName.text = viewModel?.productFavoriteList?[indexPath.row].product_name
            cell.discriptionLabel.text = "\(viewModel?.productFavoriteList?[indexPath.row].brand_name ?? "")\("-")\(viewModel?.productFavoriteList?[indexPath.row].qty ?? "")"
            cell.priceLabel.text = "\("$")\(viewModel?.productFavoriteList?[indexPath.row].price ?? "")"
            cell.id = "\(viewModel?.productFavoriteList?[indexPath.row].product_id ?? 0)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FavoriteVC: FavoriteTVCellDelegate{
    func didTapFavoriteButton(button: UIButton, cell:FavoriteTVCell?, id: String?) {
        self.viewModel?.favoriteApi(dispensaryId: id ?? "", productId: "", isFav: "0", isStatus: "2")
    }
    
//    func didTapFavoriteButton(button: UIButton) {
//        return
//    }
}
extension FavoriteVC: FavoriteVMObserver {
    func likeDislikeApi(dispensaryId: String, productId: String) {
        if dispensaryId.count > 0 {
            if viewModel?.favoriteList?.contains(where: {$0.id == Int(dispensaryId)}) == true {
                self.viewModel?.favoriteList?.removeAll(where: {$0.id == Int(dispensaryId)})
                self.favoriteTableView.reloadData()
                if viewModel?.favoriteList?.count ?? 0 == 0{
                    viewModel?.favoriteList?.removeAll()
                    favoriteTableView.setBackgroundView(message: "No favorite Data")
                }else{
                    favoriteTableView.setBackgroundView(message: "")
                    favoriteTableView.reloadData()
                }
            }
        } else if productId.count > 0 {
            if viewModel?.productFavoriteList?.contains(where: {$0.product_id == Int(productId)}) == true {
                self.viewModel?.productFavoriteList?.removeAll(where: {$0.product_id == Int(productId)})
                self.favoriteTableView.reloadData()
                if viewModel?.productFavoriteList?.count ?? 0 == 0{
                    viewModel?.productFavoriteList?.removeAll()
                    favoriteTableView.setBackgroundView(message: "No favorite Data")
                }else{
                    favoriteTableView.setBackgroundView(message: "")
                    favoriteTableView.reloadData()
                }
            }
        }
    }
    
    
    func productFavoriteListApi(postCount: Int) {
        if postCount == 0{
            viewModel?.productFavoriteList?.removeAll()
            favoriteTableView.setBackgroundView(message: "No favorite Data")
        }else{
            favoriteTableView.setBackgroundView(message: "")
            favoriteTableView.reloadData()
        }
    }
    
    func favoriteListApi(postCount: Int) {
        if postCount == 0{
            viewModel?.favoriteList?.removeAll()
            favoriteTableView.setBackgroundView(message: "No favorite Data")
        }else{
            favoriteTableView.setBackgroundView(message: "")
            favoriteTableView.reloadData()
        }
    }
    
    
}


extension FavoriteVC: ProductTVCellDelegate {
    func likeUnlike(id: String?) {
        self.viewModel?.favoriteApi(dispensaryId: "", productId: id ?? "", isFav: "0", isStatus: "1")
    }
}
