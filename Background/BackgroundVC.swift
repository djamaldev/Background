//
//  BackgroundVC.swift
//  Background
//
//  Created by mr Yacine on 5/10/19.
//  Copyright © 2019 mr Yacine. All rights reserved.
//

import UIKit
import GoogleMobileAds

class BackgroundVC: UIViewController, GADBannerViewDelegate, GADInterstitialDelegate{

    @IBOutlet weak var CollectionView: UICollectionView!
    
    var colors = UIColor()
    @IBOutlet var adBannerView: GADBannerView!
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.register(UINib(nibName: "ColorsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        CollectionView.delegate = self
        CollectionView.dataSource = self
        AdBanner()
    }
    
    
    //////////////////////// AD Mob////////////////////////////////////////
    ////////////////////////       ////////////////////////////////////////
    func AdBanner(){
        //ca-app-pub-3940256099942544/4411468910
        adBannerView.adUnitID = "ca-app-pub-7106415214207784/1531520703"
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-7106415214207784/5969281555")
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        interstitial.delegate = self
        let request = GADRequest()
        //request.testDevices = ["a29ca877754c715e8890b14689f514bc"]//[kGADSimulatorID]
        //req.testDevices = [ kGADSimulatorID, "a29ca877754c715e8890b14689f514bc" ]
        adBannerView.load(request)
        interstitial.load(request)
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        if ad.isReady {
            interstitial!.present(fromRootViewController: self)
        }
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
    
    ///////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////
}

extension BackgroundVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MyCellDelegate {
    
    func lblNameTapped(cell: ColorsCollectionViewCell) {
        let indexPath = self.CollectionView.indexPath(for: cell)
        print(indexPath!.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArrayColor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cel = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ColorsCollectionViewCell
        cel.update(Colors: ArrayColor[indexPath.row])
        cel.SetTextHexa(text: ArrayColor[indexPath.row])
        cel.SetHex = {
            cel.delegate = self
        }
        return cel
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.width / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "Colors", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let next = segue.destination as? ViewGradient {
            if let indexRow = sender as? Int {
                next.array = ArrayColor[indexRow]
            }
        }
    }
}

