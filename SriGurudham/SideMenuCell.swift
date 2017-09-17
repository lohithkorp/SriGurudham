//
//  SideMenuCell.swift
//  SriGurudham
//
//  Created by Lohith Krishna Korupolu on 17/09/2017.
//  Copyright © 2017 Sri Gurudham. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    @IBOutlet weak var menuItemIcon: UIImageView!
    @IBOutlet weak var menuItemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
