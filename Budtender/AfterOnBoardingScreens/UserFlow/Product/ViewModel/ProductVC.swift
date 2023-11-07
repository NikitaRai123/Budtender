//
//  ProductVC.swift
//  Budtender
//
//  Created by apple on 11/08/23.
//

import UIKit
import SideMenu

class ProductVC: UIViewController{
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var firstCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    //-------------------------------------------------------------------------------------------------------
    //MARK: Variables
    
    var textArray = ["Vape pens","Flower/Bud","Concentrates","Edibles","CBD"]
    
    var isUSerSelected: Bool?
    var viewModel: AddProductVM?
    var dispensaryId: String = ""
    var timer: Timer?
    var subCatID: String?
    var productID: String?
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
        //        viewModel?.productListApi()
        //        selectedIndex = IndexPath(row: 0, section: 0)
        //        viewModel?.subCategoryListApi(id: "7")
        //        self.subCatID = "7"
        self.firstCollectionView.reloadData()
        self.secondCollectionView.reloadData()
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        //        if isUSerSelected == true{
        //            self.firstCollectionView.isHidden = true
        //            self.viewHeight.constant = 120
        //        }
        
        print("token === \(UserDefaultsCustom.getAccessToken())")
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            addButton.isHidden = false
            backButton.setImage(UIImage(named: "Ic_SideBar"), for: .normal)
            viewModel?.productListApi()
            selectedIndex = IndexPath(row: 0, section: 0)
            viewModel?.subCategoryListApi(id: "7")
            viewModel?.dispensaryListApi(isStatus: "1")
            self.subCatID = "7"
        } else if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
            viewModel?.productGuestListApi()
            selectedIndex = IndexPath(row: 0, section: 0)
            viewModel?.subCategoryGuestListApi(id: "7", name: "")
//            viewModel?.dispensaryListApi(isStatus: "2")
            self.subCatID = "7"
            addButton.isHidden = true
        } else {
            viewModel?.productListApi()
            selectedIndex = IndexPath(row: 0, section: 0)
            selectedIndex = IndexPath(row: 0, section: 0)
            viewModel?.subCategoryListApi(id: "7")
            viewModel?.dispensaryListApi(isStatus: "2")
            self.subCatID = "7"
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
        //        updateCrossButtonVisibility()
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
        if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
            let alertController = UIAlertController(title: "Alert", message: "Please login to use this functionality", preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let actionLogin = UIAlertAction(title: "Login", style: .default) {_ in
                let vc = LoginTypeVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            alertController.addAction(actionLogin)
            alertController.addAction(actionCancel)
            present(alertController, animated: true, completion: nil)
        } else {
            let vc = FilterVC()
            vc.dispensaryId = self.dispensaryId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        if viewModel?.dispensaryData?.count == 0{
            showMessage(message: "Please add dispensary first", isError: .error)
        } else {
            let vc = BusinessAddProductVC()
            vc.comefrom = "AddProduct"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
//-------------------------------------------------------------------------------------------------------
//MARK: ExtensionsTableView

extension ProductVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        if collectionView == self.firstCollectionView {
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
        } else if collectionView == self.secondCollectionView {
            let cell = secondCollectionView.dequeueReusableCell(withReuseIdentifier: "SecondCVCell", for: indexPath) as! SecondCVCell
            cell.productImage.setImage(image: viewModel?.subCategory?[indexPath.row].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
            cell.productNameLabel.text = viewModel?.subCategory?[indexPath.row].name
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.firstCollectionView {
            let text = viewModel?.category?[indexPath.item].category_name
            print(text)
            return CGSize(width: (text?.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)]).width ?? 0) + 15, height: 30)
            //            return CGSize(width: textArray[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)]).width + 15, height: 30)
        } else {
            return CGSize(width: (collectionView.frame.size.width / 2), height: 290)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.firstCollectionView{
            self.selectedIndex = indexPath
            let id = "\(viewModel?.category?[indexPath.item].category_id ?? 0)"
            print(id)
            self.subCatID = id
            UserDefaults.standard.set(viewModel?.category?[indexPath.item].category_id, forKey: "Category_id")
            if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
                viewModel?.subCategoryGuestListApi(id: id, name: "")
            } else {
                viewModel?.subCategoryListApi(id: id)
            }
            self.firstCollectionView.reloadData()
            self.secondCollectionView.reloadData()
        } else {
            let vc = ProductSubCategoryVC()
            self.txtSearch.text = ""
            vc.dispensaryId = self.dispensaryId
            vc.subcatName = viewModel?.subCategory?[indexPath.row].name
            vc.subCatID = "\(viewModel?.subCategory?[indexPath.row].subcat_id ?? 0)"
            vc.productID = "\(viewModel?.subCategory?[indexPath.row].subcat_id ?? 0)"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ProductVC : AddProductVMObserver {
    func searchHomeApi(postCount: Int) {
        if postCount == 0{
            secondCollectionView.setBackgroundView(message: "No data found")
        }else{
            secondCollectionView.reloadData()
        }
    }
    
    func dispensaryListApi() {
        //        <#code#>
    }
    
    func productCategoryApi() {
        self.secondCollectionView.reloadData()
        self.firstCollectionView.reloadData()
        
    }
    
    func createProductAPI() {
        //        <#code#>
    }
    
    
}


extension ProductVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            if self.timer != nil {
                self.timer?.invalidate()
                self.timer = nil
                
                if self.viewModel?.subCategory?.count ?? 0 > 0 {
                    self.viewModel?.subCategory?.removeAll()
                    self.secondCollectionView.reloadData()
                }
            }
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.searchTextHome(_:)), userInfo: updatedText, repeats: false)
        }
        return true
    }
    
    
    @objc func searchTextHome(_ timer: Timer) {
        guard let searchKey = timer.userInfo as? String else { return }
        if searchKey.isEmpty{
            self.txtSearch.text = ""
            self.viewModel?.subCategory?.removeAll()
            if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
                viewModel?.subCategoryGuestListApi(id: self.subCatID ?? "", name: "")
            } else {
                self.viewModel?.homeSearchListApi(id: self.subCatID ?? "", name: "")
            }
            self.secondCollectionView.setBackgroundView(message: "")
            self.secondCollectionView.reloadData()
            //            self.searchTable.isHidden = true
        } else {
            print("\(self.subCatID)\(self.productID)")
            if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
                viewModel?.subCategoryGuestListApi(id: self.subCatID ?? "", name: searchKey)
            } else {
                self.viewModel?.homeSearchListApi(id: self.subCatID ?? "", name: searchKey)
            }
            self.secondCollectionView.reloadData()
            self.secondCollectionView.setBackgroundView(message: "")
            //            self.searchTable.isHidden = false
        }
    }
}
