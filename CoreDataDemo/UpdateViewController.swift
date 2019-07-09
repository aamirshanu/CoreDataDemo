//
//  UpdateViewController.swift
//  CoreDataDemo
//
//  Created by mac on 24/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreData

class UpdateViewController: UIViewController {

    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtName: UITextField!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var student: StudentDetails!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtName.text = student.name
        txtPhone.text = student.phone
        txtDOB.text = student.dateOfBirth
    }

    @IBAction func btnUpdate(_ sender: UIButton) {
        // Update Coredata
        student.setValue(txtName.text, forKey: "name")
        student.setValue(txtPhone.text, forKey: "phone")
        student.setValue(txtDOB.text, forKey: "dateOfBirth")
        
        do{
            try context.save()
        }catch{
            print(error)
            
        }
        navigationController?.popViewController(animated: true)
    }
    

}
