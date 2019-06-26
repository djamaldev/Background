//
//  SettingObj.swift
//  Background
//
//  Created by mr Yacine on 5/22/19.
//  Copyright © 2019 mr Yacine. All rights reserved.
//

import UIKit

class SettingObj{
    
    var Name: String
    var icon: UIImage
    var Action: (()->())?
    
    init(Name: String, icon: UIImage, Action: @escaping ()->()) {
        self.Name = Name
        self.icon = icon
        self.Action = Action
    }
    
}
