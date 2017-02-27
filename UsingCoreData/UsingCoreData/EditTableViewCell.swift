//
//  EditTableViewCell.swift
//  HitList
//
//  Created by Appinventiv on 27/02/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class EditTableViewCell: UITableViewCell {

    @IBOutlet weak var requirementAnswer: UITextField!
    @IBOutlet weak var requirement: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
   
  
}
