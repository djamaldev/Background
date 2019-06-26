//
//  ColorsCollectionViewCell.swift
//  Background
//
//  Created by mr Yacine on 5/10/19.
//  Copyright © 2019 mr Yacine. All rights reserved.
//

import UIKit

protocol MyCellDelegate {
    func lblNameTapped(cell: ColorsCollectionViewCell)
}

class ColorsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var theView: UIView!
    @IBOutlet weak var HexLbl: UILabel!
    //@IBOutlet weak var tapGesture: UITapGestureRecognizer!
    var tapGesture = UITapGestureRecognizer()
    var gradientLayer : CAGradientLayer!
    var SetHex: (()->())?
    var SetRGB: (()->())?
    var delegate: MyCellDelegate?
    var isCopied: Bool = false
    var array: ToHex!
    
    
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
    
    func update(Colors : ToHex){
        creatGradientLayer()
        gradientLayer.colors = [Colors.FirstColor.he().cgColor, Colors.SecondColor.he().cgColor]
    }
    
    func SetTextHexa(text: ToHex){
        HexLbl.text = "\(text.FirstColor) . \(text.SecondColor)"
    }
    
    /*@IBAction func SetHexa(_ sender: UIButton) {
        SetHex?()
    }*/
    /*@IBAction func SetRGB(_ sender: UIButton) {
        SetRGB?()
    }*/
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        SetHex?()
    }
    
    @objc func tapGestureMethod(_ gesture: UITapGestureRecognizer) {
        if let text1 = HexLbl.text {
                UIPasteboard.general.string = text1
            isCopied = true
            HexLbl.fadeIn()
            if let vc = self.parentController{
                let alert = UIAlertController(title: "Alert", message: "Copied To Clipoard.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                vc.present(alert, animated: true, completion: nil)
            }
            if isCopied == false{
                HexLbl.fadeOut()
            }
        }
    }
    
    func CopyHex(){
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureMethod(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        HexLbl.isUserInteractionEnabled = true
        HexLbl.addGestureRecognizer(tapGesture)
        HexLbl.fadeIn()
    }
    
    func lblNameTapped(sender: AnyObject){
        delegate?.lblNameTapped(cell: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CopyHex()
        HexLbl.layer.masksToBounds = true
        HexLbl.layer.cornerRadius = 8
        HexLbl.layer.borderWidth = 2
        theView.layer.masksToBounds = true
        theView.layer.cornerRadius = 6
        //theView.layer.borderWidth = 2
        self.frame.size.width = theView.frame.size.width
    }
}
