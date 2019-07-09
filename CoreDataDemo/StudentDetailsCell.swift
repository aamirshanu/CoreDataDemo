//
//  StudentDetailsCell.swift
//  CoreDataDemo
//
//  Created by mac on 24/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class StudentDetailsCell: UITableViewCell {

   
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var lblDateOfBirth: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
