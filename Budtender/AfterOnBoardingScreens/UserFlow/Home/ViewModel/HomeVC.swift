//
//  HomeVC.swift
//  Budtender
//
//  Created by apple on 09/08/23.
//

import UIKit
import MapKit
import SideMenu
import GoogleMaps
import GooglePlaces
import CoreLocation

class HomeVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var swipeNearByDispensaryView: UIView!
    @IBOutlet weak var DispensaryView: UIView!
    @IBOutlet weak var dispensaryViewHeight: NSLayoutConstraint!
    @IBOutlet weak var locationBtn: UIButton!
    
    //MARK: Properties
    var viewModel: HomeDispensaryVM?
    var selectedIndex: Int?
    var cityName: String?
    var lat: String?
    var long: String?
    let locationManager = CLLocationManager()
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        setViewModel()
        getUserLocation()
        setMapView()
        addGestureOnView()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    func setViewModel() {
        if self.viewModel == nil {
            self.viewModel = HomeDispensaryVM(observer: self)
        }
    }
    
    fileprivate func setTableView() {
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.homeTableView.registerCell(identifier: "HomeTVCell")
        self.homeTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    func addGestureOnView() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownView))
        swipeGesture.direction = .down
        self.DispensaryView.addGestureRecognizer(swipeGesture)
        
        let swipeGesture02 = UISwipeGestureRecognizer(target: self, action: #selector(swipeTopView))
        swipeGesture02.direction = .up
        self.DispensaryView.addGestureRecognizer(swipeGesture02)
    }
    
    
    @objc func swipeTopView() {
        //do hidingAnimatione
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.DispensaryView.transform = .identity
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func swipeDownView() {
        //do hidingAnimation
        let height = self.DispensaryView.frame.height-53
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.DispensaryView.transform = .init(translationX: 0, y: height)
            self.view.layoutIfNeeded()
        }
    }
    
    
    func setMapView() {
        mapView.delegate = self
        mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: "AnnotationView")
        mapView.register(UserClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: UserClusterAnnotationView.identifier)
    }
    
    
    func checkLocationServices() {
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                self.mapView.showsUserLocation = true
                self.centerViewOnUserLocation()
            } else {
                ShowBanner.show(title: "Please enable location services for this app.")
            }
            
        }
    }
    
    
    func getUserLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func centerViewOnUserLocation() {
        let loc = CLLocationCoordinate2D(latitude: Double(self.lat ?? "") ?? 0.0, longitude: Double(self.long ?? "") ?? 0.0)
        let region = MKCoordinateRegion(center: loc, latitudinalMeters: 30000, longitudinalMeters: 30000)
        mapView.setRegion(region, animated: true)
    }
    
    func showLocationSearch() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        autocompleteController.placeFields = .coordinate
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func mapPins(pinsArray: [MKAnnotation]) {
        if mapView.annotations.count != 0 {
            for annotation in mapView.annotations {
                mapView.removeAnnotation(annotation)
            }
        }
        pinsArray.forEach { annotation in
            mapView.addAnnotations(pinsArray)
        }
        mapView.showAnnotations(pinsArray, animated: true)
        centerViewOnUserLocation()
    }
    
    @IBAction func selectStateAction(_ sender: UIButton) {
        self.showLocationSearch()
    }
    
    @IBAction func locationAction(_ sender: UIButton) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        let fields: GMSPlaceField = [.addressComponents, .coordinate, .formattedAddress]
        autocompleteController.placeFields = fields
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        let vc = SearchVC()
        vc.lat = self.lat
        vc.long = self.long
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sideBarAction(_ sender: UIButton) {
        let vc = ProfileVC()
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.leftSide = true
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = UIScreen.main.bounds.width - 80
        menu.blurEffectStyle = UIBlurEffect.Style.dark
        present(menu, animated: true, completion: nil)
    }
    
    
}

// MARK:  LOCATION SEARCH DELEGATE
extension HomeVC: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.lat = "\(place.coordinate.latitude)"
        self.long = "\(place.coordinate.longitude)"
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: place.coordinate.latitude, longitude:  place.coordinate.longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in
            placemarks?.forEach { (placemark) in
                
                if let city = placemark.locality,
                   let name = placemark.name {
                    print(city)
                    self.locationBtn.setTitle("\(name) \(city)", for: .normal)
                }
            }
        })
        if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
            self.viewModel?.homeGuestDispensaryListApi(lat: self.lat ?? "", long: self.long ?? "", search: "")
        } else {
            self.viewModel?.homeDispensaryListApi(lat: self.lat ?? "", long: self.long ?? "", search: "")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}


