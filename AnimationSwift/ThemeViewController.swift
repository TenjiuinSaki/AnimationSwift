//
//  ThemeViewController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/6/24.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import Themes
import Spots
import Fakery
// 目前还不能记录主题，每次打开都为日间模式
class ThemeViewController: SpotsController {

    let dayImage = UIImage.icon(from: .Ionicon, code: "ios-sunny-outline", imageSize: CGSize(width: 36, height: 36), ofSize: 36)
    let nightImage = UIImage.icon(from: .Ionicon, code: "ios-sunny", imageSize: CGSize(width: 36, height: 36), ofSize: 36)
    
    var items = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ThemeManager.currentTheme = dayTheme        // 设置默认主题
        
        use(MyTheme.self) { (weakSelf, theme) in        //使用主题
            weakSelf.scrollView.backgroundColor = theme.backgroundColor
            weakSelf.navigationController?.navigationBar.setBackgroundImage(theme.topImage, for: .default)
            weakSelf.navigationController?.navigationBar.tintColor = theme.foreColor
            weakSelf.navigationController?.navigationBar.barStyle = theme.barStyle
            weakSelf.refreshData()
        }
        
        
        setNavigationItems()
        
        items = generateItems(counts: 20)
        
        refreshData()
    }
    
    /// 刷新数据
    func refreshData() {
        update { (component) in
            component.model.items = items
        }
    }
    
    convenience init(title: String) {
        Configuration.register(nib: Nib(nibName: "ThemeCell", bundle: nil), identifier: "theme_cell")                    //注册UITableViewCell
        let model = ComponentModel(kind: .list)     //设置为UITableView模式渲染
        let component = Component(model: model)
        
        if let tableView = component.tableView {    //设置UITableView样式
            tableView.backgroundColor = UIColor.clear
            tableView.separatorStyle = .none
        }
        
        self.init(component: component)
        self.title = title
    }
    
    func setNavigationItems() {
        let closeImage = UIImage.icon(from: .Ionicon, code: "ios-close-empty", imageSize: CGSize(width: 36, height: 36), ofSize: 36)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(hero_dismissViewController))
        
        let themeItem = UIBarButtonItem(image: nightImage, style: .plain, target: self, action: #selector(changeTheme(sender:)))
        themeItem.tag = 1003        // 添加tag帮助记录主题状态
        navigationItem.rightBarButtonItem = themeItem
        
    }
    
    /// 日夜间模式切换
    ///
    /// - Parameter sender: 事件触发者
    func changeTheme(sender: UIBarButtonItem) {
        if sender.tag == 1003 {         // 切换为夜间模式
            sender.tag = 1004
            sender.image = dayImage
            ThemeManager.currentTheme = nightTheme
        } else if sender.tag == 1004 {  // 切换为日间模式
            sender.tag = 1003
            sender.image = nightImage
            ThemeManager.currentTheme = dayTheme
        }
    }
    
    func generateItems(counts: Int) -> [Item] {
        var items = [Item]()
        let faker = Faker(locale: "zh-CN")
        
        for _ in 1...counts {
            items.append(Item(title: faker.name.name(),
                              subtitle: faker.phoneNumber.phoneNumber(),
                              kind: "theme_cell"))
        }
        return items
    }
}
