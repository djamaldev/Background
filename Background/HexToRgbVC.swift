//
//  HexToRgbVC.swift
//  Background
//
//  Created by mr Yacine on 5/23/19.
//  Copyright © 2019 mr Yacine. All rights reserved.
//

import UIKit

class HexToRgbVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var FirstHex: UITextField!
    @IBOutlet weak var SecondHex: UITextField!
    @IBOutlet weak var firestRgbLbl: UILabel!
    @IBOutlet weak var secondRgbLbl: UILabel!
    var tapGesture = UITapGestureRecognizer()
    var tapGesture1 = UITapGestureRecognizer()
    var isCopied: Bool = false
    @IBOutlet weak var BouttomConstraint: NSLayoutConstraint!
    @IBOutlet weak var theBigView: NSLayoutConstraint!
    @IBOutlet weak var BigView: UIView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        firestRgbLbl.isHidden = true
        secondRgbLbl.isHidden = true
        CopyFirstHex()
        CopySecondHex()
        FirstHex.delegate = self
        SecondHex.delegate = self
    }
    
    @IBAction func ConvertBtn(_ sender: UIButton) {
        if FirstHex.text == "" && SecondHex.text == "" {
            AlertView(Message: "Fields is Empty")
        }else {
        guard let txt1 = FirstHex.text, let txt2 = SecondHex.text else {return}
        let gold1 = UIColor.StringFromUIColor(color: txt1.he())
        let gold2 = UIColor.StringFromUIColor(color: txt2.he())
        self.firestRgbLbl.text = gold1
        self.secondRgbLbl.text = gold2
        firestRgbLbl.isHidden = false
        secondRgbLbl.isHidden = false
        }
    }
    
    func CopyFirstHex(){
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureMethod(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        firestRgbLbl.isUserInteractionEnabled = true
        firestRgbLbl.addGestureRecognizer(tapGesture)
    }
    
    func CopySecondHex(){
        tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(tapGestureMethod1(_:)))
        tapGesture1.numberOfTapsRequired = 1
        tapGesture1.numberOfTouchesRequired = 1
        secondRgbLbl.isUserInteractionEnabled = true
        secondRgbLbl.addGestureRecognizer(tapGesture1)
    }
    
    @objc func tapGestureMethod(_ gesture: UITapGestureRecognizer) {
        if let text = firestRgbLbl.text {
            UIPasteboard.general.string = text
            isCopied = true
            firestRgbLbl.fadeIn()
            AlertView(Message: "Copied To Clipoard")
            if isCopied == false{
                firestRgbLbl.fadeOut()
            }
        }
    }
    
    @objc func tapGestureMethod1(_ gesture: UITapGestureRecognizer) {
        if let text = secondRgbLbl.text {
            UIPasteboard.general.string = text
            isCopied = true
            secondRgbLbl.fadeIn()
            AlertView(Message: "Copied To Clipoard")
            if isCopied == false{
                secondRgbLbl.fadeOut()
            }
        }
    }
    
    func AlertView(Message: String){
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -50, up: true)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -50, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.BigView.frame = self.BigView.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}