// MARK:   CURRENT LOCATION DELEGATE
extension HomeVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let placeLocation = locations.last else {
            return
        }
        self.locationManager.stopUpdatingLocation()
        
        // Use the location's latitude and longitude
        let latitude = placeLocation.coordinate.latitude
        let longitude = placeLocation.coordinate.longitude
        
        // Now you have the current latitude and longitude
        print("Latitude: \(latitude), Longitude: \(longitude)")
        
        
        self.lat = "\(placeLocation.coordinate.latitude)"
        self.long = "\(placeLocation.coordinate.longitude)"
        
        // Use reverse geocoding to get the place name
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard let placemark = placemarks?.first else {
                print("Error in reverse geocoding: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Here you can access the place name and other address information
            if let placeName = placemark.name {
                print("Place Name: \(placeName)")
            }
            if let city = placemark.locality {
                print("City: \(city)")
                self.cityName = city
                self.locationBtn.setTitle(self.cityName, for: .normal)
            }
            
            self.checkLocationServices()
#if targetEnvironment(simulator)
            self.viewModel?.homeDispensaryListApi(lat: "30.7046", long: "76.7179", search: "")
#else
            if "guest" == UserDefaults.standard.string(forKey: "LoginType") {
                self.viewModel?.homeGuestDispensaryListApi(lat: self.lat ?? "", long: self.long ?? "", search: "")
            } else {
                self.viewModel?.homeDispensaryListApi(lat: self.lat ?? "", long: self.long ?? "", search: "")
            }

#endif
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization")
    }
}





// MARK:  MKMap View DELEGATE

