//
//  PageViewController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/7/4.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import Pageboy
import CHIPageControl
import DGRunkeeperSwitch

class PageViewController: PageboyViewController {

    let pageControl = CHIPageControlJaloro()
    let switcher = DGRunkeeperSwitch()
    let pageNums = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        delegate = self
        dataSource = self
        
        pageControl.numberOfPages = pageNums
        pageControl.progress = 0
        pageControl.padding = 5
        pageControl.elementWidth = 20
        pageControl.elementHeight = 2
        pageControl.radius = 1
        pageControl.hidesForSinglePage = true
        pageControl.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(50)
        }
        
        setSwitcher()
        
    }
    
    func setSwitcher() {
        switcher.titles = ["Daily", "Weekly", "Monthly", "Yearly"]
        switcher.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        switcher.selectedBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        switcher.titleColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        switcher.selectedTitleColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        switcher.titleFont = Font.size(15, name: "HelveticaNeue-Medium")
        view.addSubview(switcher)
        switcher.snp.makeConstraints { (make) in
            make.top.equalTo(70)
            make.left.right.equalTo(view).inset(5)
            make.height.equalTo(38)
        }
        switcher.addTarget(self, action: #selector(switchValueDidChange(sender:)), for: .valueChanged)
    }
    func switchValueDidChange(sender: DGRunkeeperSwitch) {
        scrollToPage(.at(index: sender.selectedIndex), animated: true)
    }
    
}

extension PageViewController: PageboyViewControllerDelegate, PageboyViewControllerDataSource {
    
    /// 子控制器
    ///
    /// - Parameter pageboyViewController:
    /// - Returns: 控制器数组
    func viewControllers(forPageboyViewController pageboyViewController: PageboyViewController) -> [UIViewController]? {
        var viewControllers = [UIViewController]()
        for i in 0..<pageNums {
            let viewController = ChildViewController()
            viewController.index = i + 1
            viewControllers.append(viewController)
        }
        return viewControllers
    }
    
    func defaultPageIndex(forPageboyViewController pageboyViewController: PageboyViewController) -> PageboyViewController.PageIndex? {
        return nil
    }
    
    
    /// 滑动到某一页
    ///
    /// - Parameters:
    ///   - pageboyViewController:
    ///   - index:
    ///   - direction:
    ///   - animated:
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAtIndex index: Int, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        switcher.setSelectedIndex(index, animated: true)
    }
    
    /// 滑动到某位置
    ///
    /// - Parameters:
    ///   - pageboyViewController:
    ///   - position:
    ///   - direction:
    ///   - animated:
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPosition position: CGPoint, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        pageControl.progress = Double(position.x)
    }
}
