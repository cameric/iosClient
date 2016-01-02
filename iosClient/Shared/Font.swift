//
//  Font.swift
//  iosClient
//
//  Created by Cam on 12/23/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import Foundation
import UIKit

struct Font {
    static func fontWithSize(size: CGFloat) -> UIFont {
        return UIFont.systemFontOfSize(size)
    }
    
    static func head1() -> UIFont {
        return fontWithSize(20.0)
    }
    
    static func head2() -> UIFont {
        return fontWithSize(18.0)
    }
    
    static func head3() -> UIFont {
        return fontWithSize(16.0)
    }
    
    static func paragraph() -> UIFont {
        return fontWithSize(14.0)
    }
}