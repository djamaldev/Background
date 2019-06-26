//
//  HexaObject.swift
//  Background
//
//  Created by mr Yacine on 5/19/19.
//  Copyright © 2019 mr Yacine. All rights reserved.
//
import Firebase

class HexaObject {
    var ID: String?
    var FirstColor : String?
    var SecondColor : String?
    
    init(ID: String, FirstColor : String, SecondColor : String) {
        self.ID = ID
        self.FirstColor = FirstColor
        self.SecondColor = SecondColor
    }
    
    init(Dictionary: [String : AnyObject]) {
        self.ID = Dictionary["ID"] as? String
        self.FirstColor = Dictionary["FirstColor"] as? String
        self.SecondColor = Dictionary["SecondColor"] as? String
    }
    
    func GetDectionary()->[String : AnyObject]{
        var new : [String : AnyObject] = [:]
        new["ID"] = self.ID as AnyObject
        new["FirstColor"] = self.FirstColor as AnyObject
        new["SecondColor"] = self.SecondColor as AnyObject
        return new
    }
    
    func Upload(){
        guard  let id = self.ID else {return}
        Database.database().reference().child("Gradients").child(id).setValue(GetDectionary())
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "GradientAdded"), object: nil)
    }
}

class ColorsAPI {
    
    static func GetAllData(completion: @escaping (_ gradient: [HexaObject])->()){
        
        Database.database().reference().child("Gradients").observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            if let dectionary = snapshot.value as? [String: [String: AnyObject]]{
                var temp : [HexaObject] = []
                for dect in dectionary.values{
                    temp.append(HexaObject(Dictionary: dect))
                    if temp.count == dectionary.count {
                        completion(temp)
                        //print(dect)
                    }
                }
            }
            /*if !snapshot.exists() { return }
            
            print(snapshot)*/
        }
    }
}
