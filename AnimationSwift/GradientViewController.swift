//
//  GradientViewController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/6/23.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import Spots
import Fakery
import Hue
import SwiftIconFont

class GradientViewController: SpotsController {
    
    
    
    lazy var gradient: CAGradientLayer =  {
        return [Color.color1, Color.color2].gradient({ (gradient) -> CAGradientLayer in
            gradient.speed = 0  // 动画速度为0，即不自动执行动画
            gradient.frame = Screen.bounds
            return gradient
        })
    }()
    
    lazy var animation: CABasicAnimation = { [unowned self] in
        let key = #keyPath(CAGradientLayer.colors)
        let animation = CABasicAnimation(keyPath: key)
        animation.duration = 1  //设置动画时长为1
        animation.isRemovedOnCompletion = false
        animation.fromValue = self.gradient.colors
        animation.toValue = [
            Color.color3.cgColor,
            Color.color4.cgColor
        ]
        return animation
    }()
    
    convenience init(title: String) {
        Configuration.register(view: GradientTableViewCell.self, identifier: "gradient_cell")                       //注册UITableViewCell
        let model = ComponentModel(kind: .list)     //设置为UITableView模式渲染
        let component = Component(model: model)
        
        if let tableView = component.tableView {    //设置UITableView样式
            tableView.backgroundColor = UIColor.clear
            tableView.separatorInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            tableView.separatorColor = Color.cellSeparator
            tableView.tableFooterView = UIView()   //删除多余的分割线
            
        }
        
        
        self.init(component: component)
        self.title = title
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let navigationController = navigationController else { return }
        
        navigationController.view.layer.insertSublayer(gradient, at: 0)
        gradient.timeOffset = 0  //设置为动画起始状态
        gradient.add(animation, forKey: "change_colors")
        
        let image = UIImage.icon(from: .Ionicon, code: "ios-close-empty", imageSize: CGSize(width: 36, height: 36), ofSize: 36)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(hero_dismissViewController))
        
        scrollView.contentInset.bottom = 20     //设置底边距
        
        // 给ComponentModel的设置数据源，刷新TableView
        update({ (component) in
            component.model.items = self.generateItems(counts: 50)
        })
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateGradient()
    }
    
    func updateGradient() {
        // 根据偏移量设置动画的进度 0~1
        let offset = scrollView.contentOffset.y / scrollView.contentSize.height
        // 时间偏移量为正数且小于动画时长
        if offset >= 0 && offset <= CGFloat(animation.duration) {
            gradient.timeOffset = CFTimeInterval(offset)
        }
        updateNavigationBarColor()
    }
    
    /// 更新导航栏的颜色
    func updateNavigationBarColor() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        if let gradientLayer = gradient.presentation(), // 获取当前副本
            let colors = gradientLayer.colors as? [CGColor], // 获取最新颜色值
            let firstColor = colors.first {
                // 获取第一个即最上方的颜色设置为navigationBar的颜色
                navigationBar.barTintColor = UIColor(cgColor: firstColor)
        }
        
    }

    func generateItems(counts: Int) -> [Item] {
        var items = [Item]()
        let faker = Faker() //造假数据
        for _ in 1...counts {
            items.append(Item(title: faker.lorem.sentence(), kind: "gradient_cell"))        //设置数据源和重用标识符
        }
        return items
    }
}
