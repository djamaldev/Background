//
//  ViewGradient.swift
//  Background
//
//  Created by mr Yacine on 5/13/19.
//  Copyright © 2019 mr Yacine. All rights reserved.
//

import UIKit

class ViewGradient: UIViewController {

    @IBOutlet weak var theView: UIView!
    var array: ToHex?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theView.addBlackGradientLayerInBackground(frame: view.bounds, colors: array!)
        
    }
    @IBAction func SaveImage(_ sender: UIBarButtonItem) {
        let viewImage = theView.createImage()
        UIImageWriteToSavedPhotosAlbum(viewImage, self, #selector(Saveimage(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func Saveimage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}

extension UIView{
    // For insert layer in background
    func addBlackGradientLayerInBackground(frame: CGRect, colors: ToHex){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [colors.FirstColor.he().cgColor, colors.SecondColor.he().cgColor]
        gradient.startPoint = CGPoint(x : 0.0, y : 0.5)
        gradient.endPoint = CGPoint(x :1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 1)
    }
    
    func addArray(frame: CGRect, colors: HexaObject){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [colors.FirstColor!.he().cgColor, colors.SecondColor!.he().cgColor]
        gradient.startPoint = CGPoint(x : 0.0, y : 0.5)
        gradient.endPoint = CGPoint(x :1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 1)
    }
    
    func createImage() -> UIImage {
        
        let rect: CGRect = self.frame
        
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        self.layer.render(in: context)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
        
    }
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.5, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.5, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            completion(true)
        }
    }
    
    var parentController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
