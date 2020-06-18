//
//  CustomViewCell.swift
//  LearnCoreData
//
//  Created by Ngoduc on 6/13/20.
//  Copyright © 2020 com.techmaster.D. All rights reserved.
//

import UIKit

class CustomViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
   
    @IBOutlet weak var conten: UILabel!
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
          
       
    }
    
}
