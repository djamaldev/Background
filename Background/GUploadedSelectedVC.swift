//
//  GUploadedSelectedVC.swift
//  Background
//
//  Created by mr Yacine on 5/21/19.
//  Copyright © 2019 mr Yacine. All rights reserved.
//

import UIKit

class GUploadedSelectedVC: UIViewController {

    @IBOutlet weak var theView: UIView!

    var hexaArray: HexaObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theView.addArray(frame: view.bounds, colors: hexaArray!)
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
