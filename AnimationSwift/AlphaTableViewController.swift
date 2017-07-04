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
import FSPagerView
import Spruce

class AlphaTableViewController: UITableViewController {

    var statusBarLight = true
    
    
    /// 轮播图数据源
    let images = [#imageLiteral(resourceName: "day"), #imageLiteral(resourceName: "night"), #imageLiteral(resourceName: "starwar"), #imageLiteral(resourceName: "unicorn")]
    let titles = ["day", "night", "starwar", "unicorn"]
    
    /// 轮播图控件
    let pager = FSPagerView()
    /// 页码指示器
    let pageControl = FSPageControl()
    
    lazy var titleLabel: UILabel = { [unowned self] in
        let titleLabel = UILabel()
        titleLabel.font = Font.size(17, isBold: true)
        self.navigationItem.titleView = titleLabel
        return titleLabel
    }()
    
    /// 配置加载动画
    let animations: [StockAnimation] = [.slide(.left, .severely), .fadeIn]
    let sortFunction = LinearSortFunction(direction: .topToBottom, interObjectDelay: 0.05)
    
    func spruceAnimation() {
        
        let animation = SpringAnimation(duration: 0.7)
        DispatchQueue.main.async {
            self.tableView.spruce.animate(self.animations, animationType: animation, sortFunction: self.sortFunction)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navBarBgAlpha = 0           // 导航栏透明度
        navBarTintColor = .white    // 导航按钮颜色
        
        titleLabel.text = "MeiMei"
        titleLabel.sizeToFit()
        
        // 取消自动向下偏移
        automaticallyAdjustsScrollViewInsets = false
        // 注册Cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // 刷新
        setRefresher()
        // 表头
        addTableHeader()
    }
    
    /// 添加轮播图
    func addTableHeader() {
        
        pager.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pager.delegate = self
        pager.dataSource = self
        
        // 比例缩放
        //        let scale: CGFloat = 0.7
        //        pager.itemSize = CGSize(width: Screen.width * scale, height: Screen.width * scale * 9 / 16)
        
        pager.itemSize = .zero                  // 充满容器
        
        pager.interitemSpacing = 10             // 图片间隔
        pager.automaticSlidingInterval = 3      // 滚动时间间隔
        pager.isInfinite = true                 // 循环滚动
        //切换类型
        /**
         crossFading
         zoomOut
         depth
         overlap
         linear
         coverFlow
         ferrisWheel
         invertedFerrisWheel
         cubic
         */
        pager.transformer = FSPagerViewTransformer(type: .crossFading)
        
        // 添加视图
        tableView.tableHeaderView = pager
        pager.frame = CGRect(x: 0, y: 0, width: Screen.width, height: Screen.width * 9 / 16)
//        pager.snp.makeConstraints { (make) in
//            make.top.left.equalTo(0)
//            make.width.equalTo(view)
//            make.height.equalTo(pager.snp.width).multipliedBy(9.0 / 16)
//        }
        
        addPageControl()
    }
    
    /// 添加页码指示
    func addPageControl() {
        pageControl.numberOfPages = images.count
        pageControl.contentHorizontalAlignment = .right
        pageControl.contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 3, right: 20)
        pageControl.setStrokeColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        pageControl.setStrokeColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
        pageControl.setFillColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
        pageControl.itemSpacing = 8         // 圆点大小
        pageControl.interitemSpacing = 8    // 间隔大小
        
        // 添加页数控制
        pager.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(pager)
            make.height.equalTo(20)
        }
    }
    
    /// 设置刷新器
    func setRefresher() {
        tableView.cr.addHeadRefresh(animator: SlackLoadingAnimator()) { [unowned self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.tableView.cr.endHeaderRefresh()
                self.tableView.cr.resetNoMore()
                self.spruceAnimation()
            })
        }
        tableView.cr.addFootRefresh(animator: NormalFooterAnimator()) { [unowned self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.tableView.cr.endLoadingMore()
                self.tableView.cr.noticeNoMoreData()
            })
        }
    }
    
    
    /// 调整状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        titleLabel.textColor = statusBarLight ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return statusBarLight ? .lightContent : .default
    }
    
    /// 监听滑动
    ///
    /// - Parameter scrollView: tableView
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        let showNavBarOffset = 200 - topLayoutGuide.length  // 200 - 64 = 136
        
        // 当200 > offsetY > 136, 范围64
        if offsetY > showNavBarOffset {
            var navAlpha = (offsetY - showNavBarOffset) / 40    //40的偏移量由透明转为不透明
            navAlpha = min(1, navAlpha)
            navBarBgAlpha = navAlpha
            if navAlpha > 0.8 {             //  正常
                navBarTintColor = .defaultNavBarTintColor
                statusBarLight = false
            } else {                        // 透明
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

    // MARK: - TableView代理
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - 轮播图代理
extension AlphaTableViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return images.count
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = images[index]
        cell.textLabel?.text = titles[index]
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        pageControl.currentPage = index
    }
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        if pageControl.currentPage != pagerView.currentIndex {
            pageControl.currentPage = pagerView.currentIndex
        }
    }
}
