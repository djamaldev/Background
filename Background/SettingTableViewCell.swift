//
//  SettingTableViewCell.swift
//  Background
//
//  Created by mr Yacine on 5/22/19.
//  Copyright © 2019 mr Yacine. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var NameLbl: UILabel!
    
    
    func Update(Setting: SettingObj){
       self.NameLbl.text = Setting.Name
        self.ImageView.image = Setting.icon
    }
    
}
