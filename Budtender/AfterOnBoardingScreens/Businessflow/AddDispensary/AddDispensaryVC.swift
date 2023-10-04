//
//  AddDispensaryVC.swift
//  Budtender
//
//  Created by apple on 29/08/23.
//

import UIKit
class AddDispensaryVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var addDispensaryLabel: UILabel!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var txtDispensaryName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtPostalCode: UITextField!
    @IBOutlet weak var txtWebsite: UITextField!
    @IBOutlet weak var txtLicense: UITextField!
    @IBOutlet weak var txtExpiration: UITextField!
    @IBOutlet weak var expirationDropDownButton: UIButton!
    @IBOutlet weak var mondayHoursView: BusinessWeekDaysView!
    @IBOutlet weak var tuesdayHoursView: BusinessWeekDaysView!
    @IBOutlet weak var wednesdayHoursView: BusinessWeekDaysView!
    @IBOutlet weak var thursdayHoursView: BusinessWeekDaysView!
    @IBOutlet weak var fridayHoursView: BusinessWeekDaysView!
    @IBOutlet weak var saturdayHoursView: BusinessWeekDaysView!
    @IBOutlet weak var sundayHoursView: BusinessWeekDaysView!
    //-------------------------------------------------------------------------------------------------------
    //MARK: Variables
    
    var imagePickerController = UIImagePickerController()
    let startTimePicker = UIDatePicker()
    let endTimePicker = UIDatePicker()
    var isSelect:String?
    var openTimePickerTF:UITextField?
    var operationHours = String()
    var scheduleData: [ScheduleDay] = []
    var viewModel: AddDispensaryVM?
    
