//
//  ButtonViewController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/7/3.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import DOFavoriteButton
import SwiftIconFont

class ButtonViewController: UIViewController {

    var iconName = "" {
        didSet {
            title = iconName
            let comps = iconName.components(separatedBy: ":")
            let type = comps.first!
            iconName = comps.last!
            switch type {
            case "fa":
                iconType = .FontAwesome
            case "ic":
                iconType = .Iconic
            case "io":
                iconType = .Ionicon
            case "mi":
                iconType = .MapIcon
            case "ma":
                iconType = .MaterialIcon
            case "oc":
                iconType = .Octicon
            case "ti":
                iconType = .Themify
            default:
                ()
            }
        }
    }
    var iconType: Fonts = .FontAwesome
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let imageSize: CGFloat = 100
        let buttonFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        // 创建图片
        let image = UIImage.icon(from: iconType, code: iconName, imageSize: CGSize(width: imageSize, height: imageSize), ofSize: imageSize)
        // 创建动画按钮
        let button = DOFavoriteButton(frame: buttonFrame, image: image)
        button.addTarget(self, action: #selector(tapped(sender:)), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.width.height.equalTo(100)
        }
        
    }
    func tapped(sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
        } else {
            sender.select()
        }
    }
}
