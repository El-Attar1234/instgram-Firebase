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
            setAttributedString()
        }
    }
    
    fileprivate func setAttributedString(){
        guard let post = self.post else { return }
        let attributedTitle = NSMutableAttributedString(string: "\(post.user.userName)", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)])
        let captionString = NSAttributedString(string: "\(post.caption)", attributes:  [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17) ])
        attributedTitle.append(captionString)
        attributedTitle.append( NSAttributedString(string: "\n\n", attributes:  [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 4) ]))
        attributedTitle.append( NSAttributedString(string: "1 week ago", attributes:  [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),NSAttributedString.Key.foregroundColor : UIColor.gray]))
        captionTextView.attributedText = attributedTitle
    }
    
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    
}
