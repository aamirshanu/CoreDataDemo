//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by mac on 24/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var studentArr = [StudentDetails]()

   
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDetails()
    }

    @IBAction func btnNavigateToAdd(_ sender: UIBarButtonItem) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddDetailsViewController") as! AddDetailsViewController
        navigationController?.pushViewController(vc, animated: true)
    }

    func loadDetails(){
        // Read data from CoreData
        let request: NSFetchRequest<StudentDetails> = StudentDetails.fetchRequest()
        do{
           studentArr = try context.fetch(request)
            tableView.reloadData()
        }catch{
            print(error)
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
extension ViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return studentArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StudentDetailsCell

        cell.lblName.text = studentArr[indexPath.row].name
        cell.lblPhone.text = studentArr[indexPath.row].phone
        cell.lblDateOfBirth.text = studentArr[indexPath.row].dateOfBirth
        cell.imageViewCell.image = UIImage(data: studentArr[indexPath.row].image!)
        
        return cell
    }
    
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
        vc.student = studentArr[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete data from Coredata
            context.delete(studentArr[indexPath.row])
            studentArr.remove(at: indexPath.row)
            saveDetails()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
