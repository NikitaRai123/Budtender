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
//    var customAnnotationView: CustomAnnotationView?
    var lat: String?
    var long: String?
    let locationManager = CLLocationManager()
//    
//    //-------------------------------------------------------------------------------------------------------
//    //MARK: ViewDidLoad
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        getUserLocation()
//        setSwipe()
//        setViewModel()
//        dispensaryViewHeight.constant = 53
//        self.homeTableView.delegate = self
//        self.homeTableView.dataSource = self
//        self.homeTableView.register(UINib(nibName: "HomeTVCell", bundle: nil), forCellReuseIdentifier: "HomeTVCell")
//        homeTableView.reloadData()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        setMap()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.viewModel?.homeDispensaryListApi(lat: self.lat ?? "", long: self.long ?? "", search: "")
//        }
//    }
//    
//    func setMap() {
//        let annotation = MKPointAnnotation()
//        let lat = Double(self.lat ?? "")
//        let long = Double(self.long ?? "")
//        annotation.coordinate = CLLocationCoordinate2D(latitude: lat ?? Double() , longitude: long ?? Double())
////        annotation.title = self.nameOnMap//"The white House"
//        mapView.delegate = self
//        mapView.addAnnotation(annotation)
//        
//        //        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
//        //        mapView.setRegion(region, animated: true)
//    }
//    
//    func setViewModel(){
//        self.viewModel = HomeDispensaryVM(observer: self)
//    }
//    
//    func getUserLocation() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.startUpdatingLocation()
//        }
//    }
//
//    
//    
//    func setSwipe(){
//        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureToScroll))
//        swipeUp.direction = .up
//        swipeUp.cancelsTouchesInView = false
//        self.swipeNearByDispensaryView.addGestureRecognizer(swipeUp)
//        
//        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureToScrollDown))
//        swipeDown.direction = .down
//        swipeDown.cancelsTouchesInView = false
//        self.swipeNearByDispensaryView.addGestureRecognizer(swipeDown)
//    }
//    @objc func handleGestureToScroll(sender: UISwipeGestureRecognizer) {
//        if sender.state == .ended {
//            print("Swipe up")
//            dispensaryViewHeight.constant = 325.67
//        }
//    }
//    
//    @objc func handleGestureToScrollDown(sender: UISwipeGestureRecognizer) {
//        if sender.state == .ended {
//            print("Swipe down")
//            dispensaryViewHeight.constant = 53
//        }
//    }
//    
//    // CLLocationManagerDelegate method
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let placeLocation = locations.last else {
//            return
//        }
//        
//        // Use the location's latitude and longitude
//        let latitude = placeLocation.coordinate.latitude
//        let longitude = placeLocation.coordinate.longitude
//        
//        // Now you have the current latitude and longitude
//        print("Latitude: \(latitude), Longitude: \(longitude)")
//        
//        
//        self.lat = "\(placeLocation.coordinate.latitude)"
//        self.long = "\(placeLocation.coordinate.longitude)"
//        
//        // Use reverse geocoding to get the place name
//        let geocoder = CLGeocoder()
//        let location = CLLocation(latitude: latitude, longitude: longitude)
//        
//        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
//            guard let placemark = placemarks?.first else {
//                print("Error in reverse geocoding: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            // Here you can access the place name and other address information
//            
//            if let placeName = placemark.name {
//                print("Place Name: \(placeName)")
//            }
//            if let city = placemark.locality {
//                print("City: \(city)")
//                self.cityName = city
//                self.locationBtn.setTitle(self.cityName, for: .normal)
//            }
//            //            self.viewModel?.homeDispensaryListApi(lat: self.lat ?? "", long: self.long ?? "", search: "")
//        }
//    }
//    
//    
//    //-------------------------------------------------------------------------------------------------------
//    //MARK: Actions
//    
//    @IBAction func sideBarAction(_ sender: UIButton) {
//        let vc = ProfileVC()
//        let menu = SideMenuNavigationController(rootViewController: vc)
//        menu.leftSide = true
//        menu.presentationStyle = .menuSlideIn
//        menu.menuWidth = UIScreen.main.bounds.width - 80
//        menu.blurEffectStyle = UIBlurEffect.Style.dark
//        present(menu, animated: true, completion: nil)
//    }
//    
//    @IBAction func locationAction(_ sender: UIButton) {
//        
//        let autocompleteController = GMSAutocompleteViewController()
//        autocompleteController.delegate = self
//        let fields: GMSPlaceField = [.addressComponents, .coordinate, .formattedAddress]
//        autocompleteController.placeFields = fields
//        //            autocompleteController.placeFields = .coordinate
//        present(autocompleteController, animated: true, completion: nil)
//        
//        //        let vc = ChangeLocationVC()
//        //        self.navigationController?.pushViewController(vc, animated: true)
//        //        let vc = LocationVC()
//        //        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    @IBAction func searchAction(_ sender: UIButton) {
//        let vc = SearchVC()
//        vc.lat = self.lat
//        vc.long = self.long
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//}
////-------------------------------------------------------------------------------------------------------
////MARK: Extensions
//
//extension HomeVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel?.dispensary?.count ?? 0
//        //        return 4
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVCell", for: indexPath) as! HomeTVCell
//        cell.productImage.setImage(image: viewModel?.dispensary?[indexPath.row].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
//        cell.titleLabel.text = viewModel?.dispensary?[indexPath.row].name
//        if indexPath.row == self.selectedIndex{
//            cell.bgView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 1, blue: 0.9450980392, alpha: 1)
//        }else{
//            cell.bgView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        }
//        if indexPath.row == 1{
//            cell.closedButton.setTitle("   Open Now   ", for: .normal)
//            cell.closedButton.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2980392157, blue: 0.1725490196, alpha: 1)
//        }else{
//            cell.closedButton.setTitle("   Closed   ", for: .normal)
//            cell.closedButton.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.01176470588, blue: 0.01176470588, alpha: 1)
//        }
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.selectedIndex = indexPath.row
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [self] in
//            let vc = DetailVC()
//            vc.DetailData = viewModel?.dispensary?[indexPath.row]
//            vc.productDetails = viewModel?.dispensary?[indexPath.row].product_details
//            vc.dispensaryTime = viewModel?.dispensary?[indexPath.row].dispensorytime
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        homeTableView.reloadData()
//    }
//}
//
//extension HomeVC: HomeDispensaryVMObserver {
//    func HomeDispensaryApi(postCount: Int) {
//        if postCount == 0{
//            homeTableView.setBackgroundView(message: "No Dispensary added yet!")
//        }else{
//            self.nameOnMap = viewModel?.dispensary?.first?.name
//            print(self.nameOnMap)
////            setMap()
//            
//            homeTableView.backgroundView = nil
//            self.homeTableView.reloadData()
//        }
//    }
//}
//
//extension HomeVC: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        if let annotation = view.annotation as? MKPointAnnotation {
//            let customView = CustomAnnotationView(annotation: annotation, reuseIdentifier: "CustomAnnotation")
//            mapView.addSubview(customView)
//            customView.center = CGPoint(x: view.center.x, y: view.center.y - 50)
//            self.customAnnotationView = customView
//        }
//    }
//}
//
//extension HomeVC: GMSAutocompleteViewControllerDelegate {
//    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
//        print("Error: ", error.localizedDescription)
//    }
//    
//    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
//        dismiss(animated: true, completion: nil)
//    }
//    
//    
//    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//        let geoCoder = CLGeocoder()
//        let location = CLLocation(latitude: place.coordinate.latitude, longitude:  place.coordinate.longitude)
//        
//        print(location)
//        print("latitude === \(place.coordinate.latitude)")
//        print("longitude === \(place.coordinate.longitude)")
//        self.lat = "\(place.coordinate.latitude)"
//        self.long = "\(place.coordinate.longitude)"
//        
//        
//        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in
//            var placeMark: CLPlacemark!
//            placeMark = placemarks?[0]
//            print(placemarks)
//            
//            placemarks?.forEach { (placemark) in
//                
//                if let city = placemark.locality{
//                    print("city ==== \(city)")
//                    //                    self.txtCity.text = city
//                    self.locationBtn.setTitle(city, for: .normal)
//                }
//                else{
//                    if let thoroughfare = placemark.thoroughfare {
//                        
//                    }
//                }
//                let add = placemark.location
//                print("addddd ==== \(add)")
//                let add1 = placemark.name
//                print("addd1 ==== \(add1)")
//                let add2 = placemark.region
//                print("adddd2 ===== \(add2)")
//                let add3 = placemark.subAdministrativeArea
//                print("addddd3 === \(add3)")
//                let state = placemark.administrativeArea
//                print("state ====\(state)")
//                let country = placemark.country
//                print(country)
//                //                self.txtCountry.text = country
//                let address2 = placemark.subLocality
//                print(address2)
//                
//                let postal = placemark.postalCode
//                //                self.txtPostalCode.text = postal
//                print(postal)
//                
//            }
//        })
//        dismiss(animated: true, completion: nil)
//        viewModel?.homeDispensaryListApi(lat: self.lat ?? "", long: self.long ?? "", search: "")
//    }
//    
//}
//
//
//
//class CustomAnnotationView: UIView {
//    var nameLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor.black
//        label.font = UIFont.systemFont(ofSize: 12.0)
//        label.textAlignment = .center
//        label.backgroundColor = UIColor.white
//        return label
//    }()
//    
//    convenience init(annotation: MKPointAnnotation, reuseIdentifier: String) {
//        self.init(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
//        self.backgroundColor = UIColor.clear
//        
////        nameLabel.text = annotation.title ?? "Unknown"
//        addSubview(nameLabel)
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Center the label in the custom view
//        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//    }
//}


//    {
//        
//        @IBOutlet weak var viewToSwipeDown: UIView!
//        @IBOutlet weak var nearByLabel: UILabel!
//        @IBOutlet weak var mytableView: UITableView!
//        @IBOutlet weak var searchTableView: UITableView!
//        @IBOutlet weak var searchtextField: UITextField!
//        @IBOutlet weak var selectStateButton: UIButton!
//        @IBOutlet weak var mapView: MKMapView!
//        @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
//        
//        
//        //    private var locationManager:CLLocationManager?
//        var coordinateArray: [MKAnnotation]?
//        var searchProfessionArr: [ProfessionListData]?
//        var viewModel: CompanyHomeVM?
//        var professionId: String? = ""
//        var companyName: String? = ""
//        var latitude: String?
//        var longitude: String?
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            getUserLocation()
            setMapView()
            setTableView()
            addGestureOnView()
//            checkLocationServices()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.tabBarController?.tabBar.isHidden = false
            setUI()
            setViewModel()
        }
        
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
//            self.professionId = ""
//            self.companyName = ""
//            self.latitude = ""
//            self.longitude = ""
        }
        
        func setUI() {
//            if AppDefaults.loginRole == 1 {
//                self.latitude = AppDefaults.latitude
//                self.longitude = AppDefaults.longitude
//                let city = AppDefaults.getCompanyProfileData()?.city
//                self.selectStateButton.setTitle(city, for: .normal)
//                self.searchtextField.text = ""
//                self.nearByLabel.text = "Near by profession"
//                self.searchtextField.placeholder = "Search for Florals , Designers, Band"
//            } else {
//                let lat = AppDefaults.getLabourProfileData()?.data?.lat
//                let long = AppDefaults.getLabourProfileData()?.data?.long
//                let city = AppDefaults.getLabourProfileData()?.data?.city
//                self.latitude = lat
//                self.longitude = long
//                self.selectStateButton.setTitle(city, for: .normal)
//                self.searchtextField.text = ""
//                self.nearByLabel.text = "Near by companies"
//                self.searchtextField.placeholder = "Search company"
//            }
            //        searchtextField.addTarget(target: self, action: #selector(openSecreen))
        }
        
        func setViewModel() {
            if self.viewModel == nil {
                self.viewModel = HomeDispensaryVM(observer: self)
            }
            print("self.latitude", self.lat)
            print("self.longitude", self.long)
//            self.viewModel?.homeDispensaryListApi(lat: self.lat ?? "", long: self.long ?? "", search: "")
        }
        
        
