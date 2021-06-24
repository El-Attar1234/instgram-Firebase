//
//  UserTableViewCell.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 22/06/2021.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!{
        didSet{
            userImage.makeRounded()
        }
    }
    
    @IBOutlet weak var userPosts: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    static let identifier = "UserTableViewCell"
    var user : User?{
        didSet{
            guard let user = self.user else{return}
            userName.text = user.userName
            userImage.downloadImage(url: user.profileImage)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("add margins")
        self.layoutMargins = UIEdgeInsets(top: 50, left: 5, bottom: 5, right: 5)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
