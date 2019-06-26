//
//  SettingVC.swift
//  Background
//
//  Created by mr Yacine on 5/22/19.
//  Copyright © 2019 mr Yacine. All rights reserved.
//

import UIKit
import StoreKit

class SettingVC: UIViewController {
    
    var Object: [SettingObj] = []
    var viewRGB = UIView()
    var FirstrgbLbl = UILabel()
    var SecondrgbLbl = UILabel()
    var ok = UIButton()
    private let SCREEN_SIZE = UIScreen.main.bounds
    private let GAP_BETWEEN_VIEWS:CGFloat = 0.08

    @IBOutlet weak var tableView: UITableView! { didSet {tableView.delegate = self; tableView.dataSource = self } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        SetUp()
        //AddView()
    }
    
    func SetUp(){
        Object.append(SettingObj(Name: "Hex Color To RGB", icon: #imageLiteral(resourceName: "rgb"), Action: {
            self.performSegue(withIdentifier: "convert", sender: nil)
        }))
        
        Object.append(SettingObj(Name: "Twitter", icon: #imageLiteral(resourceName: "twitter"), Action: {
            let TwitterUserName = "@NalticeD"
            let appURL = URL(string: "twitter://user?screen_name=\(TwitterUserName)")!
            let webURL = URL(string: "https://twitter.com/\(TwitterUserName)")!
            let application = UIApplication.shared
            if application.canOpenURL(appURL) {
                UIApplication.shared.open(appURL, options: [:] , completionHandler: nil)
            }
            else {
                UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
            }
        }))
        //1465390229
        Object.append(SettingObj(Name: "Rate App", icon: #imageLiteral(resourceName: "rate"), Action: {
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            } else {
                // Fallback on earlier versions
            }
        }))
        Object.append(SettingObj(Name: "Share App", icon: #imageLiteral(resourceName: "share"), Action: {
            //BassmaShop is an Application for online shopping you can download it from: https://itunes.apple.com/us/app/bassmashop/id1453686669?mt=8"
            let message = "GColors is an Application for Gradients Colors you can download it from: https://itunes.apple.com/us/app/bassmashop/1465390229?mt=8"
            let image = UIGraphicsGetImageFromCurrentImageContext()
            let objectsToShare = [message, image ?? #imageLiteral(resourceName: "icons8-rgb_circle_1")] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            //activityVC.popoverPresentationController?.sourceView = sender as? UIView
            self.present(activityVC, animated: true, completion: nil)
        }))
    }
    
    func AddView(){
        
        viewRGB.frame = CGRect.init(x: 0, y: 0, width: 300, height: 150)
        viewRGB.backgroundColor = UIColor.red
        viewRGB.center = self.view.center
       self.view.addSubview(viewRGB)
        //self.view.insertSubview(viewRGB, at: 0)
        FirstrgbLbl.frame = CGRect.init(x: 0, y: 0, width: 250, height: 45)
        SecondrgbLbl.frame = CGRect.init(x: 0, y: 50, width: 250, height: 45)
        ok.frame = CGRect.init(x: 100, y: 200, width: 100, height: 45)
        ok.backgroundColor = UIColor.blue
        viewRGB.addSubview(FirstrgbLbl)
        viewRGB.addSubview(SecondrgbLbl)
        viewRGB.addSubview(ok)
    }

}

extension SettingVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Object.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SettingTableViewCell
        cell.Update(Setting: Object[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Object[indexPath.row].Action?()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
