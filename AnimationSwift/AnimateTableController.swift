//
//  AnimateTableController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/6/24.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import Hero
import DrawerController

class AnimateTableController: UITableViewController {
    
    var animations: [HeroDefaultAnimationType] = [
        .push(direction: .right),
        .pull(direction: .left),
        .slide(direction: .left),
        .zoomSlide(direction: .left),
        .cover(direction: .up),
        .uncover(direction: .up),
        .pageIn(direction: .left),
        .pageOut(direction: .left),
        .fade,
        .zoom,
        .zoomOut,
        .none
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navigationController = navigationController else { return }
        navigationController.isHeroEnabled = true
        isHeroEnabled = true    //激活Hero
        
        setDrawer()
    }
    @IBAction func openDrawer(_ sender: Any) {
        evo_drawerController?.toggleLeftDrawerSide(animated: true, completion: nil)
    }
    /// 添加覆盖层
    lazy var coverView: UIView = { [unowned self] in
        let coverView = UIView(frame: Screen.bounds)
        self.navigationController?.view.addSubview(coverView)
        coverView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).alpha(0.2)
        coverView.alpha = 0
        return coverView
    }()
    
    /// 添加抽屉菜单
    func setDrawer() {
        if let drawerController = evo_drawerController {
            drawerController.showsShadows = false               //不显示阴影
            drawerController.maximumLeftDrawerWidth = Screen.width - 70       //菜单宽度
            drawerController.openDrawerGestureModeMask = .panningNavigationBar  //滑动导航栏打开菜单
            drawerController.closeDrawerGestureModeMask = .all      //任何滑动关闭菜单
            drawerController.minimumAnimationDuration = 0.3         //开关动画时长
            drawerController.shouldStretchDrawer = false            //禁止菜单拉伸
            drawerController.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            drawerController.drawerVisualStateBlock = { [unowned self] (drawerController, drawerSide, percentVisible) in
                self.coverView.alpha = percentVisible              //覆盖层渐变
                let visualStateBlock = DrawerVisualState.parallaxVisualStateBlock(parallaxFactor: 3.0)                          // 1/3处闭合
                visualStateBlock(drawerController, drawerSide, percentVisible)
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            present(gradientViewController(), animated: true, completion: nil)
        case 1:
            // pastel不设置为根视图动画会停止（目测是个bug）
            Storyboard.setRootViewController(Storyboard.instance("pastel"))
        case 2:
            present(themeViewController(), animated: true, completion: nil)
        case 3:
            navigationController?.pushViewController(AlphaTableViewController(), animated: true)
        case 5:
            navigationController?.pushViewController(LabelViewController(), animated: true)
        case 6:
            navigationController?.pushViewController(PageViewController(), animated: true)
        case 8:
            present(pageMentController(), animated: true, completion: nil)
        default: ()
        }

        
    }
    
    
    func gradientViewController() -> UIViewController {
        let rootViewController = GradientViewController(title: "Gradient")
        let nav = UINavigationController(rootViewController: rootViewController)
        
        let navigationBar = nav.navigationBar
        navigationBar.barStyle = .black     //状态栏和标题为白色
        navigationBar.isTranslucent = false //设置不透明
        navigationBar.titleTextAttributes = [   //设置标题文字属性
            NSForegroundColorAttributeName: Color.navigationBarForeground,  //前景色
            NSFontAttributeName: Font.navigationBar                         //字体
        ]
        navigationBar.barTintColor = #colorLiteral(red: 0.9921568627, green: 0.262745098, blue: 0.2509803922, alpha: 1)
        navigationBar.tintColor = Color.navigationBarForeground //导航栏按钮颜色
        navigationBar.shadowImage = UIImage()   //取消分割线
        
        
        return nav
    }
    
    func themeViewController() -> UIViewController {
        let themeViewController = ThemeViewController(title: "Theme")
        let nav = UINavigationController(rootViewController: themeViewController)
        return nav
    }
    
    func pageMentController() -> UIViewController {
        let nav = UINavigationController(rootViewController: PageMenuViewController())
        
        let navigationBar = nav.navigationBar
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.barTintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        ]
        return nav
    }
    
}

