//
//  AnnotationView.swift
//  Budtender
//
//  Created by apple on 10/30/23.
//


import MapKit
import Kingfisher


class AnnotationView: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = UserClusterAnnotationView.identifier
        collisionMode = .circle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            clusteringIdentifier = UserClusterAnnotationView.identifier
        }
    }
    
    var placeholder: UIImage? {
        get {
            self.annotation?.title??.image(borderColor: .white, backgroundColor: .aquaBlue, textColor: .white, size: size)
        }
    }
    
    var imageURLString: String? {
        didSet {
            self.didSetImage()
        }
    }
    let size: CGFloat = 35
    
    func didSetImage() {
        guard let urlString = self.imageURLString else {
            self.image = placeholder
            return
        }
        guard let urlStringNew = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            self.image = placeholder
            return
        }
        guard let url = URL(string: urlStringNew) else {
            self.image = placeholder
            return }
        if let image = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: urlString) {
            self.image = image.roundedImage(with: size, borderColor: .white)
        } else {
            KingfisherManager.shared.retrieveImage(with: url) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(_):
                        self.image = self.placeholder
                    case .success(let img):
                        self.image = img.image.roundedImage(with: self.size, borderColor: .white)
                    }
                }
            }
        }
    }
    
}


class PointAnnotation: MKPointAnnotation {
//    var tripDetails: HomeVCDataModel?
//    var diaryTripDetails: DiaryPostDetailsData?
}
