//
//  Config.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/6/23.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import Themes
import Cache

struct Screen {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let bounds = UIScreen.main.bounds
    
    /// 横屏缩放比例，标准比例6s
    static let wScale = UIScreen.main.bounds.size.width / 375
    /// 竖屏缩放比例，标准比例6s
    static let hScale = UIScreen.main.bounds.size.height / 667
}

extension Int {
    var wScale: CGFloat {
        let f = CGFloat(self) * Screen.wScale
        let size = CGFloat.maximum(1, floor(f))
        return size
    }
    var hScale: CGFloat {
        let f = CGFloat(self) * Screen.hScale
        let size = CGFloat.maximum(1, floor(f))
        return size
    }
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
    static func size(_ size: Int, name: String? = nil, isBold: Bool = false) -> UIFont {
        if let name = name {
            return UIFont(name: name, size: size.wScale)!
        } else if isBold {
            return UIFont.boldSystemFont(ofSize: size.wScale)
        } else {
            return UIFont.systemFont(ofSize: size.wScale)
        }
        
    }
    static let navigationBar = UIFont(name: "Avenir-Heavy", size: 20)!
    static let cell = size(18, name: "Avenir-Medium")
    static let header = size(38, name: "BradleyHandITCTT-Bold")
}

struct MyTheme: Theme {
    let topImage: UIImage
    let foreColor: UIColor
    let backgroundColor: UIColor
    let titleFont: UIFont
    let barStyle: UIBarStyle
    let statusBarStyle: UIStatusBarStyle
    let cellColor: UIColor
    let cellHeight: CGFloat
    
}

let dayTheme = MyTheme(topImage: #imageLiteral(resourceName: "unicorn"),
                       foreColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                       backgroundColor: #colorLiteral(red: 0.9507043494, green: 0.9727312591, blue: 0.9612837765, alpha: 1),
                       titleFont: UIFont(name: "Unicorns are Awesome", size: 14)!,
                       barStyle: .default,
                       statusBarStyle: .default,
                       cellColor: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),
                       cellHeight: 100)

let nightTheme = MyTheme(topImage: #imageLiteral(resourceName: "night"),
                         foreColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                         backgroundColor: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1),
                         titleFont: UIFont(name: "Star Jedi", size: 12)!,
                         barStyle: .black,
                         statusBarStyle: .lightContent,
                         cellColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),
                         cellHeight: 150)


struct Storyboard {
    private static let main = UIStoryboard(name: "Main", bundle: nil)
    
    static func setRootViewController(_ viewController: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    static func instance(_ identifier: String) -> UIViewController {
        return main.instantiateViewController(withIdentifier: identifier)
    }
    
    /// 起始控制器
    static func initial() -> UIViewController {
        return main.instantiateInitialViewController()!
    }
}

struct Xib {
    static func viewsOfXib(name: String) -> [UIView] {
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil) as! [UIView]
    }
    
    static func viewOfXib<T: UIView>(viewClass: T.Type) -> T {
        let className = NSStringFromClass(T.self)
        let nibName = className.components(separatedBy: ".").last!
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as! T
    }
}

extension String {
    /// Unicode转化为汉字
    var decodeUnicode: String {
        let tempStr1 = self.replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        let tempData = tempStr3.data(using: .utf8)!
        let returnStr = try! PropertyListSerialization.propertyList(from: tempData, options: [.mutableContainers, .mutableContainersAndLeaves], format: nil) as! String
        return returnStr.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
}

func info<T>(message: T, fullName: String = #file, lineNum: Int = #line) {
    let path = fullName.components(separatedBy: "/").last!
    let fileName = path.components(separatedBy: ".").first!
    print("😡‼️\(fileName)-[第\(lineNum)行]:💋💋💋\(message)")
}


/// 系统缓存
let systemCache = HybridCache(name: "SystemCache", config: Config(
    expiry: .date(Date().addingTimeInterval(60)),   //过期时间1分钟
    memoryCountLimit: 0,
    memoryTotalCostLimit: 0,
    maxDiskSize: 10000,                             //缓存大小10M
    cacheDirectory: NSSearchPathForDirectoriesInDomains(
        .documentDirectory,
        FileManager.SearchPathDomainMask.userDomainMask,
        true).first! + "/cache-in-documents"))

struct DirPath {
    /// (home)/Documents
    static var document: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }
    /// (home)/Library/Caches
    static var caches: String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
    }
    /// 沙盒路径
    static var home: String {
        return NSHomeDirectory()
    }
    /// (home)/tmp
    static var temporary: String {
        return NSTemporaryDirectory()
    }
}
