//
//  ProductVC.swift
//  Budtender
//
//  Created by apple on 11/08/23.
//

import UIKit
import SideMenu
class ProductVC: UIViewController,UITextFieldDelegate {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var firstCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    //-------------------------------------------------------------------------------------------------------
    //MARK: Variables
    
    var textArray = ["Vape pens","Flower/Bud","Concentrates","Edibles","CBD"]
    
    var viewModel: AddProductVM?
    var selectedIndex:IndexPath? = IndexPath(row: 0, section: 0)
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstCollectionView.delegate = self
        self.firstCollectionView.dataSource = self
        self.firstCollectionView.register(UINib(nibName: "FirstCVCell", bundle: nil), forCellWithReuseIdentifier: "FirstCVCell")
        self.firstCollectionView.reloadData()
        self.secondCollectionView.delegate = self
        self.secondCollectionView.dataSource = self
        self.secondCollectionView.register(UINib(nibName: "SecondCVCell", bundle: nil), forCellWithReuseIdentifier: "SecondCVCell")
        self.secondCollectionView.reloadData()
        
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        print(UserDefaultsCustom.getAccessToken())
        setViewModel()
        viewModel?.productListApi()
        viewModel?.subCategoryListApi(id: "7")
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        print("token === \(UserDefaultsCustom.getAccessToken())")
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            addButton.isHidden = false
            backButton.setImage(UIImage(named: "Ic_SideBar"), for: .normal)
            viewModel?.productListApi()
        }
        else{
            addButton.isHidden = true
            backButton.setImage(UIImage(named: "Ic_Back"), for: .normal)
        }
    }
    
    func setViewModel(){
        self.viewModel = AddProductVM(observer: self)
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Functions
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateCrossButtonVisibility()
    }
    func updateCrossButtonVisibility() {
        crossButton.isHidden = false
        crossButton.isHidden = txtSearch.text?.isEmpty ?? true
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func crossAction(_ sender: UIButton) {
        txtSearch.text = ""
        crossButton.isHidden = true
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            let vc = ProfileVC()
                let menu = SideMenuNavigationController(rootViewController: vc)
                menu.leftSide = true
                menu.presentationStyle = .menuSlideIn
                menu.menuWidth = UIScreen.main.bounds.width - 80
                menu.blurEffectStyle = UIBlurEffect.Style.dark
                present(menu, animated: true, completion: nil)
            }
    else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func filterAction(_ sender: UIButton) {
        let vc = FilterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        let vc = BusinessAddProductVC()
        vc.comefrom = "AddProduct"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//-------------------------------------------------------------------------------------------------------
//MARK: ExtensionsTableView

extension ProductVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.firstCollectionView{
            print(viewModel?.category?.count)
            return viewModel?.category?.count ?? 0
//            return textArray.count
        }
        else if collectionView == self.secondCollectionView{
            return viewModel?.subCategory?.count ?? 0
//            return 10
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.firstCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCVCell", for: indexPath) as! FirstCVCell
            cell.titleLabel.text = viewModel?.category?[indexPath.row].category_name
//            cell.titleLabel.text = "\(textArray[indexPath.row])"
            if indexPath == selectedIndex{
                cell.bgView.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2980392157, blue: 0.1725490196, alpha: 1)
                cell.bgView.borderColor = #colorLiteral(red: 0.2196078431, green: 0.2980392157, blue: 0.1725490196, alpha: 1)
                cell.titleLabel.textColor = .white
            }else{
                cell.bgView.backgroundColor = .clear
                cell.bgView.borderColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
                cell.titleLabel.textColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
            }
            return cell
        }
        
        else if collectionView == self.secondCollectionView{
            let cell = secondCollectionView.dequeueReusableCell(withReuseIdentifier: "SecondCVCell", for: indexPath) as! SecondCVCell
            cell.productImage.setImage(image: viewModel?.subCategory?[indexPath.row].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
            cell.productNameLabel.text = viewModel?.subCategory?[indexPath.row].name
            return cell
            
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.firstCollectionView{
            let text = viewModel?.category?[indexPath.item].category_name
            print(text)
            return CGSize(width: (text?.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)]).width ?? 0) + 15, height: 30)
//            return CGSize(width: textArray[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)]).width + 15, height: 30)
            
            }
        
        else{
            return CGSize(width: (collectionView.frame.size.width / 2), height: 290)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.firstCollectionView{
            self.selectedIndex = indexPath
            let id = "\(viewModel?.category?[indexPath.item].category_id ?? 0)"
            print(id)
            viewModel?.subCategoryListApi(id: id)
            self.firstCollectionView.reloadData()
            self.secondCollectionView.reloadData()
            }
        else{
            let vc = ProductSubCategoryVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension ProductVC : AddProductVMObserver{
    func productCategoryApi() {
        self.secondCollectionView.reloadData()
        self.firstCollectionView.reloadData()
        
    }
    
    func createProductAPI() {
//        <#code#>
    }
    
    
}
