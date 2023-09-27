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
    
    var subCatID: String?
    var productID: String?
    var viewModel: ProductSubCategoryVM?
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "ProductSubCategoryCVCell", bundle: nil), forCellWithReuseIdentifier: "ProductSubCategoryCVCell")
        print("\(subCatID)\(productID)")
        setViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.productSubCategoryListApi(productId: self.productID ?? "", name: "", subcatId: self.subCatID ?? "")
    }
    
    func setViewModel(){
        self.viewModel = ProductSubCategoryVM(observer: self)
    }
    
  
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
        cell.productNameLabel.text = viewModel?.productSubCategory?[indexPath.row].product_name
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
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension ProductSubCategoryVC: ProductSubCategoryVMObserver{
    func ProductSubCategoryApi(postCount: Int) {
        if postCount == 0{
            collectionView.setBackgroundView(message: "Not Data Found")
        }else{
            collectionView.reloadData()
        }
    }
    
    
}
