//
//  GalleryVC.swift
//  meetwise
//
//  Created by Nitin Kumar on 23/07/21.
//  Copyright © 2021 Nitin Kumar. All rights reserved.
//

import UIKit
import Photos
import PhotosUI



protocol GalleryVCDelegate: NSObjectProtocol {
    func galleryController(_ gallery: GalleryVC, didselect videos: [AVURLAsset], assetIds: [String], localIdentifier: String)
    func galleryController(_ gallery: GalleryVC, didselect images: [PHAsset], assetIds: [String])
    func galleryControllerOpenCamera(_ gallery: GalleryVC)
}

class GalleryVC: UIViewController{
    
    @IBOutlet weak var titleNameButton: UIButton!
    @IBOutlet weak var selectNextButton: UIButton!
    @IBOutlet weak var tableView: GalleryAlbumTableView!
    @IBOutlet weak var collectionView: GalleryImagesCollectionView!
    @IBOutlet weak var selectAlbumButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableBackgroundView: UIView!
    
    
    
    lazy var assetIdentifiers: [String] = []
    lazy var isCameraOption: Bool = true
    lazy var maxSelection: Int = 10
    
    var delegate: GalleryVCDelegate?
    var pickerType: ImagePickerControllerType = .image
    var postImage:[PickerData] = []
    var imagepicker = ImagePicker()
    var is_createBlogs : Bool = false
    var postId:String?
  
    
    
    init(isCameraOption: Bool = true, delegate: GalleryVCDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.isCameraOption = isCameraOption
        self.delegate = delegate

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraAccess()
        
//        collectionView.assetIdentifiers = self.assetIdentifiers
//        collectionView.isCameraOption = isCameraOption
//        collectionView.galleryDelegate = self
//        tableView.galleryDelegate = self
//        tableBackgroundView.isHidden = true
////      scrollView.isScrollEnabled = false
//        let height = tableView.frame.height
//        self.tableView.transform = .init(translationX: 0, y: -height)
//        collectionView.setImageCollection(type: pickerType)
//        if is_createBlogs {
//            self.titleNameButton.setTitle("Create new blog", for: .normal)
//        } else {
//            self.titleNameButton.setTitle("Upload", for: .normal)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGalleryPermission()
        collectionView.maxSelection = self.maxSelection
    }
    
    func cameraAccess() {
        collectionView.assetIdentifiers = self.assetIdentifiers
        collectionView.isCameraOption = isCameraOption
        collectionView.galleryDelegate = self
        tableView.galleryDelegate = self
        tableBackgroundView.isHidden = true
//        doneButton.isEnabled = true
//        doneButton.isUserInteractionEnabled = true
//        scrollView.isScrollEnabled = false
        let height = tableView.frame.height
        self.tableView.transform = .init(translationX: 0, y: -height)
        collectionView.setImageCollection(type: pickerType)
    }
    
    private func setGalleryPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            self.cameraAccess()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                DispatchQueue.main.async {
                    if newStatus ==  PHAuthorizationStatus.authorized {
//                        self.present(imagePickerController, animated: true, completion: nil)
                        self.cameraAccess()
                    }else{
                        print("User denied")
                    }
                }})
            break
        case .restricted:
            print("restricted")
            break
        case .denied:
            print("denied")
            break
        case .limited:
            break
        @unknown default:
            break
        }
    }
    
    @IBAction func selectAlbumAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        let height = tableView.frame.height
        if sender.isSelected {
            self.tableView.transform = .init(translationX: 0, y: -height)
            self.tableBackgroundView.isHidden = false
        }
        UIView.animate(withDuration: 0.3) {
            if sender.isSelected {
                sender.imageView?.transform = .init(rotationAngle: CGFloat.pi)
                self.tableView.transform = .identity
            } else {
                sender.imageView?.transform = .identity
                self.tableView.transform = .init(translationX: 0, y: -height)
            }
        } completion: { ani in
            if !sender.isSelected {
                self.tableBackgroundView.isHidden = true
            }
        }
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectAction(_ sender: UIButton) {
        let assets = self.collectionView.images.map({$0.0})
        print("assets count are \(assets.count) \(delegate == nil)")
        if assets.count > 0 {
            self.delegate?.galleryController(self, didselect: assets, assetIds: self.collectionView.assetIdentifiers)
        } else {
            self.showMessage(message: "Please select atleast 1 item.", isError: .error)
        }
        
        /*let assets = self.collectionView.images.map({$0.0})
        if assets.first?.mediaType == .video,
            let asset = assets.first  {
            
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.version = .original
            PHImageManager.default().requestAVAsset(forVideo: asset, options: options, resultHandler: {(vidAsset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable : Any]?) -> Void in
                DispatchQueue.main.async {
//                    if let urlAsset = vidAsset as? AVURLAsset {
//                        let localVideoUrl: URL = urlAsset.url as URL
//                        let vc = CropImageVC()
//                        vc.iselectEdit = self.is_createBlogs
//                        vc.selected_images = assets
//                        vc.modalPresentationStyle = .overFullScreen
//                        self.pushViewController(vc, true)
//                        let vc = VideoTrimmerVC(url: localVideoUrl, delegate: self)
//                        vc.assetId = asset.localIdentifier
//                        self.present(vc, true)
//                    } else {
//                    }
                }
            })
        } else {
            self.delegate?.galleryController(self, didselect: assets, assetIds: self.collectionView.assetIdentifiers)
            if assets.count != 0 {
                let vc = CropImageVC()
                vc.iselectEdit = is_createBlogs
                vc.delegate = self
                vc.selected_images = assets
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            } else {
                self.showMessage(message: "Please select image", isError: .error)
            }
        }
        self.collectionView.clearSelection()
        self.selectItems(count: 0)*/
    }
    
}