extension HomeVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("view for annotation")
        let reuseId = "AnnotationView"
        if let annotation = annotation as? MKClusterAnnotation {
            let anView = mapView.dequeueReusableAnnotationView(withIdentifier: UserClusterAnnotationView.identifier, for: annotation) as! UserClusterAnnotationView
            anView.canShowCallout = true
            anView.annotation = annotation
            anView.rightCalloutAccessoryView = UIButton(type:.detailDisclosure)
            return anView
        } else {
            let anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId, for: annotation) as! AnnotationView
            //            anView.placeholder = UIImage(named: "ic_green_home")
            if let annotation = annotation as? PointAnnotation {
                //                let postedStuff = annotation.tripDetails?.image ?? ""
                anView.imageURLString = annotation.tripDetails?.image
            } else {
                anView.imageURLString = nil
            }
            anView.canShowCallout = true
            anView.annotation = annotation
            anView.rightCalloutAccessoryView = UIButton(type:.detailDisclosure)
            return anView
        }
    }
    
    func getImageForAnnotation(_ annotation: MKAnnotation) -> HomeDispensaryData? {
        if let annotation = annotation as? PointAnnotation {
            return annotation.tripDetails
        }
        let data = self.viewModel?.dispensary ?? []
        let lat = annotation.coordinate.latitude
        let lng = annotation.coordinate.longitude
        let first = data.first(where: {$0.latitude?.toDouble == lat && $0.longitude?.toDouble == lng})
        return first
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MKClusterAnnotation {
            print("count= \(annotation.memberAnnotations.count)")
            
            var details: [HomeDispensaryData] = []
            annotation.memberAnnotations.forEach { member in
                print("member \(member.title ?? "")")
                if let trip = (member as? PointAnnotation)?.tripDetails {
                    details.append(trip)
                }
            }
            
            var _details:[HomeDispensaryData] = []
            self.viewModel?.dispensary?.forEach({ data in
                if details.contains(where: {$0.id == data.id}) {
                    _details.append(data)
                }
            })
            
            var menuActions:[UIAction] = []
            
            _details.forEach { disp in
                print("trip details \(disp.name) ** \(disp.id)")
                let action = UIAction(title: disp.name?.capitalized ?? "", image: nil) { (action) in
                    let vc = DetailVC()
                    vc.DetailData = disp
                    vc.productDetails = disp.product_details
                    vc.dispensaryTime = disp.dispensorytime
                    self.pushViewController(vc, true)
                    
                    
                }
                menuActions.append(action)
            }
            
            let integer = annotation.memberAnnotations.count
            let formatter = NumberFormatter()
            formatter.numberStyle = NumberFormatter.Style.spellOut
            let spellOutText = formatter.string(for: integer)!
            print(spellOutText)
            
            let menuTitle = spellOutText.description.capitalized
            let menu = UIMenu(title: menuTitle, children: menuActions)
            
            if let btn = view.rightCalloutAccessoryView as? UIButton {
                
                if #available(iOS 14.0, *) {
                    btn.menu = menu
                    btn.showsMenuAsPrimaryAction = true
                } else {
                    // Fallback on earlier versions
                }
                view.rightCalloutAccessoryView = btn
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("annotation view tapped  \(view.annotation)")
        if let annotation = view.annotation as? MKClusterAnnotation {
            print("annotation success", annotation)
            let vc = DetailVC()
            vc.DetailData = self.getImageForAnnotation(annotation.memberAnnotations[0])
            vc.productDetails = self.getImageForAnnotation(annotation.memberAnnotations[0])?.product_details
            vc.dispensaryTime = self.getImageForAnnotation(annotation.memberAnnotations[0])?.dispensorytime
            self.pushViewController(vc, true)
        } else {
            print("annotation failed")
            let vc = DetailVC()
            if let annoData = self.getImageForAnnotation(view.annotation!) {
                vc.DetailData = annoData
                vc.productDetails = annoData.product_details
                vc.dispensaryTime = annoData.dispensorytime
                self.pushViewController(vc, true)
            } else {
                self.showMessage(message: "This is your current location.", isError: .success)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 17.0/255.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1)
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func showRouteOnMap(_start pickupCoordinate: CLLocationCoordinate2D, destination destinationCoordinate: CLLocationCoordinate2D) {
        
        let sourcePlacemark = MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = MKPointAnnotation()
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            if let route = response.routes.first {
                self.mapView.addOverlay((route.polyline), level: .aboveLabels)
                
                let rect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
            
        }
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dispensary?.count ?? 0
        //        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVCell", for: indexPath) as! HomeTVCell
        cell.productImage.setImage(image: viewModel?.dispensary?[indexPath.row].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
        cell.titleLabel.text = viewModel?.dispensary?[indexPath.row].name
        cell.cosmosView.settings.fillMode = .full
        cell.cosmosView.rating = Double(viewModel?.dispensary?[indexPath.row].rating ?? 0)

        if indexPath.row == self.selectedIndex {
            cell.bgView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 1, blue: 0.9450980392, alpha: 1)
        } else {
            cell.bgView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        if indexPath.row == 1 {
            cell.closedButton.setTitle("   Open Now   ", for: .normal)
            cell.closedButton.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2980392157, blue: 0.1725490196, alpha: 1)
        } else {
            cell.closedButton.setTitle("   Closed   ", for: .normal)
            cell.closedButton.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.01176470588, blue: 0.01176470588, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [self] in
            let vc = DetailVC()
            vc.DetailData = viewModel?.dispensary?[indexPath.row]
            vc.productDetails = viewModel?.dispensary?[indexPath.row].product_details
            vc.dispensaryTime = viewModel?.dispensary?[indexPath.row].dispensorytime
            self.navigationController?.pushViewController(vc, animated: true)
        }
        homeTableView.reloadData()
    }
}




extension HomeVC: HomeDispensaryVMObserver {
    func HomeDispensaryApi() {
        if self.viewModel?.dispensary?.count ?? 0 == 0 {
            homeTableView.setBackgroundView(message: "No Dispensary added yet!")
        } else {
            homeTableView.backgroundView = nil
        }
        self.homeTableView.reloadData()
        
        var coordinateArray: [MKAnnotation] = []
        let tripsArray = self.viewModel?.dispensary ?? []
        for x in tripsArray {
            let lat = Double(x.latitude ?? "0.0") ?? 0.0
            let long = Double(x.longitude ?? "0.0") ?? 0.0
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let pointAnnotation = PointAnnotation()
            pointAnnotation.tripDetails = x
            pointAnnotation.coordinate = coordinate
            pointAnnotation.title = x.name
            coordinateArray.append(pointAnnotation)
        }
        print("coordinateArray \(coordinateArray)")
        self.mapPins(pinsArray: coordinateArray)
    }
}
