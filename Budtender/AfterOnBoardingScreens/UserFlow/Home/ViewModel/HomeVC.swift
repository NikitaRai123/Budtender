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

class HomeVC: UIViewController, CLLocationManagerDelegate {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var swipeNearByDispensaryView: UIView!
    @IBOutlet weak var DispensaryView: UIView!
    @IBOutlet weak var dispensaryViewHeight: NSLayoutConstraint!
    @IBOutlet weak var locationBtn: UIButton!
    var selectedIndex:Int?
    var isSwiping = false
    var viewModel: HomeDispensaryVM?
    var nameOnMap: String?
    var cityName: String?
    var customAnnotationView: CustomAnnotationView?
    var lat: String?
    var long: String?
    let locationManager = CLLocationManager()
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSwipe()
        setViewModel()
        dispensaryViewHeight.constant = 53
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.homeTableView.register(UINib(nibName: "HomeTVCell", bundle: nil), forCellReuseIdentifier: "HomeTVCell")
        homeTableView.reloadData()
        
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        setMap()
        viewModel?.homeDispensaryListApi(lat: self.lat ?? "", long: self.long ?? "", search: "")
        
    }
    
    func setMap(){
        let annotation = MKPointAnnotation()
        let lat = Double(self.lat ?? "")
        let long = Double(self.long ?? "")
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat ?? Double() , longitude: long ?? Double())
        annotation.title = self.nameOnMap//"The white House"
        mapView.delegate = self
        mapView.addAnnotation(annotation)
        
        //        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
        //        mapView.setRegion(region, animated: true)
    }
    
    func setViewModel(){
        self.viewModel = HomeDispensaryVM(observer: self)
    }
    
    
    func setSwipe(){
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureToScroll))
        swipeUp.direction = .up
        swipeUp.cancelsTouchesInView = false
        self.swipeNearByDispensaryView.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureToScrollDown))
        swipeDown.direction = .down
        swipeDown.cancelsTouchesInView = false
        self.swipeNearByDispensaryView.addGestureRecognizer(swipeDown)
    }
    @objc func handleGestureToScroll(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            print("Swipe up")
            dispensaryViewHeight.constant = 325.67
        }
    }
    
    @objc func handleGestureToScrollDown(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            print("Swipe down")
            dispensaryViewHeight.constant = 53
        }
    }
    
    // CLLocationManagerDelegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let placeLocation = locations.last else {
            return
        }
        
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
            self.viewModel?.homeDispensaryListApi(lat: self.lat ?? "", long: self.long ?? "", search: "")
        }
    }

    
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func sideBarAction(_ sender: UIButton) {
        let vc = ProfileVC()
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.leftSide = true
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = UIScreen.main.bounds.width - 80
        menu.blurEffectStyle = UIBlurEffect.Style.dark
        present(menu, animated: true, completion: nil)
    }
    
    @IBAction func locationAction(_ sender: UIButton) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        let fields: GMSPlaceField = [.addressComponents, .coordinate, .formattedAddress]
            autocompleteController.placeFields = fields
//            autocompleteController.placeFields = .coordinate
        present(autocompleteController, animated: true, completion: nil)
        
//        let vc = ChangeLocationVC()
//        self.navigationController?.pushViewController(vc, animated: true)
//        let vc = LocationVC()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        let vc = SearchVC()
        vc.lat = self.lat
        vc.long = self.long
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
//-------------------------------------------------------------------------------------------------------
//MARK: Extensions

extension HomeVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dispensary?.count ?? 0
//        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVCell", for: indexPath) as! HomeTVCell
        cell.productImage.setImage(image: viewModel?.dispensary?[indexPath.row].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
        cell.titleLabel.text = viewModel?.dispensary?[indexPath.row].name
        if indexPath.row == self.selectedIndex{
                cell.bgView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 1, blue: 0.9450980392, alpha: 1)
            }else{
                cell.bgView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        if indexPath.row == 1{
            cell.closedButton.setTitle("   Open Now   ", for: .normal)
            cell.closedButton.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2980392157, blue: 0.1725490196, alpha: 1)
        }else{
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
    extension HomeVC: HomeDispensaryVMObserver{
        func HomeDispensaryApi(postCount: Int) {
            if postCount == 0{
                homeTableView.setBackgroundView(message: "No Dispensary added yet!")
            }else{
                self.nameOnMap = viewModel?.dispensary?.first?.name
                print(self.nameOnMap)
                setMap()
                
                homeTableView.backgroundView = nil
                self.homeTableView.reloadData()
            }
            
        }
        
    }

extension HomeVC: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotation = view.annotation as? MKPointAnnotation {
                let customView = CustomAnnotationView(annotation: annotation, reuseIdentifier: "CustomAnnotation")
                mapView.addSubview(customView)
                customView.center = CGPoint(x: view.center.x, y: view.center.y - 50)
                self.customAnnotationView = customView
            }
        }
    }

extension HomeVC: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: place.coordinate.latitude, longitude:  place.coordinate.longitude)
        
        print(location)
        print("latitude === \(place.coordinate.latitude)")
        print("longitude === \(place.coordinate.longitude)")
        self.lat = "\(place.coordinate.latitude)"
        self.long = "\(place.coordinate.longitude)"
        
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            print(placemarks)
            
            placemarks?.forEach { (placemark) in

                if let city = placemark.locality{
                    print("city ==== \(city)")
//                    self.txtCity.text = city
                    self.locationBtn.setTitle(city, for: .normal)
                }
                else{
                    if let thoroughfare = placemark.thoroughfare {
                   
                    }
                }
                let add = placemark.location
                print("addddd ==== \(add)")
                let add1 = placemark.name
                print("addd1 ==== \(add1)")
                let add2 = placemark.region
                print("adddd2 ===== \(add2)")
                let add3 = placemark.subAdministrativeArea
                print("addddd3 === \(add3)")
                let state = placemark.administrativeArea
                print("state ====\(state)")
                let country = placemark.country
                print(country)
//                self.txtCountry.text = country
                let address2 = placemark.subLocality
                print(address2)
                
                let postal = placemark.postalCode
//                self.txtPostalCode.text = postal
                print(postal)

            }
        })
        dismiss(animated: true, completion: nil)
        viewModel?.homeDispensaryListApi(lat: self.lat ?? "", long: self.long ?? "", search: "")
    }
    
}






class CustomAnnotationView: UIView {
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        return label
    }()

    convenience init(annotation: MKPointAnnotation, reuseIdentifier: String) {
        self.init(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        self.backgroundColor = UIColor.clear

        nameLabel.text = annotation.title ?? "Unknown"
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        // Center the label in the custom view
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
