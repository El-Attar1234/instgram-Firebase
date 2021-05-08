//
//  PhotoSelectorVC.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/8/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectorVC: UIViewController {
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    var myAssetImages = [UIImage]()
    var myAssets      = [PHAsset]()
    var selectedindex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setUpNavigationBarItems()
        fetchPhotos()
    }
    fileprivate func fetchPhotos(){
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 10
        let sortDisriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDisriptor]
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        DispatchQueue.global(qos: .background).async {
            allPhotos.enumerateObjects { (asset, count, stop) in
                      print("\(count)")
                      let imageManager = PHImageManager.default()
                      let options = PHImageRequestOptions()
                      options.isSynchronous = true
                      imageManager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: options) {[weak self] (image, info) in
                        guard let self = self else {return}
                          if let image = image{
                            self.myAssets.append(asset)
                              self.myAssetImages.append(image)
                            if self.selectedindex == nil{
                                self.selectedindex = count
                            }
                          }
                          if count == allPhotos.count - 1{
                            DispatchQueue.main.async {
                                 self.imagesCollectionView.reloadData()
                            }
                            
                          }
                      }
                  }
        }
      
        
       }
    fileprivate func setUpNavigationBarItems(){
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNextAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelAction))
    }
    @objc func handleNextAction(){
        
    }
    
    @objc func handleCancelAction(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension PhotoSelectorVC{
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
extension PhotoSelectorVC :UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myAssetImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoSelectorCollectionViewCell", for: indexPath) as! PhotoSelectorCollectionViewCell
        cell.assetImage.image = myAssetImages[indexPath.item]
        
             return cell
         }
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:"PhotoSelectorHeader", for: indexPath) as! PhotoSelectorHeader
            guard let selectedindex = self.selectedindex else {return header}
            header.selectedHeaderImage.image = myAssetImages[selectedindex]
             header.selectedHeaderImage.clipsToBounds = true
            
            let imageManager = PHImageManager.default()
                               let options = PHImageRequestOptions()
                               options.isSynchronous = true
                               imageManager.requestImage(for: myAssets[selectedindex], targetSize: CGSize(width: 1000, height: 1000), contentMode: .aspectFit, options: options) {(image, info) in
                                header.selectedHeaderImage.image = image
                                
                               }
            
            
            return header
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
        }
        
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = (view.frame.width - 2 - 3)/4
        return CGSize(width: availableWidth, height: availableWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedindex = indexPath.item
        self.imagesCollectionView.reloadData()
    }
  }

