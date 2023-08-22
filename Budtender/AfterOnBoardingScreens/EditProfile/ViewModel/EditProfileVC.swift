//
//  EditProfileVC.swift
//  Budtender
//
//  Created by apple on 22/08/23.
//

import UIKit
class EditProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    
    var imagePickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func validation() {
        if txtFirstName.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankFirstName, view: self)
        }else if txtFirstName?.isValidUserName() == false {
            Budtender.showAlert(title: Constants.AppName, message: Constants.validName, view: self)
        }else if txtLastName.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankLastName, view: self)
        }else if txtLastName?.isValidUserName() == false {
            Budtender.showAlert(title: Constants.AppName, message: Constants.validName, view: self)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileImage.image  = tempImage
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editPhotoAction(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Camera", style: .default){ [self] action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera;
                imagePickerController.allowsEditing = true
                self.imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Camera not found", message: "This device has no camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default,handler: nil))
                present(alert, animated: true,completion: nil)
            }
        }
        let action1 = UIAlertAction(title: "Gallery", style: .default){ action in
            self.imagePickerController.allowsEditing = false
            self.imagePickerController.sourceType = .photoLibrary
            self.imagePickerController.delegate = self
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
       // validation()
        
    }
    
}
