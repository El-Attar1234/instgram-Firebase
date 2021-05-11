//
//  SharedPhotoVC.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/9/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit
import Firebase

class SharedPhotoVC: UIViewController {
    @IBOutlet weak var selectedPhoto: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    
    var passedImage : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.colorWithRGB(red: 240, green: 240, blue: 240)
        setUpNavigationBarItems()
        self.selectedPhoto.image = passedImage
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    fileprivate func setUpNavigationBarItems(){
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(handlePostAction))
        
    }
    @objc func handlePostAction(){
        guard let originalImage = self.passedImage else {return}
        guard let postImage = self.passedImage else {return}
        guard let captionText = self.captionTextView.text, captionText.count > 0 else {return}
        guard  let imageData = postImage.jpegData(compressionQuality: 0.75) else {return}
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
          let uniqueFileName = NSUUID().uuidString
        
        let storageItem =  Storage.storage().reference().child("posts-images").child(uniqueFileName)
        storageItem.putData(imageData, metadata: nil , completion: { [weak self](data
            , error) in
            guard let self = self else {return}
            if let error = error{
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("\(error)")
                return
            }
            
            
            storageItem.downloadURL(completion: { (url, error) in
                if let error = error  {
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    print(error)
                    return
                }
                guard let url = url else {return}
                //     imageUrl = url.absoluteString
                guard let uid = Auth.auth().currentUser?.uid else {return}
                let values = ["caption":captionText,"image_Url":url.absoluteString , "imageWidth" : originalImage.size.width , "imageHeight" : originalImage.size.height , "creationDate" : Date().timeIntervalSince1970] as [String : Any]
                let userPostRef =  Database.database().reference().child("posts").child(uid)
                userPostRef.childByAutoId().updateChildValues(values, withCompletionBlock:  { [weak self](error, reference) in
                    guard let self = self else {return}
                    if let error = error  {
                        self.navigationItem.rightBarButtonItem?.isEnabled = true
                        print("error" , error)
                        return}
                    print(reference)
                    self.dismiss(animated: true, completion: nil)
                })
            })
        }
            
            
            
        )
    }
    
}


