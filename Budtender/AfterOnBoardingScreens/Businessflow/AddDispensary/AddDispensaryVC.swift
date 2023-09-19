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
    var operationHours: String?
    var scheduleData: [ScheduleDay] = []
    var viewModel: AddDispensaryVM?
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
    
    @IBAction func createAction(_ sender: UIButton) {
        self.scheduleData = []
        setHours()
        // Filter out entries that have both start_time and end_time
        let filteredScheduleData = scheduleData.filter { day in
            return !day.start_time.isEmpty && !day.end_time.isEmpty
        }
        
        print(filteredScheduleData)

        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(filteredScheduleData) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                // Now jsonString contains the JSON representation of the data in the desired format
                print(jsonString)
                self.operationHours = jsonString
                // Here, you can send the jsonString to the server using an HTTP request
            }
        }
        
        
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
        guard isValidPhone.0 == true else {
            Singleton.showMessage(message: isValidPhone.1, isError: .error)
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
        if scheduleData.isEmpty{
            showMessage(message: "Please select hours of operation", isError: .error)
        }
        viewModel?.addDispensaryApi(name: txtDispensaryName.text ?? "", phoneNumber: txtPhoneNumber.text ?? "", email: txtEmail.text ?? "", country: txtCountry.text ?? "", address: txtAddress.text ?? "", city: txtCity.text ?? "", state: txtState.text ?? "", postalCode: txtPostalCode.text ?? "", website: txtWebsite.text ?? "", license: txtLicense.text ?? "", expiration: txtExpiration.text ?? "", image: "", longitude: "0", latitude: "0", operationDetail: self.operationHours ?? "")
        
    }
    func setHours() {
       
        if let startSunday = sundayHoursView.txtOpen.text, let endSunday = sundayHoursView.txtClose.text {
            scheduleData.append(ScheduleDay(day_name: "sunday", start_time: startSunday, end_time: endSunday, is_status: "0"))
        }

        if let startMonday = mondayHoursView.txtOpen.text, let endMonday = mondayHoursView.txtClose.text {
            scheduleData.append(ScheduleDay(day_name: "monday", start_time: startMonday, end_time: endMonday, is_status: "0"))
        }
        if let startTuesday = tuesdayHoursView.txtOpen.text, let endTuesday = tuesdayHoursView.txtClose.text {
            scheduleData.append(ScheduleDay(day_name: "tuesday", start_time: startTuesday, end_time: endTuesday, is_status: "0"))
        }
        if let startWednesday = wednesdayHoursView.txtOpen.text, let endWednesday = wednesdayHoursView.txtClose.text {
            scheduleData.append(ScheduleDay(day_name: "wednesday", start_time: startWednesday, end_time: endWednesday, is_status: "0"))
        }
        if let startThursday = thursdayHoursView.txtOpen.text, let endThursday = thursdayHoursView.txtClose.text {
            scheduleData.append(ScheduleDay(day_name: "thursday", start_time: startThursday, end_time: endThursday, is_status: "0"))
        }
        if let startFriday = fridayHoursView.txtOpen.text, let endFriday = fridayHoursView.txtClose.text {
            scheduleData.append(ScheduleDay(day_name: "friday", start_time: startFriday, end_time: endFriday, is_status: "0"))
        }
        if let startSaturday = saturdayHoursView.txtOpen.text, let endSaturday = saturdayHoursView.txtClose.text {
            scheduleData.append(ScheduleDay(day_name: "saturday", start_time: startSaturday, end_time: endSaturday, is_status: "0"))
        }
        

//        // Filter out entries that have both start_time and end_time
//        let filteredScheduleData = scheduleData.filter { day in
//            return !day.start_time.isEmpty && !day.end_time.isEmpty
//        }
//        self.operationArray = filteredScheduleData
//        print(self.operationArray.count)
//        print(filteredScheduleData)
//
//        let encoder = JSONEncoder()
//        if let jsonData = try? encoder.encode(filteredScheduleData) {
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                // Now jsonString contains the JSON representation of the data in the desired format
//                print(jsonString)
//                // Here, you can send the jsonString to the server using an HTTP request
//            }
//        }
    }


}

struct ScheduleDay: Encodable {
    let day_name: String
    let start_time: String
    let end_time: String
    let is_status: String

    enum CodingKeys: String, CodingKey {
        case day_name
        case start_time
        case end_time
        case is_status
    }
}
extension AddDispensaryVC: AddDispensaryVMObserver{
    func observerCreateDispensaryApi() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
