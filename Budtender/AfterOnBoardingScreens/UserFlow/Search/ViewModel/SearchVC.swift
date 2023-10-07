//
//  SearchVC.swift
//  Budtender
//
//  Created by apple on 09/08/23.
//

import UIKit
class SearchVC: UIViewController{
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var searchTableView: UITableView!

    var timer: Timer?
    var viewModel: HomeDispensaryVM?
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearch.delegate = self
//        txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        self.searchTableView.register(UINib(nibName: "SearchTVCell", bundle: nil), forCellReuseIdentifier: "SearchTVCell")
        setViewModel()
    }
    
    func setViewModel(){
        self.viewModel = HomeDispensaryVM(observer: self)
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Function
    
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
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
//-------------------------------------------------------------------------------------------------------
//MARK: ExtensionTableView

extension SearchVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dispensary?.count ?? 0
//        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTVCell", for: indexPath) as! SearchTVCell
        cell.titleLabel.text = viewModel?.dispensary?[indexPath.row].name
        return cell
    }
}
extension SearchVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                if self.timer != nil {
                    self.timer?.invalidate()
                    self.timer = nil

                    if self.viewModel?.dispensary?.count ?? 0 > 0 {
                        self.viewModel?.dispensary?.removeAll()
                        self.searchTableView.reloadData()
                    }
                }
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.searchTextLocation(_:)), userInfo: updatedText, repeats: false)
            }
            return true
        }
    
    
    @objc func searchTextLocation(_ timer: Timer) {
        guard let searchKey = timer.userInfo as? String else { return }
        if searchKey.isEmpty{
            self.txtSearch.text = ""
            self.viewModel?.dispensary?.removeAll()
            self.searchTableView.setBackgroundView(message: "")
            self.searchTableView.reloadData()
//            self.searchTable.isHidden = true
        } else {
            viewModel?.homeDispensaryListApi(lat: "30.7046", long: "76.7179", search: searchKey)
            self.searchTableView.reloadData()
            self.searchTableView.setBackgroundView(message: "")
//            self.searchTable.isHidden = false
        }
    }
}
extension SearchVC: HomeDispensaryVMObserver{
    func HomeDispensaryApi(postCount: Int) {
        if postCount == 0{
            searchTableView.setBackgroundView(message: "No Dispensary yet!")
        }else{
            searchTableView.backgroundView = nil
            self.searchTableView.reloadData()
        }
        
    }
    
}