//        private func configureKeboard() {
//            IQKeyboardManager.shared.enable = true
//            IQKeyboardManager.shared.shouldResignOnTouchOutside = true
//            IQKeyboardManager.shared.toolbarTintColor = UIColor(hexString: "#5D89A9")
//            IQKeyboardManager.shared.enableAutoToolbar = true
//            IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses = [UIScrollView.self,UIView.self,UITextField.self,UITextView.self,UIStackView.self]
//        }
        
        
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
        
        
//        func getSubscriptionStatus() {
//            AFWrapperClass.sharedInstance.requestGETURL(Constant.planStatus, params: [:] , success: { (response) in
//                print(response)
//                if let status = response["status"] as? Int {
//                    if status == 200 {
//                    } else {
//                        let vc = SubscriptionVC()
//                        vc.isCompany = AppDefaults.loginRole == 1
//                        vc.isFromSignUp = false
//                        vc.isHideBackButton = true
//                        if let topVC = UIApplication.getTopViewController() {
//                            let typeComparisonResult = type(of: vc) == type(of: topVC)
//                            if typeComparisonResult {
//                            } else {
//                                self.pushViewController(vc, true)
//                            }
//                        }
//                    }
//                }
//            }, failure: { (error) in
//                print(error.debugDescription)
//            })
//        }
        
        func setMapView() {
            mapView.delegate = self
            mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: "AnnotationView")
            mapView.register(UserClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: UserClusterAnnotationView.identifier)
        }
        
        
        func checkLocationServices() {
            DispatchQueue.main.async {
                if CLLocationManager.locationServicesEnabled() {
                    //            getUserLocation()
                    self.mapView.showsUserLocation = true
                    self.centerViewOnUserLocation()
                } else {
                    ShowBanner.show(title: "Please enable location services for this app.")
                }

            }
        }
        
