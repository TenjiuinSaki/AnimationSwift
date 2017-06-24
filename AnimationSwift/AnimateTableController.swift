//
//  AnimateTableController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/6/24.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import Hero

class AnimateTableController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navigationController = navigationController else { return }
        navigationController.isHeroEnabled = true
        isHeroEnabled = true    //激活Hero
    }
    
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            present(gradientViewController(), animated: true, completion: nil)
        } else {
            present(themeViewController(), animated: true, completion: nil)
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let row = (sender as! NSIndexPath).row
//        switch row {
//        case 1:
//            
//        default:
//            ()
//        }
//        
//    }
    
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
        let themeViewController = ThemeViewController()
        let nav = UINavigationController(rootViewController: themeViewController)
        return nav
    }
    
}

