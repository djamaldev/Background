//
//  XView.swift
//  Background
//
//  Created by mr Yacine on 5/10/19.
//  Copyright © 2019 mr Yacine. All rights reserved.
//
import UIKit

class XView  : UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 4
    }
}

class xButton: UIButton{
    
    func CircleCurvesAction() {
        self.layer.cornerRadius = 8
        
    }
}