extension GalleryVC : GalleryAlbumTableViewDelegate {
    func tableView(selection: GalleryAlbumTableView.Section, didSelect ablum: PHCollection?) {
        var title: String = ""
        switch selection {
        case .allPhotos:
            self.collectionView.fetchResult = GalleryModel(type: pickerType).allPhotos
            title = "All Photos"
        case .smartAlbums, .userCollections:
            if let assetCollection = ablum as? PHAssetCollection {
                title = assetCollection.localizedTitle ?? "Photos"
                
                let options = PHFetchOptions()
                options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                
                let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: pickerType.predicates)
                options.predicate = predicate
                
                let result = PHAsset.fetchAssets(in: assetCollection, options: options)
                self.collectionView.fetchResult = result
            }
        }
//        let height = tableView.frame.height
//        UIView.animate(withDuration: 0.3) { [self] in
//            selectAlbumButton.imageView?.transform = .identity
//            tableView.transform = .init(translationX: 0, y: -height)
//            selectAlbumButton.setTitle(title, for: .normal)
//        } completion: { ani in
//            self.selectAlbumButton.isSelected = false
//            self.tableBackgroundView.isHidden = true
//        }
    }
}

extension GalleryVC: GalleryImagesCollectionViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    func galleryOpenCamera() {
        print("open camera")
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let imagePickerController = UIImagePickerController()
//            imagePickerController.delegate = self
//            imagePickerController.sourceType = .camera
//            self.present(imagePickerController, animated: true, completion: nil)
//        }
        self.delegate?.galleryControllerOpenCamera(self)
    }
    
    func didSelect(item atIndex: IndexPath) {
        print("did Select image")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) { [weak self] in
            
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            
            let vc = CropImageVC()
            vc.iselectEdit = true
            vc.delegate = self
            vc.arrayimages = [image]
            vc.modalPresentationStyle = .overFullScreen
            self?.present(vc, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
}


//extension GalleryVC: VideoTrimmerVCDelegate {
//
//    func videoTrimmer(_ viewController: VideoTrimmerVC, didTrimVideo url:URL?, failedTrimming error: Error?) {
//        //        self.delegate?.galleryController(self, didselect: assets, assetIds: self.collectionView.assetIdentifiers)
//
//        if let url = url {
//            viewController.dismiss(animated: false) {
//                DispatchQueue.main.async {
//                    let asset = AVURLAsset(url: url)
//                    self.delegate?.galleryController(self, didselect: [asset], assetIds: self.collectionView.assetIdentifiers, localIdentifier: viewController.assetId)
//                }
//            }
//        }
//    }
//
//    func videoTrimmerDidCancel(_ viewController: VideoTrimmerVC) {
//
//    }
//}

extension GalleryVC: ImagePickerDelegate {
    
    func imagePicker(_ picker: ImagePicker, didSelect data: [PickerData]?, assetIds: [String]) {
        print("picked images are \n\n\(data?.count ?? 0) *** \n\n\(assetIds) \n\n")
        let ids = data?.map({$0.id ?? ""}) ?? []
        print("picked images are ids \n\n\(ids) \n\n")
        var postImages: [PickerData] = []
        assetIds.forEach { assetId in
            if let post = postImage.first(where: {$0.id == assetId}) {
                postImages.append(post)
            } else if let post = data?.first(where: {$0.id == assetId}) {
                postImages.append(post)
            } else if let post = postImage.first(where: {$0.imgUrlStr == assetId}) {
                postImages.append(post)
            }
        }
        
        print("post images are ******** \(postImages.count)")
        self.postImage = postImages
        self.collectionView.reloadData()
    }
    
    func imagePicker(_ picker: ImagePicker, didCapture data: PickerData?) {
        if let pickerData = data {
            if pickerData.id == nil || pickerData.id == "" {
                pickerData.id = pickerData.fileName
            }
            print("id is **** \(pickerData.id ?? "")")
            self.postImage.append(pickerData)
            self.collectionView.reloadData()
        }
    }
    
    func imagePicker(_ picker: ImagePicker, didFinish withError: ImagePicker.Error) {
        
    }
    
}


extension GalleryVC: CropImageVCDelegate {
    func didSelectImages(_ images: [UIImage]) {
//        let vc = EnterDetailVC()
//        vc.postId = self.postId
//        vc.selected_images = images
//        vc.iselectEdit = is_createBlogs
//        self.pushViewController(vc, true)
    }
    
}

