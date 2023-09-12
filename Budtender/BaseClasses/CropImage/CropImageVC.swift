//
//  CropImageVC.swift
//  Elisium
//
//  Created by Dharmani Apps on 08/07/22.
//

import UIKit
import Photos
//import QCropper

protocol CropImageVCDelegate {
    func didSelectImages(_ images: [UIImage])
}

class CropImageVC: UIViewController {
    
    @IBOutlet weak var selectNextButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imageBgView: UIView!
    @IBOutlet weak var cropimageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var pageController: UIPageViewController?
    var selected_images: [PHAsset]?
    var iselectEdit:Bool = true
    var arrayimages:[UIImage]?
    var delegate: CropImageVCDelegate?
    var image :UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCollectionCell()
        self.setupPageController()
        print("image    @@@@@@@@@@@@@@@@@    \(image)")
    }
    
    func setCollectionCell() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerCell(identifier: "UploadImageCollectionCell")
        collectionView.backgroundColor = .clear
        if let selected_images = self.selected_images {
            self.arrayimages = self.getAssetThumbnail(assets: selected_images)
            if let image = self.arrayimages?.first {
    //            self.setCropperController(image: image)
                self.cropimageView.image = image
            }
        }
        self.collectionView.reloadData()
    }

    //MARK: Convert array of PHAsset to UIImages
    func getAssetThumbnail(assets: [PHAsset]) -> [UIImage] {
        var arrayOfImages = [UIImage]()
        for asset in assets {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var image = UIImage()
            option.isSynchronous = true

            manager.requestImage(for: asset, targetSize: CGSize(width: 1000, height: 1000), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                image = result!
                arrayOfImages.append(image)
             
            })
        }
        return arrayOfImages
    }
    
    func setCropperController(image: UIImage, index:Int) {
        if self.pageController == nil {
            self.setupPageController()
        }
//        let cropper = CropperViewController(originalImage: image)
//        cropper.view.tag = index
//        cropper.delegate = self
//        self.pageController?.setViewControllers([cropper], direction: .forward, animated: false)
    }
    
    @IBAction func cameraAction(_ sender: UIButton) {
        galleryOpenCamera()
    }
    
   
    @IBAction func doneAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.didSelectImages(self.arrayimages ?? [])
        }
    }
    
}

extension CropImageVC: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayimages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadImageCollectionCell", for: indexPath) as? UICollectionViewCell else{return UICollectionViewCell()}
//        let image = self.arrayimages?[indexPath.item]
//        cell.uploadImage.image = image
////        cell.removeButton.tag = indexPath.item
////        cell.removeButton.addTarget(self, action: #selector(deletePost(_:)), for: .touchUpInside)
//        cell.removeButton.isHidden = true
//        cell.backgroundColor = .clear
//        cell.contentView.backgroundColor = .clear
//        cell.uploadImage.backgroundColor = .clear
        return cell
    }
    
    @objc func deletePost(_ sender: UIButton) {
        self.selected_images?.remove(at: sender.tag)
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let image = self.arrayimages?[indexPath.row] {
        debugPrint("thumbmnail images are \(image)")
            self.selectNextButton.isHidden = true
            self.setCropperController(image: image, index: indexPath.row)
        }
    }
    
}

//extension CropImageVC: CropperViewControllerDelegate {
//    func cropperDidConfirm(_ cropper: CropperViewController, state: CropperState?) {
//        let index = cropper.view.tag
//        self.selectNextButton.isHidden = false
//        print("tag is \(cropper.view.tag) \(state)")
//        if let state = state,
//           let image = cropper.originalImage.cropped(withCropperState: state) {
//            self.cropimageView.image = image
//            self.arrayimages?[index] = image
//        } else {
//            print("Something went wrong")
//        }
//        self.removePageController()
//    }
//
//}


extension CropImageVC {

    private func setupPageController() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.view.backgroundColor = .clear
        self.pageController?.view.frame = CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        self.addChild(self.pageController!)
        self.pageController!.view.frame = self.imageBgView.bounds
        self.imageBgView.addSubview(self.pageController!.view)
        self.pageController?.didMove(toParent: self)
        self.pageController?.view.backgroundColor = .clear
    }
    
    private func removePageController() {
        guard self.pageController != nil else { return }
        self.pageController?.view.removeFromSuperview()
        self.pageController = nil
    }
    
    
}

extension CropImageVC: GalleryImagesCollectionViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    func didSelect(item atIndex: IndexPath) {
        
    }
    
    func selectItems(count: Int) {
        if count == 0 {
            selectNextButton.setTitle("Next", for: .normal)
            selectNextButton.setTitleColor(UIColor(hexString: "#5F676D"), for: .normal)
        } else {
            selectNextButton.setTitle("Next(\(count))", for: .normal)
            selectNextButton.setTitleColor(UIColor(hexString: "#3E53A3"), for: .normal)
        }
    }
    
    func galleryOpenCamera() {
        print("open camera")
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) { [weak self] in
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            self?.arrayimages?.append( image)
            self?.collectionView.reloadData()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
