//
//  PhotoCollectionViewCell.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/3/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    
    var post : Post?{
        
        didSet{
            guard let imageUrl = post?.imageUrl else {return}
            postImage.downloadImageUsingSession(url: imageUrl)
        }
           
        }
    }