// MARK: For Edit Dispensary
    var id: Int?
    var image: String?
    var name: String?
    var phone: String?
    var email: String?
    var address: String?
    var country: String?
    var city: String?
    var state: String?
    var postal: String?
    var website: String?
    var license: String?
    var expiration: String?
    var hoursOfOperation: [Dispensorytime]?
    
    
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openDatePicker()
        txtExpiration.delegate = self
        setWeekDayView()
        setViewModel()
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewWillApear
    
    override func viewWillAppear(_ animated: Bool) {
        if isSelect == "AddDispensary"{
            self.addDispensaryLabel.text = "Add Dispensary"
            self.createButton.setTitle("Create", for: .normal)
            
        }else{
            self.addDispensaryLabel.text = "Edit Dispensary"
            self.createButton.setTitle("Save", for: .normal)
        }
    }
    
    func setViewModel(){
        self.viewModel = AddDispensaryVM(observer: self)
        setEditDispensaryData()
    }
    
    func setEditDispensaryData(){
        let data = UserDefaultsCustom.getUserData()
        self.productImage.setImage(image: image, placeholder: UIImage(named: "dispensaryPlaceholder"))
        print("\n\n\nphoto ************** \(image)    authToken = \(data?.auth_token ?? "")")
        self.viewModel?.editImage = PickerData(imgUrlStr: image)
        self.viewModel?.editImage?.image = self.productImage.image
        self.viewModel?.editImage?.data = self.productImage.image?.jpegData(compressionQuality: 1.0)
        print("\n\n\nphoto *********** \(image)")
        self.txtDispensaryName.text = self.name
        self.txtPhoneNumber.text = self.phone
        self.txtEmail.text = self.email
        self.txtAddress.text = self.address
        self.txtCountry.text = self.country
        self.txtCity.text = self.city
        self.txtState.text = self.state
        self.txtPostalCode.text = self.postal
        self.txtWebsite.text = self.website
        self.txtLicense.text = self.license
        self.txtExpiration.text = self.expiration
        print(hoursOfOperation)
        print(hoursOfOperation?[1].day_name)
        if hoursOfOperation?.first?.day_name == "Sunday" && hoursOfOperation?.first?.is_switchon == "true"{
            sundayHoursView.toggleSwitch.isOn = true
            sundayHoursView.switchOn()
            sundayHoursView.txtOpen.text = hoursOfOperation?.first?.state_time
            sundayHoursView.txtClose.text = hoursOfOperation?.first?.end_time
        }else{
            sundayHoursView.switchOff()
        }
        
        if hoursOfOperation?[1].day_name == "Monday" && hoursOfOperation?[1].is_switchon == "true"{
            mondayHoursView.toggleSwitch.isOn = true
            mondayHoursView.switchOn()
            mondayHoursView.txtOpen.text = hoursOfOperation?[1].state_time
            mondayHoursView.txtClose.text = hoursOfOperation?[1].end_time
        }else{
            mondayHoursView.switchOff()
        }
        
        if hoursOfOperation?[2].day_name == "Tuesday" && hoursOfOperation?[2].is_switchon == "true"{
            tuesdayHoursView.toggleSwitch.isOn = true
            tuesdayHoursView.switchOn()
            tuesdayHoursView.txtOpen.text = hoursOfOperation?[2].state_time
            tuesdayHoursView.txtClose.text = hoursOfOperation?[2].end_time
        }else{
            tuesdayHoursView.switchOff()
        }
        if hoursOfOperation?[3].day_name == "Wednesday" && hoursOfOperation?[3].is_switchon == "true"{
            wednesdayHoursView.toggleSwitch.isOn = true
            wednesdayHoursView.switchOn()
            wednesdayHoursView.txtOpen.text = hoursOfOperation?[3].state_time
            wednesdayHoursView.txtClose.text = hoursOfOperation?[3].end_time
        }else{
            wednesdayHoursView.switchOff()
        }
        if hoursOfOperation?[4].day_name == "Thursday" && hoursOfOperation?[4].is_switchon == "true"{
            thursdayHoursView.toggleSwitch.isOn = true
            thursdayHoursView.switchOn()
            thursdayHoursView.txtOpen.text = hoursOfOperation?[4].state_time
            thursdayHoursView.txtClose.text = hoursOfOperation?[4].end_time
        }else{
            thursdayHoursView.switchOff()
        }
        if hoursOfOperation?[5].day_name == "Friday" && hoursOfOperation?[5].is_switchon == "true"{
            fridayHoursView.toggleSwitch.isOn = true
            fridayHoursView.switchOn()
            fridayHoursView.txtOpen.text = hoursOfOperation?[6].state_time
            fridayHoursView.txtClose.text = hoursOfOperation?[6].end_time
        }else{
            fridayHoursView.switchOff()
        }
        if hoursOfOperation?[6].day_name == "Saturday" && hoursOfOperation?[6].is_switchon == "true"{
            saturdayHoursView.toggleSwitch.isOn = true
            saturdayHoursView.switchOn()
            saturdayHoursView.txtOpen.text = hoursOfOperation?[2].state_time
            saturdayHoursView.txtClose.text = hoursOfOperation?[2].end_time
        }else{
            saturdayHoursView.switchOff()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        openTimePickerTF = textField
    }
    func setWeekDayView(){
        mondayHoursView.txtOpen.delegate = self
        mondayHoursView.txtClose.delegate = self
        tuesdayHoursView.txtOpen.delegate = self
        tuesdayHoursView.txtClose.delegate = self
        wednesdayHoursView.txtOpen.delegate = self
        wednesdayHoursView.txtClose.delegate = self
        thursdayHoursView.txtOpen.delegate = self
        thursdayHoursView.txtClose.delegate = self
        fridayHoursView.txtOpen.delegate = self
        fridayHoursView.txtClose.delegate = self
        saturdayHoursView.txtOpen.delegate = self
        saturdayHoursView.txtClose.delegate = self
        sundayHoursView.txtOpen.delegate = self
        sundayHoursView.txtClose.delegate = self
        mondayHoursView.dayNameLabel.text = "Monday"
        tuesdayHoursView.dayNameLabel.text = "Tuesday"
        wednesdayHoursView.dayNameLabel.text = "Wednesday"
        thursdayHoursView.dayNameLabel.text = "Thursday"
        fridayHoursView.dayNameLabel.text = "Friday"
        saturdayHoursView.dayNameLabel.text = "Saturday"
        sundayHoursView.dayNameLabel.text = "Sunday"
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        productImage.image  = tempImage
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func openDatePicker(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        startTimePicker.datePickerMode = .time
        endTimePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        startTimePicker.preferredDatePickerStyle = .wheels
        endTimePicker.preferredDatePickerStyle = .wheels
        txtExpiration.inputView = datePicker
       
        mondayHoursView.txtOpen.inputView = startTimePicker
        mondayHoursView.txtClose.inputView = endTimePicker
        tuesdayHoursView.txtOpen.inputView = startTimePicker
        tuesdayHoursView.txtClose.inputView = endTimePicker
        wednesdayHoursView.txtOpen.inputView = startTimePicker
        wednesdayHoursView.txtClose.inputView = endTimePicker
        thursdayHoursView.txtOpen.inputView = startTimePicker
        thursdayHoursView.txtClose.inputView = endTimePicker
        fridayHoursView.txtOpen.inputView = startTimePicker
        fridayHoursView.txtClose.inputView = endTimePicker
        saturdayHoursView.txtOpen.inputView = startTimePicker
        saturdayHoursView.txtClose.inputView = endTimePicker
        sundayHoursView.txtOpen.inputView = startTimePicker
        sundayHoursView.txtClose.inputView = endTimePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDatePicker))
        toolbar.setItems([doneButton], animated: true)
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
       
        startTimePicker.addTarget(self, action: #selector(startTimePickerValueChanged), for: .valueChanged)
        endTimePicker.addTarget(self, action: #selector(endTimePickerValueChanged), for: .valueChanged)
        txtExpiration.inputAccessoryView = .none
        mondayHoursView.txtOpen.inputAccessoryView = .none
        mondayHoursView.txtClose.inputAccessoryView = .none
        tuesdayHoursView.txtOpen.inputAccessoryView = .none
        tuesdayHoursView.txtClose.inputAccessoryView = .none
        wednesdayHoursView.txtOpen.inputAccessoryView = .none
        wednesdayHoursView.txtClose.inputAccessoryView = .none
        thursdayHoursView.txtOpen.inputAccessoryView = .none
        thursdayHoursView.txtClose.inputAccessoryView = .none
        fridayHoursView.txtOpen.inputAccessoryView = .none
        fridayHoursView.txtClose.inputAccessoryView = .none
        saturdayHoursView.txtOpen.inputAccessoryView = .none
        saturdayHoursView.txtClose.inputAccessoryView = .none
        sundayHoursView.txtOpen.inputAccessoryView = .none
        sundayHoursView.txtClose.inputAccessoryView = .none
    }
    @objc func dismissDatePicker() {
        view.endEditing(true)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.expirationDropDownButton.setImage(UIImage(named: "Ic_ShowDropDown"), for: .normal)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.expirationDropDownButton.setImage(UIImage(named: "Ic_DropDown"), for: .normal)
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        let currentDate = Date()
        sender.minimumDate = currentDate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/M/yyyy"
        //formatter.dateStyle = .short
        txtExpiration.text = formatter.string(from: sender.date)
    }
    @objc func startTimePickerValueChanged(_ sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        switch openTimePickerTF {
        case mondayHoursView.txtOpen:
            mondayHoursView.txtOpen.text = timeFormatter.string(from: sender.date)
            print( mondayHoursView.txtOpen.text)
        case tuesdayHoursView.txtOpen:
            tuesdayHoursView.txtOpen.text = timeFormatter.string(from: sender.date)
        case wednesdayHoursView.txtOpen:
            wednesdayHoursView.txtOpen.text = timeFormatter.string(from: sender.date)
        case thursdayHoursView.txtOpen:
            thursdayHoursView.txtOpen.text = timeFormatter.string(from: sender.date)
        case fridayHoursView.txtOpen:
            fridayHoursView.txtOpen.text = timeFormatter.string(from: sender.date)
        case saturdayHoursView.txtOpen:
            saturdayHoursView.txtOpen.text = timeFormatter.string(from: sender.date)
        case sundayHoursView.txtOpen:
            sundayHoursView.txtOpen.text = timeFormatter.string(from: sender.date)
        default:
            break
        }
    }
    
    @objc func endTimePickerValueChanged(_ sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        switch openTimePickerTF {
        case mondayHoursView.txtClose:
            mondayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
        case tuesdayHoursView.txtClose:
            tuesdayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
        case wednesdayHoursView.txtClose:
            wednesdayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
        case thursdayHoursView.txtClose:
            thursdayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
        case fridayHoursView.txtClose:
            fridayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
        case saturdayHoursView.txtClose:
            saturdayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
        case sundayHoursView.txtClose:
            sundayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
        default:
            break
        }
    }
    
    
    func openGalaryPhoto(tag:Int = 0) {
        self.viewModel?.imagePicker.setImagePicker(imagePickerType: .both, mediaType: .image, tag: tag, controller: self)
        self.viewModel?.imagePicker.imageCallBack = {[weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data1 = data {
                        if tag == 1 {
                            
                            self?.viewModel?.editImage = data1
                            self?.productImage.image = data1.image
                            print("imageee ===== \(data1.image)")
                        }
                    }
                case .error(let message):
                    Singleton.shared.showErrorMessage(error: message, isError: .error)
                }
            }
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cameraAction(_ sender: UIButton) {
        self.openGalaryPhoto(tag: 1)
        
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        let action = UIAlertAction(title: "Camera", style: .default){ [self] action in
//            if UIImagePickerController.isSourceTypeAvailable(.camera) {
//                imagePickerController.sourceType = .camera;
//                imagePickerController.allowsEditing = true
//                self.imagePickerController.delegate = self
//                self.present(imagePickerController, animated: true, completion: nil)
//            }
//            else{
//                let alert = UIAlertController(title: "Camera not found", message: "This device has no camera", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default,handler: nil))
//                present(alert, animated: true,completion: nil)
//            }
//        }
//        let action1 = UIAlertAction(title: "Gallery", style: .default){ action in
//            self.imagePickerController.allowsEditing = false
//            self.imagePickerController.sourceType = .photoLibrary
//            self.imagePickerController.delegate = self
//            self.present(self.imagePickerController, animated: true, completion: nil)
//        }
//        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
//        alert.addAction(action)
//        alert.addAction(action1)
//        alert.addAction(action2)
//        present(alert, animated: true, completion: nil)
    }
    
    func printDetails(_ details: String?) {
        guard let unwrappedDetails = details else {
            print("Model details is nil")
            return
        }

        // Remove escape characters from the JSON string
        let cleanedDetails = unwrappedDetails.replacingOccurrences(of: "\\", with: "")

        print("Model === \(cleanedDetails)")
    }
    
    
    @IBAction func createAction(_ sender: UIButton) {
        if isSelect == "AddDispensary"{
            self.scheduleData = []
            setHours()
           
            // Filter out entries that have both start_time and end_time
            let filteredScheduleData = scheduleData.filter { day in
                return !day.state_time.isEmpty && !day.end_time.isEmpty
            }
            
            print(filteredScheduleData)
            
         
            let isValidDispensary = Validator.validateName(name: txtDispensaryName.text?.toTrim() ?? "", message: "Please enter Dispensary name")
            guard isValidDispensary.0 == true else {
                Singleton.showMessage(message: isValidDispensary.1, isError: .error)
                return
            }
            
            let isValidPhone = Validator.validatePhoneNumber(number: txtPhoneNumber.text)
            guard isValidPhone.0 == true else {
                Singleton.showMessage(message: isValidPhone.1, isError: .error)
                return
            }
            let isValidEmail = Validator.validateEmail(candidate: txtEmail.text ?? "")
            guard isValidEmail.0 == true else {
                Singleton.showMessage(message: isValidEmail.1, isError: .error)
                return
            }
            let isValidAddress = Validator.validateName(name: txtAddress.text?.toTrim() ?? "", message: "Please enter address")
            guard isValidAddress.0 == true else {
                Singleton.showMessage(message: isValidAddress.1, isError: .error)
                return
            }
            let isValidCountry = Validator.validateName(name: txtCountry.text?.toTrim() ?? "", message: "Please enter Country")
            guard isValidCountry.0 == true else {
                Singleton.showMessage(message: isValidCountry.1, isError: .error)
                return
            }
            let isValidCity = Validator.validateName(name: txtCity.text?.toTrim() ?? "", message: "Please enter City")
            guard isValidCity.0 == true else {
                Singleton.showMessage(message: isValidCity.1, isError: .error)
                return
            }
            let isValidState = Validator.validateName(name: txtState.text?.toTrim() ?? "", message: "Please enter State")
            guard isValidState.0 == true else {
                Singleton.showMessage(message: isValidState.1, isError: .error)
                return
            }
            let isValidPostal = Validator.validatePostal(userName: txtPostalCode.text?.toTrim() ?? "", message: "Please enter Postal Code")
            guard isValidPostal.0 == true else {
                Singleton.showMessage(message: isValidPostal.1, isError: .error)
                return
            }
            let isValidWebsite = Validator.validateName(name: txtWebsite.text?.toTrim() ?? "", message: "Please enter website")
            guard isValidWebsite.0 == true else {
                Singleton.showMessage(message: isValidWebsite.1, isError: .error)
                return
            }
            let isValidLicense = Validator.validateName(name: txtLicense.text?.toTrim() ?? "", message: "Please enter License")
            guard isValidLicense.0 == true else {
                Singleton.showMessage(message: isValidLicense.1, isError: .error)
                return
            }
            let isValidExpiration = Validator.validateName(name: txtExpiration.text?.toTrim() ?? "", message: "Please select expiration")
            guard isValidExpiration.0 == true else {
                Singleton.showMessage(message: isValidExpiration.1, isError: .error)
                return
            }
            let allSwitchOff = scheduleData.allSatisfy { $0.is_switchon == "false" }
            print(allSwitchOff)
            
            if allSwitchOff{
                showMessage(message: "Please select hours of operation", isError: .error)
            }else{
                viewModel?.addDispensaryApi(name: txtDispensaryName.text ?? "", phoneNumber: txtPhoneNumber.text ?? "", email: txtEmail.text ?? "", country: txtCountry.text ?? "", address: txtAddress.text ?? "", city: txtCity.text ?? "", state: txtState.text ?? "", postalCode: txtPostalCode.text ?? "", website: txtWebsite.text ?? "", license: txtLicense.text ?? "", expiration: txtExpiration.text ?? "", image: "", longitude: "76.71790", latitude: "30.7046", operationDetail: "", isStatus: "1")
            }
        }else{
            self.scheduleData = []
            setHours()
            // Filter out entries that have both start_time and end_time
            let filteredScheduleData = scheduleData.filter { day in
                return !day.state_time.isEmpty && !day.end_time.isEmpty
            }
            
            print(filteredScheduleData)
            
         
            let isValidDispensary = Validator.validateName(name: txtDispensaryName.text?.toTrim() ?? "", message: "Please enter Dispensary name")
            guard isValidDispensary.0 == true else {
                Singleton.showMessage(message: isValidDispensary.1, isError: .error)
                return
            }
            
            let isValidPhone = Validator.validatePhoneNumber(number: txtPhoneNumber.text)
            guard isValidPhone.0 == true else {
                Singleton.showMessage(message: isValidPhone.1, isError: .error)
                return
            }
            let isValidEmail = Validator.validateEmail(candidate: txtEmail.text ?? "")
            guard isValidEmail.0 == true else {
                Singleton.showMessage(message: isValidEmail.1, isError: .error)
                return
            }
            let isValidAddress = Validator.validateName(name: txtAddress.text?.toTrim() ?? "", message: "Please enter address")
            guard isValidAddress.0 == true else {
                Singleton.showMessage(message: isValidAddress.1, isError: .error)
                return
            }
            let isValidCountry = Validator.validateName(name: txtCountry.text?.toTrim() ?? "", message: "Please enter Country")
            guard isValidCountry.0 == true else {
                Singleton.showMessage(message: isValidCountry.1, isError: .error)
                return
            }
            let isValidCity = Validator.validateName(name: txtCity.text?.toTrim() ?? "", message: "Please enter City")
            guard isValidCity.0 == true else {
                Singleton.showMessage(message: isValidCity.1, isError: .error)
                return
            }
            let isValidState = Validator.validateName(name: txtState.text?.toTrim() ?? "", message: "Please enter State")
            guard isValidState.0 == true else {
                Singleton.showMessage(message: isValidState.1, isError: .error)
                return
            }
            let isValidPostal = Validator.validatePostal(userName: txtPostalCode.text?.toTrim() ?? "", message: "Please enter Postal Code")
            guard isValidPostal.0 == true else {
                Singleton.showMessage(message: isValidPostal.1, isError: .error)
                return
            }
            let isValidWebsite = Validator.validateName(name: txtWebsite.text?.toTrim() ?? "", message: "Please enter website")
            guard isValidWebsite.0 == true else {
                Singleton.showMessage(message: isValidWebsite.1, isError: .error)
                return
            }
            let isValidLicense = Validator.validateName(name: txtLicense.text?.toTrim() ?? "", message: "Please enter License")
            guard isValidLicense.0 == true else {
                Singleton.showMessage(message: isValidLicense.1, isError: .error)
                return
            }
            let isValidExpiration = Validator.validateName(name: txtExpiration.text?.toTrim() ?? "", message: "Please select expiration")
            guard isValidExpiration.0 == true else {
                Singleton.showMessage(message: isValidExpiration.1, isError: .error)
                return
            }
            let allSwitchOff = scheduleData.allSatisfy { $0.is_switchon == "false" }
            print(allSwitchOff)
            
            if allSwitchOff{
                showMessage(message: "Please select hours of operation", isError: .error)
            }else{
                let id = "\(self.id ?? 0)"
                viewModel?.editDispensaryApi(name: txtDispensaryName.text ?? "", phoneNumber: txtPhoneNumber.text ?? "", email: txtEmail.text ?? "", country: txtCountry.text ?? "", address: txtAddress.text ?? "", city: txtCity.text ?? "", state: txtState.text ?? "", postalCode: txtPostalCode.text ?? "", website: txtWebsite.text ?? "", license: txtLicense.text ?? "", expiration: txtExpiration.text ?? "", image: "", longitude: "76.7179", latitude: "30.7046", operationDetail: "", isStatus: "1", id: id)
            }
            
        }
        
       
    }
    
  
    func setHours() {
        // Helper function to conditionally get time
        func getTime(_ time: String) -> String {
            return time
        }
        
        // Add schedule data for each day
        scheduleData.append(ScheduleDay(
            day_name:"Sunday",
            state_time:getTime(sundayHoursView.txtOpen.text ?? ""),
            end_time:getTime(sundayHoursView.txtClose.text ?? ""),
            is_status:getTime(sundayHoursView.txtOpen.text ?? "").isEmpty ? "1" : "0",
            is_switchon:getTime(sundayHoursView.txtOpen.text ?? "").isEmpty ? "false" : "true")
        )
        
        scheduleData.append(ScheduleDay(
            day_name:"Monday",
            state_time:getTime(mondayHoursView.txtOpen.text ?? ""),
            end_time:getTime(mondayHoursView.txtClose.text ?? ""),
            is_status:getTime(mondayHoursView.txtOpen.text ?? "").isEmpty ? "1" : "0",
            is_switchon:getTime(mondayHoursView.txtOpen.text ?? "").isEmpty ? "false" : "true")
        )
        
        // Repeat the same for other days...
        // ...
        
        scheduleData.append(ScheduleDay(
            day_name: "Tuesday",
            state_time: getTime(tuesdayHoursView.txtOpen.text ?? ""),
            end_time: getTime(tuesdayHoursView.txtClose.text ?? ""),
            is_status: getTime(tuesdayHoursView.txtOpen.text ?? "").isEmpty ? "1" : "0",
            is_switchon: getTime(tuesdayHoursView.txtOpen.text ?? "").isEmpty ? "false" : "true")
        )
        
        scheduleData.append(ScheduleDay(
            day_name: "Wednesday",
            state_time: getTime(wednesdayHoursView.txtOpen.text ?? ""),
            end_time: getTime(wednesdayHoursView.txtClose.text ?? ""),
            is_status: getTime(wednesdayHoursView.txtOpen.text ?? "").isEmpty ? "1" : "0",
            is_switchon: getTime(wednesdayHoursView.txtOpen.text ?? "").isEmpty ? "false" : "true")
        )
        
        scheduleData.append(ScheduleDay(
            day_name: "Thursday",
            state_time: getTime(thursdayHoursView.txtOpen.text ?? ""),
            end_time: getTime(thursdayHoursView.txtClose.text ?? ""),
            is_status: getTime(thursdayHoursView.txtOpen.text ?? "").isEmpty ? "1" : "0",
            is_switchon: getTime(thursdayHoursView.txtOpen.text ?? "").isEmpty ? "false" : "true")
        )
        
        scheduleData.append(ScheduleDay(
            day_name: "Friday",
            state_time: getTime(fridayHoursView.txtOpen.text ?? ""),
            end_time: getTime(fridayHoursView.txtClose.text ?? ""),
            is_status: getTime(fridayHoursView.txtOpen.text ?? "").isEmpty ? "1" : "0",
            is_switchon: getTime(fridayHoursView.txtOpen.text ?? "").isEmpty ? "false" : "true")
        )
        
        scheduleData.append(ScheduleDay(
            day_name: "Saturday",
            state_time: getTime(saturdayHoursView.txtOpen.text ?? ""),
            end_time: getTime(saturdayHoursView.txtClose.text ?? ""),
            is_status: getTime(saturdayHoursView.txtOpen.text ?? "").isEmpty ? "1" : "0",
            is_switchon: getTime(saturdayHoursView.txtOpen.text ?? "").isEmpty ? "false" : "true")
        )
        
        print(scheduleData)
        
        // Encode to JSON
        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
        encoder.outputFormatting = [.sortedKeys, .withoutEscapingSlashes]
        if let jsonData = try? encoder.encode(scheduleData) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                // Print the JSON representation
                print("JSON Representation:\(jsonString)")
                self.operationHours = jsonString.replacingOccurrences(of: " : ", with: ":")
                viewModel?.details = self.operationHours
                printDetails(viewModel?.details)
                print("******\(viewModel?.details ?? "")")
            }
        }
    }

}


struct ScheduleDay: Encodable {
    let day_name: String
    var state_time: String
    var end_time: String
    var is_status: String
    var is_switchon: String

    init(day_name: String, state_time: String, end_time: String, is_status: String, is_switchon: String) {
        self.day_name = day_name
        self.state_time = state_time
        self.end_time = end_time
        self.is_status = is_status
        self.is_switchon = is_switchon
    }

    enum CodingKeys: String, CodingKey {
        case day_name
        case state_time
        case end_time
        case is_status
        case is_switchon
    }
}


extension AddDispensaryVC: AddDispensaryVMObserver{
    func observerCreateDispensaryApi() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
