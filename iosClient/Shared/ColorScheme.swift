//
//  ColorScheme.swift
//  iosClient
//
//  Created by Cam on 12/23/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import Foundation
import UIKit

struct ColorScheme {
    static func mainColor() -> UIColor {
        return UIColor(red: 1, green: 0.455, blue: 0, alpha: 1)
    }
    
    static func highlightColor() -> UIColor {
        return UIColor(red: 1, green: 0.576, blue: 0.224, alpha: 1)
    }
    
    static func selectedColor() -> UIColor {
        return UIColor(red: 0.773, green: 0.349, blue: 0, alpha: 1)
    }
    
    static func tintColor() -> UIColor {
        return UIColor(red: 0.608, green: 0.275, blue: 0, alpha: 1)
    }
    
    static func backgroundColor() -> UIColor {
        return UIColor(red: 1, green: 0.667, blue: 0.388, alpha: 1)
    }
    
    static func foregroundColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    static func fontColor() -> UIColor {
        return UIColor.blackColor()
    }
    
    static func fontTintColor() -> UIColor {
        return tintColor()
    }
    
    static func fontSelectedColor() -> UIColor {
        return selectedColor()
    }
    
}