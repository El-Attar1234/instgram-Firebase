//
//  HomeCollectionViewCell.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/12/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    var post : Post?{
        didSet{
            
            guard let imageUrl = post?.imageUrl else {return}
             postImage.downloadImageUsingSession(url: imageUrl)
            userProfileImage.makeRounded()
            guard let profileImage = post?.user.profileImage else {return}
            userProfileImage.downloadImage(url:profileImage)
            userNameLabel.text = post?.user.userName
            captionTextView.text = post?.caption
        }
    }
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    
}
