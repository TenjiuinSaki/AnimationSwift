//
//  ButtonsViewController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/6/27.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import SwiftIconFont
import PYSearch
import YNDropDownMenu

class ButtonsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    lazy var faNames: [String] = {
        var names = [String]()
        for (key, _) in fontAwesomeIconArr {
            names.append("fa:" + key)
        }
        return names
    }()
    
    lazy var ioNames: [String] = {
        var names = [String]()
        for (key, _) in ioniconArr {
            names.append("io:" + key)
        }
        return names
    }()
    
    lazy var ocNames: [String] = {
        var names = [String]()
        for (key, _) in octiconArr {
            names.append("oc:" + key)
        }
        return names
    }()
    
    lazy var icNames: [String] = {
        var names = [String]()
        for (key, _) in iconicIconArr {
            names.append("ic:" + key)
        }
        return names
    }()
    
    lazy var maNames: [String] = {
        var names = [String]()
        for (key, _) in materialIconArr {
            names.append("ma:" + key)
        }
        return names
    }()
    
    lazy var tiNames: [String] = {
        var names = [String]()
        for (key, _) in temifyIconArr {
            names.append("ti:" + key)
        }
        return names
    }()
    
    lazy var miNames: [String] = {
        var names = [String]()
        for (key, _) in mapIconArr {
            names.append("mi:" + key)
        }
        return names
    }()
    
    lazy var allNames: [String] = { [unowned self] in
        var names = [String]()
        names.append(contentsOf: self.faNames)
        names.append(contentsOf: self.ioNames)
        names.append(contentsOf: self.ocNames)
        names.append(contentsOf: self.icNames)
        names.append(contentsOf: self.maNames)
        names.append(contentsOf: self.tiNames)
        names.append(contentsOf: self.miNames)
        return names
    }()
    
    var iconFontNames = [String]()
    var buttonType: Fonts = .FontAwesome {
        didSet {
            title = buttonType.rawValue
            switch buttonType {
            case .FontAwesome:
                iconFontNames = faNames
            case .Ionicon:
                iconFontNames = ioNames
            case .Octicon:
                iconFontNames = ocNames
            case .Iconic:
                iconFontNames = icNames
            case .MaterialIcon:
                iconFontNames = maNames
            case .Themify:
                iconFontNames = tiNames
            case .MapIcon:
                iconFontNames = miNames
            }
            // 刷新数据，返回顶端
            collectionView.reloadData()
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    // 通知方法，类型发生改变
    func notice(noti: Notification) {
        let type = noti.object as! Fonts
        if type != buttonType {
            buttonType = type
        }
    }
    
    
    deinit {
        // 移除通知监听
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "icons_type"), object: nil)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        // Do any additional setup after loading the view.
        
        buttonType = .FontAwesome
        // 设置返回按钮文字，默认为标题
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: nil, action: nil)
        
        collectionView.register(UINib(nibName: "ButtonViewCell", bundle: nil), forCellWithReuseIdentifier: "button_cell")
        
        // 监听通知
        NotificationCenter.default.addObserver(self, selector: #selector(notice(noti:)), name: NSNotification.Name(rawValue: "icons_type"), object: nil)
        
        setDropView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchAction))
    }
    
    /// 添加下拉菜单
    func setDropView() {
        collectionView.contentInset = UIEdgeInsetsMake(38, 0, 0, 0)
        
        let dropFrame = CGRect(x: 0, y: 64, width: Screen.width, height: 38)
        let views = Xib.viewsOfXib(name: "DropDownView")
        let dropView = YNDropDownMenu(frame: dropFrame, dropDownViews: views, dropDownViewTitles: ["分类", "other"])
        dropView.setLabelColorWhen(normal: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), selected: #colorLiteral(red: 1, green: 0.6431372549, blue: 0.03529411765, alpha: 1), disabled: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
        dropView.setLabelFontWhen(normal: .systemFont(ofSize: 13), selected: .boldSystemFont(ofSize: 13), disabled: .systemFont(ofSize: 13))
        dropView.backgroundBlurEnabled = true
        dropView.bottomLine.isHidden = false
        
        view.addSubview(dropView)
        
    }
    
    /// 进入搜索
    func searchAction() {
        
        let hotSearches = ["fa:star", "fa:file-text-o", "fa:reorder", "fa:wechat", "fa:weibo", "fa:picture-o", "fa:camera", "fa:heart", "fa:qq", "fa:lock", "fa:user", "fa:gear", "fa:home"]
        let searchViewController = PYSearchViewController(hotSearches: hotSearches, searchBarPlaceholder: "搜索你想要的任何东西") { (searchViewController, searchBar, searchText) in
            info(message: searchText)
            self.searchSelect(name: searchText!)
        }!
        searchViewController.searchHistoryStyle = .default
        searchViewController.hotSearchStyle = .colorfulTag
        searchViewController.delegate = self
        searchViewController.cancelButton = nil
        navigationController?.pushViewController(searchViewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconFontNames.count
    }
    
    /// 选择搜索条目
    ///
    /// - Parameter name: 搜索文字
    func searchSelect(name: String) {
        let buttonVC = ButtonViewController()
        buttonVC.iconName = name
        navigationController?.pushViewController(buttonVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "button_cell", for: indexPath) as! ButtonViewCell

        let iconName = iconFontNames[indexPath.row]
        cell.nameLabel.text = iconName
        cell.iconLabel.text = iconName
        cell.iconLabel.parseIcon()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchSelect(name: iconFontNames[indexPath.row])
    }
}

extension ButtonsViewController: PYSearchViewControllerDelegate {
    func searchViewController(_ searchViewController: PYSearchViewController!, searchTextDidChange searchBar: UISearchBar!, searchText: String!) {
        if searchText.characters.count > 0 {
            
            /// 过滤数组
            let predicate = NSPredicate(format: "SELF CONTAINS %@", searchText)
            searchViewController.searchSuggestions = (allNames as NSArray).filtered(using: predicate) as! [String]
        }
    }
}
