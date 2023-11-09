//
//  BusinessDetailVC.swift
//  Budtender
//
//  Created by apple on 28/08/23.
//

import UIKit
class BusinessDetailVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var imageDetailLabel: UILabel!
    @IBOutlet weak var productAmountLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var subCatLAbel: UILabel!
    
    var productNAme: String?
    var brandName: String?
    var quantity: String?
    var Price: String?
    var subCatNAme: String?
    var weight: String?
    var descrip: String?
    var image: String?
    var id: String?
    var viewModel: BusinessDetailVM?
    var ProductDetail: ProductSubCategoryData?
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setData()
    }
    
    func setData(){
        self.productImage.setImage(image: self.image,placeholder: UIImage(named: "dispensaryPlaceholder"))
        self.imageDetailLabel.text = "\(self.productNAme ?? "")\(" ") - \(self.brandName ?? "")\(" ") (\(self.weight ?? ""))"
        self.subCatLAbel.text = self.subCatNAme
        self.productAmountLabel.text = "\("$")\(self.Price ?? "")"
        self.quantityLabel.text = self.quantity
        self.discriptionLabel.text = self.descrip
    }
    
    func setViewModel(){
        self.viewModel = BusinessDetailVM(observer: self)
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        let vc = BusinessEditPopUpVC()
        vc.productId = Int(id ?? "")
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.navigationController?.present(vc, true)
    }
}
//-------------------------------------------------------------------------------------------------------
//MARK: ButtonActionFromProtocolDelegate

extension BusinessDetailVC: BusinessEditPopUpVCDelegate{
    func didTapdeleteButton(ProductID: Int) {
        print("Delete Successfully")
        self.dismiss(animated: true)
        print(id)
        let vc = DeletePopUpVC()
        vc.delegate = self
        vc.productId = ProductID
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, true)
//        viewModel?.productDeleteApi(Id: self.id ?? "")
//        self.dismiss(animated: true)
    }
    
    func didTapdeleteButton(_ button: UIButton, dispensaryID: Int) {
       
    }
    
    func didTapeditButton(_ button: UIButton) {
        dismiss(animated: true)
        let vc = BusinessAddProductVC()
        vc.productID = self.id
        vc.ProductDetail = self.ProductDetail
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapdeleteButton(_ button: UIButton) {
        dismiss(animated: true)
        let vc = DeletePopUpVC()
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, true)
    }
    
    func didTapcancelbutton(_ button: UIButton) {
        dismiss(animated: true)
    }
}

extension BusinessDetailVC: DeletePopUpVCDelegate{
    func deleteProduct(productID: Int) {
        print(productID)
        viewModel?.productDeleteApi(Id: self.id ?? "")
    }
    
    func delete(dispensaryID: Int) {
      
    }
    
    
}
extension BusinessDetailVC: BusinessDetailVMObserver{
    func observerDeleteProduct() {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
  
}
