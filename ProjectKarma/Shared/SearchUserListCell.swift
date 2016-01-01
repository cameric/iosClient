//
//  SearchUserListCell.swift
//  ProjectKarma
//
//  Created by Cam on 12/24/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import UIKit

class SearchUserListCell: UITableViewCell {
    
    var avatar_ = UIImageView()
    var userName_ = UILabel()
    
    func loadItem(title: String, image: String) {
        avatar_.image = UIImage(named: image)
        avatar_.frame = CGRect(origin: CGPointMake(15, 15), size: (avatar_.image?.size)!)
        userName_.text = title
        userName_.frame = CGRect(origin: CGPointMake(30 + (avatar_.image?.size)!.width, 15), size: CGSizeMake(300, 50))
        addSubview(avatar_)
        addSubview(userName_)
        sizeToFit()
    }
}