//        func setTabBar() {
//            if let tabItems = self.tabBarController?.tabBar.items {
//                // In this case we want to modify the badge number of the third tab:
//                if (Singleton.notifyCount.count > 0) && (Singleton.notifyCount != "0") {
//                    let tabItem = tabItems[2]
//                    tabItem.badgeValue = "●"
//                    tabItem.badgeColor = .clear
//                    tabItem.setBadgeTextAttributes([.font: UIFont.systemFont(ofSize: 16), .foregroundColor: #colorLiteral(red: 0.3647058824, green: 0.5333333333, blue: 0.662745098, alpha: 1)], for: .normal)
//                } else {
//                    let tabItem = tabItems[2]
//                    tabItem.badgeValue = nil
//                }
//                if (Singleton.msgCount.count > 0) && (Singleton.msgCount != "0") {
//                    let tabItem = tabItems[1]
//                    tabItem.badgeValue = "●"
//                    tabItem.badgeColor = .clear
//                    tabItem.setBadgeTextAttributes([.font: UIFont.systemFont(ofSize: 16), .foregroundColor: #colorLiteral(red: 0.3647058824, green: 0.5333333333, blue: 0.662745098, alpha: 1)], for: .normal)
//                } else {
//                    let tabItem = tabItems[1]
//                    tabItem.badgeValue = nil
//                }
//            }
//            
//        }
        
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
            //        if let location = locationManager?.location?.coordinate {
            
            let region = MKCoordinateRegion(center: loc, latitudinalMeters: 30000, longitudinalMeters: 30000)
            mapView.setRegion(region, animated: true)
            //        }
            //      CLLocation(latitude: CLLocationDegrees(30.7525), longitude: CLLocationDegrees(76.8101))
        }
        
