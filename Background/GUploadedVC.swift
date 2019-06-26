//
//  GUploadedVC.swift
//  Background
//
//  Created by mr Yacine on 5/19/19.
//  Copyright © 2019 mr Yacine. All rights reserved.
//

import UIKit

class GUploadedVC: UIViewController {
    
    @IBOutlet weak var UploadBtn: xButton!
    @IBOutlet weak var collectionView: UICollectionView!{ didSet { collectionView.delegate = self; collectionView.dataSource = self } }
    var colors: [HexaObject] = []
    var RefreshContoller: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UploadBtn.CircleCurvesAction()
        collectionView.register(UINib(nibName: "GradientCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        GetData()
        RefreshContoller = UIRefreshControl()
        RefreshContoller.addTarget(self, action: #selector(GUploadedVC.refreshAction), for: .valueChanged)
        RefreshContoller.tintColor = UIColor.red
        collectionView.addSubview(RefreshContoller)
        NotificationCenter.default.addObserver(self, selector: #selector(GUploadedVC.refreshAction), name: NSNotification.Name(rawValue: "GradientAdded"), object: nil)
    }
    
    @IBAction func uploadAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Upload Your Gradient", message: "hey!", preferredStyle: UIAlertController.Style.alert)
        
        //Step : 2
        alert.addAction (UIAlertAction(title: "Upload", style: .default) { (alertAction) in
            let textField = alert.textFields![0]
            let textField2 = alert.textFields![1]
                guard let firstHex = textField.text, let secondHex = textField2.text else{return}
                HexaObject(ID: UUID().uuidString, FirstColor: firstHex, SecondColor: secondHex).Upload()
        })
        alert.addTextField { (textField) in
            textField.placeholder = "Enter first HexColor"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter second HexColor"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default) { (alertAction) in })
        self.present(alert, animated:true, completion: nil)
        
    }
    
    func GetData(){
        ColorsAPI.GetAllData { (colors: [HexaObject]) in
            self.colors = colors
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc func refreshAction(){
        colors = []
        collectionView.reloadData()
        GetData()
    }
}

extension GUploadedVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MyCellDelegateUploaded{
    func lblNameTapped(cell: GradientCollectionViewCell) {
        let indexPath = self.collectionView.indexPath(for: cell)
        print(indexPath!.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GradientCollectionViewCell
        cell.update(Colors: colors[indexPath.row])
        cell.SetTextHexa(text: colors[indexPath.row])
        cell.SetHex = {
            cell.delegate = self
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Gradient", sender: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.width / 4)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let next = segue.destination as? GUploadedSelectedVC {
            if let indexRow = sender as? Int {
                next.hexaArray = colors[indexRow]
            }
        }
    }
}

