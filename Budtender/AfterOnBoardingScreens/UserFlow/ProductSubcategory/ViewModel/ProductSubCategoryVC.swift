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
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "ProductSubCategoryCVCell", bundle: nil), forCellWithReuseIdentifier: "ProductSubCategoryCVCell")
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductSubCategoryCVCell", for: indexPath) as! ProductSubCategoryCVCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 2), height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            let vc = BusinessDetailVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = ProductDetailVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
