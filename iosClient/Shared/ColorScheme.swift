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

    // mainColor 主要用于导航栏和部分系统字体颜色
    static let mainColor = UIColor(red: 1, green: 0.455, blue: 0, alpha: 1)

    // darkerColor 主要用于搜索框背景
    static let darkerColor = UIColor(red: 0.773, green: 0.349, blue: 0, alpha: 1)

    // darkestColor 主要用作导航栏上的图标颜色
    static let darkestColor = UIColor(red: 0.608, green: 0.275, blue: 0, alpha: 1)

    // brighterColor 主要用作darkestColor highlight的颜色
    static let brighterColor = UIColor(red: 1, green: 0.576, blue: 0.224, alpha: 1)

    // brightestColor 主要用作mainColor的highlight
    static let brightestColor = UIColor(red: 1, green: 0.667, blue: 0.388, alpha: 1)

    // backgroundColor 白色 作为背景色
    static let backgroundColor = UIColor.whiteColor()

    // greyColorWithScale(0-1) 灰色 作为底部tabbar以及内容卡片的前景色 不同scale显示highlight或者press
    // not implemented

    // lineColor 黑色 分割线颜色 一般宽度为1px
    static let lineColor = UIColor.blackColor()

}
