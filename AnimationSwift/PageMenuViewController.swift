//
//  PageMenuViewController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/7/7.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import PageMenu

class PageMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "Page Menu"
        
        addCloseButton()
        
        setPageMenu()
    }
    
    func setPageMenu() {
        let texts = ["Swift",
                     "ObjectiveC",
                     "MacBook Pro",
                     "iPhone",
                     "iPad",
                     "Watch",
                     "iTunes"]
        
        var controllers = [UIViewController]()
        for text in texts {
            controllers.append(ChildViewController(title: text))
        }
        
        let options: [CAPSPageMenuOption] = [
            CAPSPageMenuOption.scrollMenuBackgroundColor(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)),
            CAPSPageMenuOption.selectionIndicatorColor(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)),
            //            CAPSPageMenuOption.viewBackgroundColor(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)),
            CAPSPageMenuOption.addBottomMenuHairline(true),
            CAPSPageMenuOption.menuItemFont(Font.size(14)),
            CAPSPageMenuOption.menuHeight(40),
            CAPSPageMenuOption.selectionIndicatorHeight(2),
            CAPSPageMenuOption.menuItemWidthBasedOnTitleTextWidth(true),
            CAPSPageMenuOption.selectedMenuItemLabelColor(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)),
            CAPSPageMenuOption.bottomMenuHairlineColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        ]
        
        let pageMenu = CAPSPageMenu(viewControllers: controllers, frame: Screen.bounds, pageMenuOptions: options)
        
        view.addSubview(pageMenu.view)
        addChildViewController(pageMenu)
    }
    
    func addCloseButton() {
        let image = UIImage.icon(from: .Ionicon, code: "ios-close-empty", imageSize: CGSize(width: 36, height: 36), ofSize: 36)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(hero_dismissViewController))
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