//        @objc func openSecreen() {
//            let vc = SearchHomeVC()
//            vc.delegate = self
//            vc.hidesBottomBarWhenPushed = false
//            vc.modalPresentationStyle = .overFullScreen
//            self.present(vc, true)
//        }
        
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
            //        locationManager?.startUpdatingLocation()
        }
        
        @IBAction func selectStateAction(_ sender: UIButton) {
            self.showLocationSearch()
        }
    
    @IBAction func locationAction(_ sender: UIButton) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        let fields: GMSPlaceField = [.addressComponents, .coordinate, .formattedAddress]
        autocompleteController.placeFields = fields
        //            autocompleteController.placeFields = .coordinate
        present(autocompleteController, animated: true, completion: nil)
    }
        
        
    }


    // MARK:  SWIPE BOTTOM POPUP
//    extension HomeVC:SearchHomeVCDelegate {
//        func openScreen() {
//            if AppDefaults.loginRole == 1 {
//                let vc = SearchDetailVC()
//                vc.hidesBottomBarWhenPushed = true
//                self.pushViewController(vc, true)
//            } else {
//                let vc = LaborDetailsVC()
//    //            vc.professionId = self.viewModel?.homeData?[indexPath.row].id ?? ""
//                vc.hidesBottomBarWhenPushed = true
//                self.pushViewController(vc, true)
//            }
//        }
//    }


    // MARK:   SEARCH Profession DELEGATE
