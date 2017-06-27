//
//  AlphaTableViewController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/6/26.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import ETNavBarTransparent
import CRRefresh

class AlphaTableViewController: UITableViewController {

    var statusBarLight = true
    var isFirstAppear = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navBarBgAlpha = 0
        navBarTintColor = .white
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.cr.addHeadRefresh(animator: SlackLoadingAnimator()) { [unowned self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.tableView.cr.endHeaderRefresh()
                self.tableView.cr.resetNoMore()
            })
        }
        tableView.cr.addFootRefresh(animator: NormalFooterAnimator()) { [unowned self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.tableView.cr.endLoadingMore()
                self.tableView.cr.noticeNoMoreData()
            })
        }
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "day"))
        imageView.frame = CGRect(x: 0, y: 0, width: Screen.width, height: 200)
        tableView.tableHeaderView = imageView
        
        // 取消自动向下偏移
        automaticallyAdjustsScrollViewInsets = false
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarLight ? .lightContent : .default
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        let showNavBarOffset = 200 - topLayoutGuide.length  // 200 - 64 = 136
        
        // 当200 > offsetY > 136, 范围64
        if offsetY > showNavBarOffset {
            var navAlpha = (offsetY - showNavBarOffset) / 40    //40的偏移量由透明转为不透明
            navAlpha = min(1, navAlpha)
            navBarBgAlpha = navAlpha
            if navAlpha > 0.8 {
                navBarTintColor = .defaultNavBarTintColor
                statusBarLight = false
            } else {
                navBarTintColor = .white
                statusBarLight = true
            }
        } else {        //offset < 136
            navBarBgAlpha = 0
            navBarTintColor = .white
            statusBarLight = true
        }
        
        setNeedsStatusBarAppearanceUpdate()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
