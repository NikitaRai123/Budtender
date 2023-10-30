//
//  ClusterAnnotationView.swift
//  Budtender
//
//  Created by apple on 10/30/23.
//


import MapKit
import UIKit

class ClusterAnnotationView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        didSet {
            guard let cluster = annotation as? MKClusterAnnotation else { return }
            displayPriority = .defaultHigh
            
            let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
            image = UIGraphicsImageRenderer.image(for: cluster.memberAnnotations, in: rect)
        }
    }

}


class MapItemAnnotationView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        didSet {
            guard let mapItem = annotation as? MapItem else { return }
            clusteringIdentifier = "MapItem"
            image = mapItem.image
        }
    }
}

class MapItem: NSObject, MKAnnotation {
    enum ItemType: UInt32 {
        case green = 0
        case orange = 1
        
        var image: UIImage {
            switch self {
            case .green:
                return #imageLiteral(resourceName: "annotation")
            case .orange:
                return #imageLiteral(resourceName: "annotation_orange")
            }
        }
    }
    
    let coordinate: CLLocationCoordinate2D
    let itemType: ItemType
    var image: UIImage { return itemType.image }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.itemType = ItemType(rawValue: arc4random_uniform(2)) ?? .green
    }
}


extension UIGraphicsImageRenderer {
    static func image(for annotations: [MKAnnotation], in rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        
        let totalCount = annotations.count
        let orangeCount = annotations.orangeCount
        
        let countText = "\(totalCount)"
        
        return renderer.image { _ in
            UIColor(red: 126 / 255.0, green: 211 / 255.0, blue: 33 / 255.0, alpha: 1.0).setFill()
            UIBezierPath(ovalIn: rect).fill()
            
            UIColor(red: 245 / 255.0, green: 166 / 255.0, blue: 35 / 255.0, alpha: 1.0).setFill()
            let piePath = UIBezierPath()
            piePath.addArc(withCenter: CGPoint(x: 20, y: 20), radius: 20,
                           startAngle: 0, endAngle: (CGFloat.pi * 2.0 * CGFloat(orangeCount)) / CGFloat(totalCount),
                           clockwise: true)
            piePath.addLine(to: CGPoint(x: 20, y: 20))
            piePath.close()
            piePath.fill()
            
            UIColor.white.setFill()
            UIBezierPath(ovalIn: CGRect(x: 8, y: 8, width: 24, height: 24)).fill()
            
            countText.drawForCluster(in: rect)
        }
    }
}

extension Sequence where Element == MKAnnotation {
    var orangeCount: Int {
        return self
            .compactMap { $0 as? MapItem }
            .filter { $0.itemType == .orange}
            .count
    }
}

extension String {
    func drawForCluster(in rect: CGRect) {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        let textSize = self.size(withAttributes: attributes)
        let textRect = CGRect(x: (rect.width / 2) - (textSize.width / 2), y: (rect.height / 2) - (textSize.height / 2), width: textSize.width, height: textSize.height)
        self.draw(in: textRect, withAttributes: attributes)
    }
}



class UserClusterAnnotationView: MKAnnotationView {
    let size: CGFloat = 35
    var textBackgroundColor: UIColor = .aquaBlue
    var textBorderColor: UIColor = .white
    var textColor: UIColor = .white
    
    static let identifier = Bundle.main.bundleIdentifier! + ".UserClusterAnnotationView"

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        collisionMode = .circle
        updateImage()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override var annotation: MKAnnotation? { didSet { updateImage() } }

    private func updateImage() {
        if let clusterAnnotation = annotation as? MKClusterAnnotation {
            let text = "\(clusterAnnotation.memberAnnotations.count)"
            self.image = text.image(borderColor: textBorderColor, backgroundColor: textBackgroundColor, textColor: textColor, size: size)
        } else {
            print("cluster annotation 1 ** \(1)")
            self.image = "1".image(borderColor: textBorderColor, backgroundColor: textBackgroundColor, textColor: textColor, size: size)
        }
    }

}




extension String {
    
    func image(borderColor: UIColor, backgroundColor: UIColor, textColor:UIColor, size: CGFloat) -> UIImage {
        let count: String = self
        let bounds = CGRect(origin: .zero, size: CGSize(width: size, height: size))

        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { _ in
            // Fill full circle with tricycle color
            borderColor.setFill()
            UIBezierPath(ovalIn: bounds).fill()

            // Fill inner circle with white color
            backgroundColor.setFill()
            UIBezierPath(ovalIn: bounds.insetBy(dx: 2, dy: 2)).fill()

            // Finally draw count text vertically and horizontally centered
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: textColor,
                .font: UIFont.boldSystemFont(ofSize: 15)
            ]

            let text = "\(count)"
            let size = text.size(withAttributes: attributes)
            let origin = CGPoint(x: bounds.midX - size.width / 2, y: bounds.midY - size.height / 2)
            let rect = CGRect(origin: origin, size: size)
            text.draw(in: rect, withAttributes: attributes)
        }
    }
}
