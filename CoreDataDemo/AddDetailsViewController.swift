//
//  AddDetailsViewController.swift
//  CoreDataDemo
//
//  Created by mac on 24/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreData

class AddDetailsViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var viewDatePicker: UIView!
    @IBOutlet weak var SaveBtn: UIButton!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var viewBottomConstrant: NSLayoutConstraint!
    
    let image = UIImagePickerController()
    var detailsArray = [StudentDetails]()
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

        txtPhone.keyboardType = .asciiCapableNumberPad
        // Do any additional setup after loading the view.
        image.delegate = self
        
        print(filePath)
    }

    @IBAction func pickerDateChanged(_ sender: UIDatePicker) {
        datePicker.datePickerMode = .date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        txtDOB.text = selectedDate
        print(selectedDate)
    }
    @IBAction func btnDOB(_ sender: UIButton) {
        SaveBtn.isHidden = true
        showHideTimePicker(isShow: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        print("Button Pressed")
        if txtName.text == "" || txtPhone.text == "" || txtDOB.text == ""{
            print("Add required")
        }else{
         // Create Coredata data
        let details = StudentDetails(context: context)
        details.name = txtName.text
        details.phone = txtPhone.text
        details.dateOfBirth = txtDOB.text
        details.image = UIImagePNGRepresentation(imageView.image!)

        detailsArray.append(details)
        saveDetails()
            print("success ")
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            imageView.image = image
        }else{
            print("Error !!!!!!!")
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnDone(_ sender: Any) {
        viewBottomConstrant.constant = 238
        SaveBtn.isHidden = false
    }
    @IBAction func btnCancel(_ sender: Any) {
        viewBottomConstrant.constant = 238
        txtDOB.text = ""
        SaveBtn.isHidden = false
    }
    
    @IBAction func btnImageBrowse(_ sender: UIButton) {
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //image.sourceType = UIImagePickerControllerSourceType.camera
        image.allowsEditing = false
        self.present(image, animated: true){
            //code
        }
    }
    func showHideTimePicker(isShow: Bool) {
        if isShow {
            viewBottomConstrant.constant = 0
            datePicker.reloadInputViews()
        }else {
            viewBottomConstrant.constant = 238
        }
    }
    
    func saveDetails(){
        do
        {
           try  context.save()
        }catch{
            print("Error In savind\(error)")
        }
    }
}
