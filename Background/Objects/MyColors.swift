//
//  MyColors.swift
//  Background
//
//  Created by mr Yacine on 5/10/19.
//  Copyright © 2019 mr Yacine. All rights reserved.
//

import UIKit
import Firebase

private class Mycolors {
    
    static func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
extension String {
    func he() -> UIColor {
        return Mycolors.hexStringToUIColor(hex: self)
    }
}


class ToHex {
    var FirstColor : String
    var SecondColor : String
    
    init(FirstColor : String, SecondColor : String) {
        self.FirstColor = FirstColor
        self.SecondColor = SecondColor
    }
    
    init(Dictionary: [String : AnyObject]) {
        self.FirstColor = Dictionary["FirstColor"] as! String
        self.SecondColor = Dictionary["SecondColor"] as! String
    }
    
    func GetDectionary()->[String : AnyObject]{
        var new : [String : AnyObject] = [:]
        new["FirstColor"] = self.FirstColor as AnyObject
        new["SecondColor"] = self.SecondColor as AnyObject
        return new
    }
    
    func Upload(){
        Database.database().reference().child("Gradients").setValue(GetDectionary())
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "GradientAdded"), object: nil)
    }
}

class Trgb {
    var r: CGFloat
    var g: CGFloat
    var b: CGFloat
    var a: CGFloat
    
    init(r: CGFloat, b:CGFloat, g: CGFloat, a: CGFloat) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
}

var ArrayColor : [ToHex] = [
    ToHex(FirstColor: "00bfff", SecondColor: "0040ff"),
    ToHex(FirstColor: "bf00ff", SecondColor: "ff00ff"),
    ToHex(FirstColor: "ff00bf", SecondColor: "ff0080"),
    ToHex(FirstColor: "ff0040", SecondColor: "ff0000"),
    ToHex(FirstColor: "ff0084", SecondColor: "33001b"),
    ToHex(FirstColor: "000428", SecondColor: "004e92"),
    ToHex(FirstColor: "ef32d9", SecondColor: "89fffd"),
    ToHex(FirstColor: "16bffd", SecondColor: "cb3066"),
    ToHex(FirstColor: "3a6186", SecondColor: "89253e"),
    ToHex(FirstColor: "ffb75e", SecondColor: "ed8f03"),
    ToHex(FirstColor: "8e0e00", SecondColor: "1f1c18"),
    ToHex(FirstColor: "fd1d1d", SecondColor: "fcb045"),
    ToHex(FirstColor: "1e3c72", SecondColor: "2a5298"),
    ToHex(FirstColor: "6441a5", SecondColor: "2a0845"),
    ToHex(FirstColor: "3a7bd5", SecondColor: "3a6073"),
    ToHex(FirstColor: "f7ff00", SecondColor: "db36a4"),
    ToHex(FirstColor: "a1ffce", SecondColor: "89fffd"),
    ToHex(FirstColor: "673ab7", SecondColor: "512da8"),
    ToHex(FirstColor: "6a3093", SecondColor: "a044ff"),
    ToHex(FirstColor: "f46b45", SecondColor: "eea849"),
    ToHex(FirstColor: "833ab4", SecondColor: "fcb045"),
    ToHex(FirstColor: "b24592", SecondColor: "f15f79"),
    ToHex(FirstColor: "ff4b1f", SecondColor: "1fddff"),
    ToHex(FirstColor: "00d2ff", SecondColor: "928dab"),
    ToHex(FirstColor: "c02425", SecondColor: "f0cb35"),
    ToHex(FirstColor: "7b4397", SecondColor: "dc2430"),
    ToHex(FirstColor: "457fca", SecondColor: "5691c8"),
    ToHex(FirstColor: "005c97", SecondColor: "363795"),
    ToHex(FirstColor: "fd746c", SecondColor: "ff9068"),
    ToHex(FirstColor: "c2e59c", SecondColor: "64b3f4"),
    ToHex(FirstColor: "e96443", SecondColor: "904e95"),
    ToHex(FirstColor: "eacda3", SecondColor: "d6ae7b"),
    ToHex(FirstColor: "f44336", SecondColor: "2196f3"),
    ToHex(FirstColor: "14007b", SecondColor: "faffd1"),
    ToHex(FirstColor: "76b852", SecondColor: "8dc26f"),
    ToHex(FirstColor: "be93c5", SecondColor: "7bc6cc"),
    ToHex(FirstColor: "0b486b", SecondColor: "f56217"),
    ToHex(FirstColor: "ff5f6d", SecondColor: "ffc371"),
    ToHex(FirstColor: "ff4b1f", SecondColor: "ff9068"),
    ToHex(FirstColor: "00c9ff", SecondColor: "92fe9d"),
    ToHex(FirstColor: "eecda3", SecondColor: "ef629f"),
    ToHex(FirstColor: "1d4350", SecondColor: "a43931"),
    ToHex(FirstColor: "a80077", SecondColor: "66ff00"),
    ToHex(FirstColor: "0099f7", SecondColor: "f11712"),
    ToHex(FirstColor: "2980b9", SecondColor: "2c3e50"),
    ToHex(FirstColor: "5a3f37", SecondColor: "2c7744"),
    ToHex(FirstColor: "4da0b0", SecondColor: "d39d38"),
    ToHex(FirstColor: "5614b0", SecondColor: "dbd65c"),
    ToHex(FirstColor: "2f7336", SecondColor: "aa3a38"),
    ToHex(FirstColor: "e53935", SecondColor: "e35d5b"),
    ToHex(FirstColor: "ba8b02", SecondColor: "181818"),
    ToHex(FirstColor: "004ff9", SecondColor: "fff94c"),
    ToHex(FirstColor: "d1913c", SecondColor: "ffd194"),
    ToHex(FirstColor: "fceabb", SecondColor: "f8b500"),
    ToHex(FirstColor: "f85032", SecondColor: "e73827"),
    ToHex(FirstColor: "f79d00", SecondColor: "64f38c"),
    ToHex(FirstColor: "cb2d3e", SecondColor: "ef473a"),
    ToHex(FirstColor: "56ab2f", SecondColor: "a8e063"),
    ToHex(FirstColor: "f5e44c", SecondColor: "f787ff"),
    ToHex(FirstColor: "2b000c", SecondColor: "2b001c"),
    ToHex(FirstColor: "80ff00", SecondColor: "40ff00"),
    ToHex(FirstColor: "00ffbf", SecondColor: "00ffff"),
    ToHex(FirstColor: "00bf8f", SecondColor: "001510"),
    ToHex(FirstColor: "ff0055", SecondColor: "ff007b")]


extension UIColor {
    static func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func StringFromUIColor(color: UIColor) -> String {
        let components = color.cgColor.components
        return "[\(components![0].rgb), \(components![1].rgb), \(components![2].rgb), \(components![3].rgb)]"
    }
}

extension CGFloat {
    var swf: Double {
        return Double(self)
    }
    var rgb:String {
        return String(format: "%.2f", swf)
    }
}
