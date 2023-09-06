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
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openDatePicker()
        txtExpiration.delegate = self
        setWeekDayView()
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
        formatter.dateFormat = "dd/MM/yyyy"
        //formatter.dateStyle = .short
        txtExpiration.text = formatter.string(from: sender.date)
    }
    @objc func startTimePickerValueChanged(_ sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        switch openTimePickerTF {
        case mondayHoursView.txtOpen:
            mondayHoursView.txtOpen.text = timeFormatter.string(from: sender.date)
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
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cameraAction(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Camera", style: .default){ [self] action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera;
                imagePickerController.allowsEditing = true
                self.imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Camera not found", message: "This device has no camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default,handler: nil))
                present(alert, animated: true,completion: nil)
            }
        }
        let action1 = UIAlertAction(title: "Gallery", style: .default){ action in
            self.imagePickerController.allowsEditing = false
            self.imagePickerController.sourceType = .photoLibrary
            self.imagePickerController.delegate = self
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
    }
}
