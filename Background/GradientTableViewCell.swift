//
//  GradientTableViewCell.swift
//  Background
//
//  Created by mr Yacine on 5/19/19.
//  Copyright © 2019 mr Yacine. All rights reserved.
//

import UIKit

class GradientTableViewCell: UITableViewCell {

    @IBOutlet weak var theView: UIView!
    var gradientLayer : CAGradientLayer!

    func creatGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.contentView.bounds
        gradientLayer.colors = [ArrayColor[3].FirstColor.he().cgColor, ArrayColor[0].SecondColor.he().cgColor]
        self.theView.layer.cornerRadius = 4
        gradientLayer.zPosition = -1
        self.theView.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.contentView.bounds
    }
    
    func update(Colors : HexaObject){
        creatGradientLayer()
        guard let firstC = Colors.FirstColor, let secondC = Colors.SecondColor else {return}
        gradientLayer.colors = [firstC.he().cgColor, secondC.he().cgColor]
    }
}
