//
//  AddDispensaryVC.swift
//  Budtender
//
//  Created by apple on 29/08/23.
//

import UIKit
import SKCountryPicker
import CoreLocation
import GoogleMaps
import GooglePlaces

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
    var lat: String?
    var long: String?
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
        txtAddress.delegate = self
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
            setEditDispensaryData()
        }
    }
    
    func setViewModel(){
        self.viewModel = AddDispensaryVM(observer: self)
//        setEditDispensaryData()
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
        print("\(lat)\(long)")
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
            fridayHoursView.txtOpen.text = hoursOfOperation?[5].state_time
            fridayHoursView.txtClose.text = hoursOfOperation?[5].end_time
        }else{
            fridayHoursView.switchOff()
        }
        if hoursOfOperation?[6].day_name == "Saturday" && hoursOfOperation?[6].is_switchon == "true"{
            saturdayHoursView.toggleSwitch.isOn = true
            saturdayHoursView.switchOn()
            saturdayHoursView.txtOpen.text = hoursOfOperation?[6].state_time
            saturdayHoursView.txtClose.text = hoursOfOperation?[6].end_time
        }else{
            saturdayHoursView.switchOff()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        openTimePickerTF = textField
    }
    func setWeekDayView() {
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
    func openDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        startTimePicker.datePickerMode = .time
//        startTimePicker.minimumDate = Date()
        endTimePicker.datePickerMode = .time
//        endTimePicker.minimumDate = Date()

        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.4, *) {
            startTimePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.4, *) {
            endTimePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
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
        if textField == txtExpiration {
            self.expirationDropDownButton.setImage(UIImage(named: "Ic_ShowDropDown"), for: .normal)
        }
        if textField == txtAddress{
    //        self.projectAdd1TF.resignFirstResponder()
    //        cancelAddressBtn.isHidden = false
    //        if projectAdd1TF.text == ""{
                let autocompleteController = GMSAutocompleteViewController()
                autocompleteController.delegate = self
                let fields: GMSPlaceField = [.addressComponents, .coordinate, .formattedAddress]
                    autocompleteController.placeFields = fields
    //            autocompleteController.placeFields = .coordinate
                present(autocompleteController, animated: true, completion: nil)
      
    //        }
        
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtExpiration {
            self.expirationDropDownButton.setImage(UIImage(named: "Ic_DropDown"), for: .normal)
        }
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
            mondayHoursView.txtClose.text = ""
        case tuesdayHoursView.txtOpen:
            tuesdayHoursView.txtOpen.text = timeFormatter.string(from: sender.date)
            tuesdayHoursView.txtClose.text = ""
        case wednesdayHoursView.txtOpen:
            wednesdayHoursView.txtOpen.text = timeFormatter.string(from: sender.date)
            wednesdayHoursView.txtClose.text = ""
        case thursdayHoursView.txtOpen:
            thursdayHoursView.txtOpen.text = timeFormatter.string(from: sender.date)
            thursdayHoursView.txtClose.text = ""
        case fridayHoursView.txtOpen:
            fridayHoursView.txtOpen.text = timeFormatter.string(from: sender.date)
            fridayHoursView.txtClose.text = ""
        case saturdayHoursView.txtOpen:
            saturdayHoursView.txtOpen.text = timeFormatter.string(from: sender.date)
            saturdayHoursView.txtClose.text = ""
        case sundayHoursView.txtOpen:
            sundayHoursView.txtOpen.text = timeFormatter.string(from: sender.date)
            sundayHoursView.txtClose.text = ""
        default:
            break
        }
    }
    
    @objc func endTimePickerValueChanged(_ sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        
        switch openTimePickerTF {
        case mondayHoursView.txtClose:
            guard let startTimeString = mondayHoursView.txtOpen.text,
                  let startTime = timeFormatter.date(from: startTimeString) else {
                // Handle invalid start time
                showMessage(message: "Please enter start time", isError: .error)
                return
            }
            
            let endTime = sender.date
            
            // Get calendar and components to compare time
            let calendar = Calendar.current
            let startComponents = calendar.dateComponents([.hour, .minute], from: startTime)
            let endComponents = calendar.dateComponents([.hour, .minute], from: endTime)
            
            if let startHour = startComponents.hour, let startMinute = startComponents.minute,
               let endHour = endComponents.hour, let endMinute = endComponents.minute {
//                if startHour > endHour || (startHour == endHour && startMinute > endMinute) {
//                    showMessage(message: "End time should be after start time", isError: .error)
//                    return
//                }
                
                if (startHour > endHour) {
                    showMessage(message: "End time should be after start time", isError: .error)
                    mondayHoursView.txtClose.text = ""
                    return
                } else if (startHour == endHour) {
                    if startMinute > endMinute {
                        showMessage(message: "End time should be after start time", isError: .error)
                        mondayHoursView.txtClose.text = ""
                        return
                    }
                }
                
            }
            
            mondayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
        
        // Add cases for other days as needed
            
        case tuesdayHoursView.txtClose:
            guard let startTimeString = tuesdayHoursView.txtOpen.text,
                  let startTime = timeFormatter.date(from: startTimeString) else {
                // Handle invalid start time
                showMessage(message: "Please enter start time", isError: .error)
                return
            }
            
            let endTime = sender.date
            
            // Get calendar and components to compare time
            let calendar = Calendar.current
            let startComponents = calendar.dateComponents([.hour, .minute], from: startTime)
            let endComponents = calendar.dateComponents([.hour, .minute], from: endTime)
            
            if let startHour = startComponents.hour, let startMinute = startComponents.minute,
               let endHour = endComponents.hour, let endMinute = endComponents.minute {
//                if startHour > endHour || (startHour == endHour && startMinute > endMinute) {
//                    showMessage(message: "End time should be after start time", isError: .error)
//                    return
//                }
                
                
                if (startHour > endHour) {
                    showMessage(message: "End time should be after start time", isError: .error)
                    tuesdayHoursView.txtClose.text = ""
                    return
                } else if (startHour == endHour) {
                    if startMinute > endMinute {
                        showMessage(message: "End time should be after start time", isError: .error)
                        tuesdayHoursView.txtClose.text = ""
                        return
                    }
                }
            }
            
            tuesdayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
            
        case wednesdayHoursView.txtClose:
            guard let startTimeString = wednesdayHoursView.txtOpen.text,
                  let startTime = timeFormatter.date(from: startTimeString) else {
                // Handle invalid start time
                showMessage(message: "Please enter start time", isError: .error)
                return
            }
            
            let endTime = sender.date
            
            // Get calendar and components to compare time
            let calendar = Calendar.current
            let startComponents = calendar.dateComponents([.hour, .minute], from: startTime)
            let endComponents = calendar.dateComponents([.hour, .minute], from: endTime)
            
            if let startHour = startComponents.hour, let startMinute = startComponents.minute,
               let endHour = endComponents.hour, let endMinute = endComponents.minute {
//                if startHour > endHour || (startHour == endHour && startMinute > endMinute) {
//                    showMessage(message: "End time should be after start time", isError: .error)
//                    return
//                }
                
                
                if (startHour > endHour) {
                    showMessage(message: "End time should be after start time", isError: .error)
                    wednesdayHoursView.txtClose.text = ""
                    return
                } else if (startHour == endHour) {
                    if startMinute > endMinute {
                        showMessage(message: "End time should be after start time", isError: .error)
                        wednesdayHoursView.txtClose.text = ""
                        return
                    }
                }
            }
            
            wednesdayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
            
        case thursdayHoursView.txtClose:
            guard let startTimeString = thursdayHoursView.txtOpen.text,
                  let startTime = timeFormatter.date(from: startTimeString) else {
                // Handle invalid start time
                showMessage(message: "Please enter start time", isError: .error)
                return
            }
            
            let endTime = sender.date
            
            // Get calendar and components to compare time
            let calendar = Calendar.current
            let startComponents = calendar.dateComponents([.hour, .minute], from: startTime)
            let endComponents = calendar.dateComponents([.hour, .minute], from: endTime)
            
            if let startHour = startComponents.hour, let startMinute = startComponents.minute,
               let endHour = endComponents.hour, let endMinute = endComponents.minute {
//                if startHour > endHour || (startHour == endHour && startMinute > endMinute) {
//                    showMessage(message: "End time should be after start time", isError: .error)
//                    return
//                }
                
                if (startHour > endHour) {
                    showMessage(message: "End time should be after start time", isError: .error)
                    thursdayHoursView.txtClose.text = ""
                    return
                } else if (startHour == endHour) {
                    if startMinute > endMinute {
                        showMessage(message: "End time should be after start time", isError: .error)
                        thursdayHoursView.txtClose.text = ""
                        return
                    }
                }
            }
            
            thursdayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
            
            
        case fridayHoursView.txtClose:
            guard let startTimeString = fridayHoursView.txtOpen.text,
                  let startTime = timeFormatter.date(from: startTimeString) else {
                // Handle invalid start time
                showMessage(message: "Please enter start time", isError: .error)
                return
            }
            
            let endTime = sender.date
            
            // Get calendar and components to compare time
            let calendar = Calendar.current
            let startComponents = calendar.dateComponents([.hour, .minute], from: startTime)
            let endComponents = calendar.dateComponents([.hour, .minute], from: endTime)
            
            if let startHour = startComponents.hour, let startMinute = startComponents.minute,
               let endHour = endComponents.hour, let endMinute = endComponents.minute {
//                if startHour > endHour || (startHour == endHour && startMinute > endMinute) {
//                    showMessage(message: "End time should be after start time", isError: .error)
//                    return
//                }
                
                
                if (startHour > endHour) {
                    showMessage(message: "End time should be after start time", isError: .error)
                    fridayHoursView.txtClose.text = ""
                    return
                } else if (startHour == endHour) {
                    if startMinute > endMinute {
                        showMessage(message: "End time should be after start time", isError: .error)
                        fridayHoursView.txtClose.text = ""
                        return
                    }
                }
            }
            
            fridayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
            
            
        case saturdayHoursView.txtClose:
            guard let startTimeString = saturdayHoursView.txtOpen.text,
                  let startTime = timeFormatter.date(from: startTimeString) else {
                // Handle invalid start time
                showMessage(message: "Please enter start time", isError: .error)
                return
            }
            
            let endTime = sender.date
            
            // Get calendar and components to compare time
            let calendar = Calendar.current
            let startComponents = calendar.dateComponents([.hour, .minute], from: startTime)
            let endComponents = calendar.dateComponents([.hour, .minute], from: endTime)
            
            if let startHour = startComponents.hour, let startMinute = startComponents.minute,
               let endHour = endComponents.hour, let endMinute = endComponents.minute {
//                if startHour > endHour || (startHour == endHour && startMinute > endMinute) {
//                    showMessage(message: "End time should be after start time", isError: .error)
//                    return
//                }
                
                if (startHour > endHour) {
                    showMessage(message: "End time should be after start time", isError: .error)
                    saturdayHoursView.txtClose.text = ""
                    return
                } else if (startHour == endHour) {
                    if startMinute > endMinute {
                        showMessage(message: "End time should be after start time", isError: .error)
                        saturdayHoursView.txtClose.text = ""
                        return
                    }
                }
            }
            
            saturdayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
            
            
        case sundayHoursView.txtClose:
            guard let startTimeString = sundayHoursView.txtOpen.text,
                  let startTime = timeFormatter.date(from: startTimeString) else {
                // Handle invalid start time
                showMessage(message: "Please enter start time", isError: .error)
                return
            }
            
            let endTime = sender.date
            
            // Get calendar and components to compare time
            let calendar = Calendar.current
            let startComponents = calendar.dateComponents([.hour, .minute], from: startTime)
            let endComponents = calendar.dateComponents([.hour, .minute], from: endTime)
            
            if let startHour = startComponents.hour, let startMinute = startComponents.minute,
               let endHour = endComponents.hour, let endMinute = endComponents.minute {
//                if startHour > endHour || (startHour == endHour && startMinute > endMinute) {
//                    showMessage(message: "End time should be after start time", isError: .error)
//                    return
//                }
                
                if (startHour > endHour) {
                    showMessage(message: "End time should be after start time", isError: .error)
                    sundayHoursView.txtClose.text = ""
                    return
                } else if (startHour == endHour) {
                    if startMinute > endMinute {
                        showMessage(message: "End time should be after start time", isError: .error)
                        sundayHoursView.txtClose.text = ""
                        return
                    }
                }
            }
            
            sundayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
        
        default:
            break
        }
    }


    
    
