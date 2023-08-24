//
//  ProductVC.swift
//  Budtender
//
//  Created by apple on 11/08/23.
//

import UIKit
class ProductVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var firstCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
  
    var textArray = ["Vape pens","Flower/Bud","Concentrates","Edibles","CBD"]
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
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateCrossButtonVisibility()
    }
    func updateCrossButtonVisibility() {
        crossButton.isHidden = false
        crossButton.isHidden = txtSearch.text?.isEmpty ?? true
    }
    @IBAction func crossAction(_ sender: UIButton) {
        txtSearch.text = ""
        crossButton.isHidden = true
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterAction(_ sender: UIButton) {
        
        let vc = FilterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProductVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.firstCollectionView{
            return textArray.count
        }
        else if collectionView == self.secondCollectionView{
            return 10
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.firstCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCVCell", for: indexPath) as! FirstCVCell
            cell.titleLabel.text = "\(textArray[indexPath.row])"
            return cell
        }
        else if collectionView == self.secondCollectionView{
            let cell = secondCollectionView.dequeueReusableCell(withReuseIdentifier: "SecondCVCell", for: indexPath) as! SecondCVCell
//            cell1.gunImage.image = UIImage(named: secondCV[indexPath.row].0)
//            cell1.gunAmount.text = "\(secondCV[indexPath.row].1)"
//            cell1.gunNameView.isHidden = true
              return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.firstCollectionView{
//            return CGSize(width: collectionView.frame.width , height: 30)
//            let label = UILabel(frame: CGRect.zero)
//            label.text = textArray[indexPath.item]
//            label.sizeToFit()
//            return CGSize(width: label.frame.height, height: 30)
            return CGSize(width: textArray[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)]).width + 15, height: 30)
            
            }
        
        else{
            return CGSize(width: (collectionView.frame.size.width / 2), height: 270)
        }
       // return CGSize(width: 0, height: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.firstCollectionView{
            let cell = collectionView.cellForItem(at: indexPath) as? FirstCVCell
            cell?.bgView.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2980392157, blue: 0.1725490196, alpha: 1)
            cell?.bgView.borderColor = #colorLiteral(red: 0.2196078431, green: 0.2980392157, blue: 0.1725490196, alpha: 1)
            cell?.titleLabel.textColor = .white
            }
        else{
            let vc = ProductSubCategoryVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == self.firstCollectionView{
            let cell = collectionView.cellForItem(at: indexPath) as? FirstCVCell
            cell?.bgView.backgroundColor = .clear
            cell?.bgView.borderColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
            cell?.titleLabel.textColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
            
        }
        else{}
    }
}
