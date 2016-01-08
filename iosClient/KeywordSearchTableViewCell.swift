//
//  KeywordSearchTableViewCell.swift
//  iosClient
//
//  Created by Spencer Michaels on 1/7/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import AVOSCloud
import UIKit

class KeywordSearchTableViewUserCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var avatarImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setDisplayUser(user: AVUser) {
        if let name = user.objectForKey("name") as? String {
            nameLabel.text = name
        } else {
            nameLabel.text = user.username
        }
        
        if let summary = user.objectForKey("summary") as? String {
            detailLabel.text = summary
        } else {
            detailLabel.text = "无细节。"
        }
        
        if let avatarFile = user.objectForKey("avatar") as? AVFile {
            setAvatarForFile(avatarFile)
        }
    }
    
    func setAvatarForFile(file: AVFile) {
        let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        loadingIndicator.center = avatarImageView.center
        loadingIndicator.startAnimating()
        contentView.addSubview(loadingIndicator)
        
        file.getDataInBackgroundWithBlock { (data: NSData!, error: NSError!) -> Void in
            if error == nil && data != nil {
                UserInterfaceServices.cropToCircle(self.avatarImageView)
                self.avatarImageView.image = UIImage(data: data)
                loadingIndicator.removeFromSuperview()
            } else {
                // TODO: Default avatar?
            }
        }
    }
}