//    extension HomeVC: CompanyHomeVMObserver {
//        func searchLocation() {
//            //
//        }
//        
//        func searchProfession() {
////            setTabBar()
//            DispatchQueue.main.async {
//                if self.viewModel?.homeData?.count ?? 0 > 0 {
//                    self.mytableView.backgroundView = nil
//                } else {
//                    self.mytableView.setBackgroundView(message: "No data found.")
//                }
//                self.mytableView.reloadData()
//            }
//            
//            self.coordinateArray = []
//            let tripsArray = self.viewModel?.homeData ?? []
//            for (n, x) in tripsArray.enumerated() {
//                
//                let lat = Double(x.lat ?? "0.0") ?? 0.0
//                let long = Double(x.long ?? "0.0") ?? 0.0
//                
//                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
//                
//                let pointAnnotation = PointAnnotation()
//                pointAnnotation.tripDetails = x
//                pointAnnotation.coordinate = coordinate
//                pointAnnotation.title = x.name // x.postName?.trimWhiteSpace.capitalized
//                self.coordinateArray?.append(pointAnnotation)
//            }
//            print("coordinateArray \(self.coordinateArray)")
//            
//            self.mapPins(pinsArray: self.coordinateArray ?? [])
//        }
//        
//        
//    }

    // MARK:  LOCATION SEARCH DELEGATE
    extension HomeVC: GMSAutocompleteViewControllerDelegate {
        
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            //        print("Place name: \(place.name)")
            //         print("Place ID: \(place.placeID)")
            //         print("Place attributions: \(place.attributions)")
//            self.lat = "\(place.coordinate.latitude.rounded(toPlaces: 4))"
//            self.long = "\(place.coordinate.longitude.rounded(toPlaces: 4))"
            
            self.lat = "\(place.coordinate.latitude)"
            self.long = "\(place.coordinate.longitude)"
            print(self.lat)
            print(self.long)
            
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
            self.viewModel?.homeDispensaryListApi(lat: self.lat ?? "", long: self.long ?? "", search: "")
            dismiss(animated: true, completion: nil)
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            // TODO: handle the error.
            print("Error: ", error.localizedDescription)
        }
        
        //    func viewController(_ viewController: GMSAutocompleteViewController, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        //        self.searchTF.text = prediction.attributedFullText.string
        //        return true
        //    }
        // User canceled the operation.
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            dismiss(animated: true, completion: nil)
        }
        
        // Turn the network activity indicator on and off again.
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
                self.viewModel?.homeDispensaryListApi(lat: self.lat ?? "", long: self.long ?? "", search: "")
                self.checkLocationServices()
                
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            //checkLocationServices()
            print("didChangeAuthorization")
            //        checkLocationServices()
        }
    }





    // MARK:  MKMap View DELEGATE

    extension HomeVC: MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            print("view for anoooooo")
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
//                    let postedStuff = annotation.tripDetails?.profile_image ?? ""
//                    anView.imageURLString = annotation.tripDetails?.profile_image
                    //                if postedStuff.isImageType {
                    //                    anView.imageURLString = annotation.tripDetails?.profile_image
                    //                } else {
                    //                    if annotation.tripDetails?.thumbImage?.count ?? 0 > 0 {
                    //                        anView.imageURLString = annotation.tripDetails?.thumbImage
                    //                    }
                    //                    else {
                    //                        anView.imageURLString = nil
                    //                    }
                    //                }
                } else {
                    anView.imageURLString = nil
                }
                anView.canShowCallout = true
                anView.annotation = annotation
                anView.rightCalloutAccessoryView = UIButton(type:.detailDisclosure)
                return anView
            }
        }
        
