//
//  KeywordSearchTableViewCell.swift
//  iosClient
//
//  Created by Spencer Michaels on 1/7/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import AVOSCloud
import UIKit

/**
 A UITableViewCell that displays information about a given user.
 */
class KeywordSearchTableViewUserCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var avatarImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Crop avatars as as circles
        UserInterfaceServices.cropToCircle(self.avatarImageView)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /**
     Sets the cell to display information for the given user
     
     - parameter user The user from which to retrieve information
     */
    func setDisplayUser(user: AVUser) {
        // Show the user's name, or their username if no name is set
        if let name = user.objectForKey("name") as? String {
            nameLabel.text = name
        } else {
            nameLabel.text = user.username
        }
        
        // Show the user's summary if available.
        if let summary = user.objectForKey("summary") as? String {
            detailLabel.text = summary
        } else {
            detailLabel.text = "无细节。"
        }
        
        // Display an avatar if 
        if let avatarFile = user.objectForKey("avatar") as? AVFile {
            setAvatarForFile(avatarFile)
        } else {
            self.avatarImageView.image = UIImage(named: "defaultAvatar")
        }
    }
    
    func setAvatarForFile(file: AVFile) {
        let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        loadingIndicator.center = avatarImageView.center
        loadingIndicator.startAnimating()
        contentView.addSubview(loadingIndicator)
        
        file.getDataInBackgroundWithBlock { (data: NSData!, error: NSError!) -> Void in
            if error == nil && data != nil {
                self.avatarImageView.image = UIImage(data: data)
                loadingIndicator.removeFromSuperview()
            } else {
                // TODO: Default avatar?
            }
        }
    }
}
