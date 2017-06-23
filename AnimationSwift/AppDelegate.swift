//
//  AppDelegate.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/5/30.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import Spots

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setDefaultStyles()  //设置默认风格
        
        
        
        
        
        let rootViewController = GradientViewController(title: "Gradient")
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        return true
    }
    
    func setDefaultStyles() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.barStyle = .black     //状态栏和标题为白色
        navigationBar.isTranslucent = false //设置不透明
        navigationBar.titleTextAttributes = [   //设置标题文字属性
            NSForegroundColorAttributeName: Color.navigationBarForeground,  //前景色
            NSFontAttributeName: Font.navigationBar                         //字体
        ]
        navigationBar.barTintColor = UIColor(hex:"#FD4340")
        navigationBar.tintColor = Color.navigationBarForeground //导航栏按钮颜色
        navigationBar.shadowImage = UIImage()   //取消分割线
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

