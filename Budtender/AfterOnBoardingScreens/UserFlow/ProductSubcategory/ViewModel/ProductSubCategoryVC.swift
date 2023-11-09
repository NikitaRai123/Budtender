//
//  ProductSubCategoryVC.swift
//  Budtender
//
//  Created by apple on 16/08/23.
//

import UIKit
class ProductSubCategoryVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var subCatNameLabel: UILabel!
    
    var subCatID: String?
    var productID: String?
    var dispensaryId: String = ""
    var viewModel: ProductSubCategoryVM?
    var filterData: [ProductSubCategoryData] = []
    var timer: Timer?
    var subcatName: String?
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTF.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "ProductSubCategoryCVCell", bundle: nil), forCellWithReuseIdentifier: "ProductSubCategoryCVCell")
        print("\(subCatID)\(productID)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.subCatNameLabel.text = self.subcatName
        viewModel?.productSubCategory?.removeAll()
        setViewModel()
    }
    
    func setViewModel() {
        self.viewModel = ProductSubCategoryVM(observer: self)
        if filterData.count > 0 {
            self.viewModel?.productSubCategory = self.filterData
            self.collectionView.reloadData()
        } else {
            if "business" == UserDefaults.standard.string(forKey: "LoginType") {
                viewModel?.productSubCategoryListApi(productId: self.productID ?? "", name: "", subcatId: self.subCatID ?? "")
            } else if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
                viewModel?.productGuestSubCategoryListUserApi(name: "", subcatId: self.subCatID ?? "", dispensaryId: self.dispensaryId)
            } else {
                viewModel?.productSubCategoryListUserApi(name: "", subcatId: self.subCatID ?? "", dispensaryId: self.dispensaryId)
            }
        }
        
    }
    
    func poptoSpecificVC(viewController : Swift.AnyClass) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController.isKind(of: viewController) {
                self.navigationController!.popToViewController(aViewController, animated: false)
                break;
            }
        }
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    @IBAction func backAction(_ sender: UIButton) {
        poptoSpecificVC(viewController: ProductVC.self)
    }
    
    
}
//-------------------------------------------------------------------------------------------------------
//MARK: ExtensionsTableView

extension ProductSubCategoryVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel?.productSubCategory?.count ?? 0)
        return viewModel?.productSubCategory?.count ?? 0
        //        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductSubCategoryCVCell", for: indexPath) as! ProductSubCategoryCVCell
        cell.productImage.setImage(image: viewModel?.productSubCategory?[indexPath.row].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
        cell.productNameLabel.text = "\(viewModel?.productSubCategory?[indexPath.row].product_name ?? "") (\(viewModel?.productSubCategory?[indexPath.row].weight ?? ""))"
        cell.priceLabel.text = "\("$")\(viewModel?.productSubCategory?[indexPath.row].price ?? "")"
        cell.passData(data: (viewModel?.productSubCategory?[indexPath.row])!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 2), height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            let vc = BusinessDetailVC()
            vc.ProductDetail = viewModel?.productSubCategory?[indexPath.row]
            vc.id = "\(viewModel?.productSubCategory?[indexPath.row].product_id ?? 0)"
            vc.productNAme = viewModel?.productSubCategory?[indexPath.row].product_name
            vc.brandName = viewModel?.productSubCategory?[indexPath.row].brand_name
            vc.weight = viewModel?.productSubCategory?[indexPath.row].weight
            vc.subCatNAme = viewModel?.productSubCategory?[indexPath.row].subcategories_name
            vc.Price = viewModel?.productSubCategory?[indexPath.row].price
            vc.quantity = viewModel?.productSubCategory?[indexPath.row].qty
            vc.descrip = viewModel?.productSubCategory?[indexPath.row].description
            vc.image = viewModel?.productSubCategory?[indexPath.row].image
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = ProductDetailVC()
            self.searchTF.text = ""
            vc.ProductDetail = viewModel?.productSubCategory?[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension ProductSubCategoryVC: ProductSubCategoryVMObserver{
    func ProductSubCategoryApi(postCount: Int) {
        if postCount == 0{
            collectionView.setBackgroundView(message: "No Product Found")
        }else{
            collectionView.backgroundView = nil
        }
        collectionView.reloadData()
    }
    
    
}
extension ProductSubCategoryVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            if self.timer != nil {
                self.timer?.invalidate()
                self.timer = nil
                
                if self.viewModel?.productSubCategory?.count ?? 0 > 0 {
                    self.viewModel?.productSubCategory?.removeAll()
                    self.collectionView.reloadData()
                }
            }
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.searchText(_:)), userInfo: updatedText, repeats: false)
        }
        return true
    }
    
    
    @objc func searchText(_ timer: Timer) {
        guard let searchKey = timer.userInfo as? String else { return }
        if searchKey.isEmpty{
            self.searchTF.text = ""
            self.viewModel?.productSubCategory?.removeAll()
            if "business" == UserDefaults.standard.string(forKey: "LoginType") {
                self.viewModel?.productSubCategoryListApi(productId: self.productID ?? "", name: "", subcatId: self.subCatID ?? "")
            } else if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
                viewModel?.productGuestSubCategoryListUserApi(name: "", subcatId: self.subCatID ?? "", dispensaryId: self.dispensaryId)
            } else{
                self.viewModel?.productSubCategoryListUserApi(name: "", subcatId: self.subCatID ?? "", dispensaryId: self.dispensaryId)
            }
            
            self.collectionView.setBackgroundView(message: "")
            self.collectionView.reloadData()
            //            self.searchTable.isHidden = true
        } else {
            if "business" == UserDefaults.standard.string(forKey: "LoginType") {
                self.viewModel?.productSubCategoryListApi(productId: self.productID ?? "", name: searchKey, subcatId: self.subCatID ?? "")
            } else if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
                viewModel?.productGuestSubCategoryListUserApi(name: searchKey, subcatId: self.subCatID ?? "", dispensaryId: self.dispensaryId)
            } else{
                self.viewModel?.productSubCategoryListUserApi(name: searchKey, subcatId: self.subCatID ?? "", dispensaryId: self.dispensaryId)
            }
            
            self.collectionView.reloadData()
            self.collectionView.setBackgroundView(message: "")
            //            self.searchTable.isHidden = false
        }
    }
}