//        func getImageForAnnotation(_ annotation: MKAnnotation) -> HomeVCDataModel? {
//            if let annotation = annotation as? PointAnnotation {
//                return annotation.tripDetails
//            }
//            let data = self.viewModel?.homeData ?? []
//            let lat = annotation.coordinate.latitude
//            let lng = annotation.coordinate.longitude
//            let first = data.first(where: {$0.lat?.toDouble == lat && $0.long?.toDouble == lng})
//            return first
//        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//            if let annotation = view.annotation as? MKClusterAnnotation {
//                print("count= \(annotation.memberAnnotations.count)")
//                
//                var details: [HomeVCDataModel] = []
//                annotation.memberAnnotations.forEach { member in
//                    print("member \(member.title)")
//                    if let trip = (member as? PointAnnotation)?.tripDetails {
//                        details.append(trip)
//                    }
//                }
//                
//                var _details:[HomeVCDataModel] = []
//                self.viewModel?.homeData?.forEach({ data in
//                    if details.contains(where: {$0.id == data.id}) {
//                        _details.append(data)
//                    }
//                })
//                
//                var menuActions:[UIAction] = []
//                
//                _details.forEach { trip in
//                    print("trip details \(trip.name) ** \(trip.id)")
//                    let action = UIAction(title: trip.name?.capitalized ?? "", image: nil) { (action) in
//                        if AppDefaults.loginRole == 1 {
//                            let vc = SearchDetailVC()
//                            vc.professionId = trip.id ?? ""  // self.viewModel?.homeData?[indexPath.row].id ?? ""
//                            self.pushViewController(vc, true)
//                            print(action.title)
//                        } else {
//                            let vc = LaborDetailsVC()
//                            vc.professionId = trip.id ?? ""
//                            self.pushViewController(vc, true)
//                        }
//                        
//                    }
//                    menuActions.append(action)
//                }
//                
//                let integer = annotation.memberAnnotations.count
//                let formatter = NumberFormatter()
//                formatter.numberStyle = NumberFormatter.Style.spellOut
//                let spellOutText = formatter.string(for: integer)!
//                print(spellOutText)
//                
//                let menuTitle = spellOutText.description.capitalized + " Trips Nearby"
//                let menu = UIMenu(title: menuTitle, children: menuActions)
//                
//                if let btn = view.rightCalloutAccessoryView as? UIButton {
//                    
//                    if #available(iOS 14.0, *) {
//                        btn.menu = menu
//                        btn.showsMenuAsPrimaryAction = true
//                    } else {
//                        // Fallback on earlier versions
//                    }
//                    view.rightCalloutAccessoryView = btn
//                }
//            }
        }
        
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            print("annotation view tapped  \(view.annotation)")
            
            if let annotation = view.annotation as? MKClusterAnnotation {
                
                print("annotation success", annotation)
//                if AppDefaults.loginRole == 1 {
//                    let vc = SearchDetailVC()
//                    vc.professionId = self.getImageForAnnotation(annotation.memberAnnotations[0])?.id ?? "" // self.viewModel?.homeData?[indexPath.row].id ?? ""
//                    self.pushViewController(vc, true)
//                } else {
//                    let vc = LaborDetailsVC()
//    //                vc.professionId = trip.id ?? ""
//                    self.pushViewController(vc, true)
//                }

                
            } else {
                print("annotation failed")
//                if AppDefaults.loginRole == 1 {
//                    let vc = SearchDetailVC()
//                    vc.professionId = self.getImageForAnnotation(view.annotation!)?.id ?? "" // self.viewModel?.homeData?[indexPath.row].id ?? ""
//                    self.pushViewController(vc, true)
//                } else {
//                    let vc = LaborDetailsVC()
//                    vc.professionId = self.getImageForAnnotation(view.annotation!)?.id ?? "" //
//                    self.pushViewController(vc, true)
//                }
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


    extension HomeVC: UITextFieldDelegate {
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            self.swipeDownView()
            return true
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            if AppDefaults.loginRole == 1 {
//                searchProfessionArr = textField.text?.count ?? 0 > 0 ? viewModel?.professionListData?.filter({$0.name?.lowercased().contains(textField.text?.lowercased() ?? "") ?? false}) : nil
//                if !(searchProfessionArr?.count ?? 0 > 0) {
//                    ShowBanner.show(title: "No data found.")
//                    self.tableViewHeight.constant = 0
//                    self.searchTableView.isHidden = true
//                } else {
//                    let count = searchProfessionArr?.count ?? 0
//                    self.tableViewHeight.constant = CGFloat(60*count)
//                    self.searchTableView.isHidden = false
//                }
//                searchTableView.reloadData()
//            } else {
//                self.viewModel?.searchCompany(lat: self.latitude, long: self.longitude, name: textField.text)
//            }
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
//            if (textField.text?.count ?? 0 <= 0) {
//                self.tableViewHeight.constant = 0
//                self.searchTableView.isHidden = true
//                self.viewModel?.searchPeople(lat: self.latitude, long: self.longitude, profession: "")
//            }
        }
        
    }


extension HomeVC: HomeDispensaryVMObserver {
    func HomeDispensaryApi() {
        if self.viewModel?.dispensary?.count ?? 0 == 0{
            homeTableView.setBackgroundView(message: "No Dispensary added yet!")
        }else{
//            self.nameOnMap = viewModel?.dispensary?.first?.name
//            print(self.nameOnMap)
            homeTableView.backgroundView = nil
        }
        self.homeTableView.reloadData()
    }
}
