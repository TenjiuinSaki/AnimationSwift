    //
//  TabViewController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/7/4.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import ColorMatchTabs

struct TabItem {
    let title: String
    let tintColor: UIColor
    let normalImage: UIImage
    let highlightedImage: UIImage
}

class TabViewController: ColorMatchTabsViewController {

    let items = [TabItem(
                    title: "Products",
                    tintColor: #colorLiteral(red: 0.474958837, green: 0.7357056737, blue: 0.1957958341, alpha: 1),
                    normalImage: #imageLiteral(resourceName: "products_normal"),
                    highlightedImage: #imageLiteral(resourceName: "products_highlighted")),
                 TabItem(
                    title: "Places",
                    tintColor: #colorLiteral(red: 0.2410970032, green: 0.7051628232, blue: 0.9713981748, alpha: 1),
                    normalImage: #imageLiteral(resourceName: "venues_normal"),
                    highlightedImage: #imageLiteral(resourceName: "venues_highlighted")),
                 TabItem(
                    title: "Reviews",
                    tintColor: #colorLiteral(red: 0.9724387527, green: 0.5987311006, blue: 0.001135308179, alpha: 1),
                    normalImage: #imageLiteral(resourceName: "reviews_normal"),
                    highlightedImage: #imageLiteral(resourceName: "reviews_highlighted")),
                 TabItem(
                    title: "Friends",
                    tintColor: #colorLiteral(red: 0.9212161899, green: 0.5189073086, blue: 0.5310305953, alpha: 1),
                    normalImage: #imageLiteral(resourceName: "users_normal"),
                    highlightedImage: #imageLiteral(resourceName: "users_highlighted"))]
    
    let controllers = [ChildViewController(),
                           ChildViewController(),
                           ChildViewController(),
                           ChildViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        title = "HAUNT"
//        popoverViewController = PopoverViewController()
//        popoverViewController?.delegate = self
        
        titleLabel.font = Font.size(20, name: "GothamPro-Black")
        dataSource = self
        reloadData()
        
        setNavigationItems()
        
        
    }
    
    func setNavigationItems() {
        let closeImage = UIImage.icon(from: .Ionicon, iconColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), code: "ios-close-empty", imageSize: CGSize(width: 36, height: 36), ofSize: 36)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(hero_dismissViewController))
        
    }

}

extension TabViewController: ColorMatchTabsViewControllerDataSource {
    func numberOfItems(inController controller: ColorMatchTabsViewController) -> Int {
        return items.count
    }
    func tabsViewController(_ controller: ColorMatchTabsViewController, viewControllerAt index: Int) -> UIViewController {
        return controllers[index]
    }
    func tabsViewController(_ controller: ColorMatchTabsViewController, titleAt index: Int) -> String {
        return items[index].title
    }
    func tabsViewController(_ controller: ColorMatchTabsViewController, iconAt index: Int) -> UIImage {
        return items[index].normalImage
    }
    func tabsViewController(_ controller: ColorMatchTabsViewController, hightlightedIconAt index: Int) -> UIImage {
        return items[index].highlightedImage
    }
    func tabsViewController(_ controller: ColorMatchTabsViewController, tintColorAt index: Int) -> UIColor {
        return items[index].tintColor
    }
    
}
extension TabViewController: PopoverViewControllerDelegate {
    
    func popoverViewController(_ popoverViewController: PopoverViewController, didSelectItemAt index: Int) {
        selectItem(at: index)
    }
    
}