//    @objc func endTimePickerValueChanged(_ sender: UIDatePicker) {
//        let timeFormatter = DateFormatter()
//        timeFormatter.dateFormat = "h:mm a"
//        switch openTimePickerTF {
//        case mondayHoursView.txtClose:
//            mondayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
//        case tuesdayHoursView.txtClose:
//            tuesdayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
//        case wednesdayHoursView.txtClose:
//            wednesdayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
//        case thursdayHoursView.txtClose:
//            thursdayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
//        case fridayHoursView.txtClose:
//            fridayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
//        case saturdayHoursView.txtClose:
//            saturdayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
//        case sundayHoursView.txtClose:
//            sundayHoursView.txtClose.text = timeFormatter.string(from: sender.date)
//        default:
//            break
//        }
//    }
    
    
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
            let isValidWebsite = Validator.validateWebsite(candidate: txtWebsite.text ?? "")
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
            
            if allSwitchOff {
                showMessage(message: "Please select hours of operation", isError: .error)
            } else {
                if mondayHoursView.toggleSwitch.isOn {
                    if mondayHoursView.txtOpen.text == "" || mondayHoursView.txtClose.text == "" {
                        showMessage(message: "Open and close time is required for Monday", isError: .error)
                        return
                    }
                } else if tuesdayHoursView.toggleSwitch.isOn {
                    if tuesdayHoursView.txtOpen.text == "" || tuesdayHoursView.txtClose.text == ""{
                        showMessage(message: "Open and close time is required for Tuesday", isError: .error)
                        return
                    }
                } else if wednesdayHoursView.toggleSwitch.isOn {
                    if wednesdayHoursView.txtOpen.text == "" || wednesdayHoursView.txtClose.text == "" {
                        showMessage(message: "Open and close time is required for Wednesday", isError: .error)
                        return
                    }
                } else if thursdayHoursView.toggleSwitch.isOn {
                    if thursdayHoursView.txtOpen.text == "" || thursdayHoursView.txtClose.text == "" {
                        showMessage(message: "Open and close time is required for Thursday", isError: .error)
                        return
                    }
                } else if fridayHoursView.toggleSwitch.isOn {
                    if fridayHoursView.txtOpen.text == "" || fridayHoursView.txtClose.text == "" {
                        showMessage(message: "Open and close time is required for Friday", isError: .error)
                        return
                    }
                } else if saturdayHoursView.toggleSwitch.isOn {
                    if saturdayHoursView.txtOpen.text == "" || saturdayHoursView.txtClose.text == "" {
                        showMessage(message: "Open and close time is required for Saturday", isError: .error)
                        return
                    }
                } else if sundayHoursView.toggleSwitch.isOn {
                    if sundayHoursView.txtOpen.text == "" || sundayHoursView.txtClose.text == "" {
                        showMessage(message: "Open and close time is required for Sunday", isError: .error)
                        return
                    }
                }
                
                // All conditions are true, so call the API
                print("\(lat)\(long)")
                viewModel?.addDispensaryApi(name: txtDispensaryName.text ?? "", phoneNumber: txtPhoneNumber.text ?? "", email: txtEmail.text ?? "", country: txtCountry.text ?? "", address: txtAddress.text ?? "", city: txtCity.text ?? "", state: txtState.text ?? "", postalCode: txtPostalCode.text ?? "", website: txtWebsite.text ?? "", license: txtLicense.text ?? "", expiration: txtExpiration.text ?? "", image: "", longitude: self.long ?? "", latitude: self.lat ?? "", operationDetail: "", isStatus: "1")
            }
        } else {
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
            let isValidWebsite = Validator.validateWebsite(candidate: txtWebsite.text ?? "")
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
            
            if allSwitchOff {
                showMessage(message: "Please select hours of operation", isError: .error)
            } else {
                if mondayHoursView.toggleSwitch.isOn {
                    if mondayHoursView.txtOpen.text == "" || mondayHoursView.txtClose.text == "" {
                        showMessage(message: "Open and close time is required for Monday", isError: .error)
                        return
                    }
                } else if tuesdayHoursView.toggleSwitch.isOn {
                    if tuesdayHoursView.txtOpen.text == "" || tuesdayHoursView.txtClose.text == ""{
                        showMessage(message: "Open and close time is required for Tuesday", isError: .error)
                        return
                    }
                } else if wednesdayHoursView.toggleSwitch.isOn {
                    if wednesdayHoursView.txtOpen.text == "" || wednesdayHoursView.txtClose.text == "" {
                        showMessage(message: "Open and close time is required for Wednesday", isError: .error)
                        return
                    }
                } else if thursdayHoursView.toggleSwitch.isOn {
                    if thursdayHoursView.txtOpen.text == "" || thursdayHoursView.txtClose.text == "" {
                        showMessage(message: "Open and close time is required for Thursday", isError: .error)
                        return
                    }
                } else if fridayHoursView.toggleSwitch.isOn {
                    if fridayHoursView.txtOpen.text == "" || fridayHoursView.txtClose.text == "" {
                        showMessage(message: "Open and close time is required for Friday", isError: .error)
                        return
                    }
                } else if saturdayHoursView.toggleSwitch.isOn {
                    if saturdayHoursView.txtOpen.text == "" || saturdayHoursView.txtClose.text == "" {
                        showMessage(message: "Open and close time is required for Saturday", isError: .error)
                        return
                    }
                } else if sundayHoursView.toggleSwitch.isOn {
                    if sundayHoursView.txtOpen.text == "" || sundayHoursView.txtClose.text == ""{
                        showMessage(message: "Open and close time is required for Sunday", isError: .error)
                        return
                    }
                }
                
                // All conditions are true, so call the API
                let id = "\(self.id ?? 0)"
                print("\(lat)\(long)")
                viewModel?.editDispensaryApi(name: txtDispensaryName.text ?? "", phoneNumber: txtPhoneNumber.text ?? "", email: txtEmail.text ?? "", country: txtCountry.text ?? "", address: txtAddress.text ?? "", city: txtCity.text ?? "", state: txtState.text ?? "", postalCode: txtPostalCode.text ?? "", website: txtWebsite.text ?? "", license: txtLicense.text ?? "", expiration: txtExpiration.text ?? "", image: "", longitude: self.long ?? "", latitude: self.lat ?? "", operationDetail: "", isStatus: "1", id: id)
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
                let details = viewModel?.details
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
extension AddDispensaryVC: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didSelect prediction: GMSAutocompletePrediction) -> Bool {
           // Access the selected row data
           
           let selectedRowText = prediction.attributedPrimaryText.string
           print("Selected Row Text: \(selectedRowText)")
//        self.txtAddress.text = selectedRowText
           
           // Return false to prevent the default behavior of showing place details
           return true
       }

    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
 
//        let mapcoder = GMSGeocoder()
//        mapcoder.reverseGeocodeCoordinate(place.coordinate) { (response, error) in
//            print("placessssss === \(place.coordinate)")
//            if let address = place.addressComponents{
//                print(address)
//            }
//
//            if let error = error {
//                print("Geocoding error: \(error.localizedDescription)")
//                return
//            }
//
//            if let results = response?.results(), let firstResult = results.first {
//                let address = firstResult.lines?.joined(separator: ", ") ?? ""
//                let city = firstResult.locality ?? ""
//                let state = firstResult.administrativeArea ?? ""
//                let postalCode = firstResult.postalCode ?? ""
//
//                print("Address: \(address)")
//                print("City: \(city)")
//                print("State: \(state)")
//                print("Postal Code: \(postalCode)")
//
//                // Use the address, city, state, postalCode as needed
//            }
//        }
//
        
        
        if let address = place.formattedAddress{
            print(address)
            let fullAddress = address
            self.txtAddress.text = fullAddress

            // Split the address by comma and get the first component
            let components = fullAddress.components(separatedBy: ",")
            if let streetName = components.first?.trimmingCharacters(in: .whitespacesAndNewlines) {
                print("Street Name: \(streetName)")
//                self.txtAddress.text = streetName
            }
            
//            if components.count >= 2 {
//                // Extract the second component and trim any leading or trailing whitespace
//                let desiredComponent = components[1].trimmingCharacters(in: .whitespaces)
//                let nameComponent = components[2].trimmingCharacters(in: .whitespaces)
//                print("name Component: \(nameComponent)")
//                print("Desired Component: \(desiredComponent)") // Output: Industrial Area, Sector 74
//                let comma = ","
//                // Assign the desired component to the desired text field
//                let address2 = "\(desiredComponent)\(comma)\(nameComponent)"
//                print(address2)
////                self.projectAdd2TF.text = address2
//            }
                
            if components.count > 1 {
                let remainingAddress = components[1..<components.count].joined(separator: ",")
                let trimmedAddress = remainingAddress.trimmingCharacters(in: .whitespacesAndNewlines)
                print("Remaining Address: \(trimmedAddress)")
//                self.txtAddress.text = trimmedAddress
                let components = address.components(separatedBy: ",")
                var addressBeforeThirdComma = ""

                if components.count >= 3 {
                    addressBeforeThirdComma = components.prefix(3).joined(separator: ",")
//                    self.projectAdd2TF.text = addressBeforeThirdComma
                } else {
                    addressBeforeThirdComma = trimmedAddress
//                    self.projectAdd2TF.text = address
                }

                print(addressBeforeThirdComma)
            }
  
        }
        
        
        if let place = place.addressComponents{
            print("address ==== \(place)")
        }
     
        if let addressComponents = place.addressComponents {
                for component in addressComponents {
                    if let type = component.types.first {
                        switch type {
                        case "locality":
                            let city = component.name
                            print("City: \(city)")
                        case "administrative_area_level_1":
                            let state = component.name
                            print("State: \(state)")
                            self.txtState.text = state
                        case "country":
                            let country = component.name
                            print("Country: \(country)")
                        default:
                            break
                        }
                    }
                }
            }

       
        
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
                    self.txtCity.text = city
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
                let countryCode = placemark.isoCountryCode
                print(countryCode)
                self.txtCountry.text = country
                let address2 = placemark.subLocality
                print(address2)
                
                let postal = placemark.postalCode
                self.txtPostalCode.text = postal
                print(postal)

            }
        })
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
