//
//  Config.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/6/23.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit

struct Screen {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let bounds = UIScreen.main.bounds
}

struct Color {
    
    static let navigationBarForeground = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).alpha(0.9)
    static let cellForeground = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).alpha(0.8)
    static let cellSeparator = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).alpha(0.4)
    
    static let color1 = #colorLiteral(red: 0.9921568627, green: 0.262745098, blue: 0.2509803922, alpha: 1)
    static let color2 = #colorLiteral(red: 0.8078431373, green: 0.168627451, blue: 0.6823529412, alpha: 1)
    static let color3 = #colorLiteral(red: 0.5529411765, green: 0.1411764706, blue: 1, alpha: 1)
    static let color4 = #colorLiteral(red: 0.137254902, green: 0.6588235294, blue: 0.9764705882, alpha: 1)
}

struct Font {
    
    static let navigationBar = UIFont(name: "Avenir-Heavy", size: 20)!
    static let cell = UIFont(name: "Avenir-Medium", size: 18)!
    
}