//
//  PastelViewController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/6/25.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import Pastel
import SwiftIconFont
import ActiveLabel

class PastelViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.parseIcon()
        }
    }
    
    @IBOutlet weak var userContainer: UIView! {
        didSet {
            userContainer.layer.cornerRadius = 4
            userContainer.backgroundColor = UIColor.white.alpha(0.2)
            
        }
    }
    @IBOutlet weak var passContainer: UIView! {
        didSet {
            passContainer.layer.cornerRadius = 4
            passContainer.backgroundColor = UIColor.white.alpha(0.2)
        }
    }
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = 4
            loginButton.layer.borderColor = UIColor.white.alpha(0.2).cgColor
            loginButton.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var headerLabel: UILabel! {
        didSet {
            headerLabel.font = Font.header
        }
    }
    @IBOutlet weak var activeLabel: ActiveLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let pastelView = PastelView(frame: Screen.bounds)
        view.insertSubview(pastelView, at: 0)
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight

        pastelView.animationDuration = 3
//
//        pastelView.setColors([#colorLiteral(red: 0.6117647059, green: 0.1529411765, blue: 0.6901960784, alpha: 1), #colorLiteral(red: 1, green: 0.2509803922, blue: 0.5058823529, alpha: 1), #colorLiteral(red: 0.4823529412, green: 0.1215686275, blue: 0.6352941176, alpha: 1), #colorLiteral(red: 0.1254901961, green: 0.2980392157, blue: 1, alpha: 1), #colorLiteral(red: 0.1254901961, green: 0.6196078431, blue: 1, alpha: 1), #colorLiteral(red: 0.3529411765, green: 0.4705882353, blue: 0.4980392157, alpha: 1), #colorLiteral(red: 0.2274509804, green: 0.4705882353, blue: 0.8509803922, alpha: 1)])
        pastelView.startAnimation()
        
        let customType = ActiveType.custom(pattern: "\\sSign in\\b")
        activeLabel.enabledTypes.append(customType)
        activeLabel.customize { (label) in
            label.text = "Not have an account? Sign in"
            label.textColor = UIColor.white.alpha(0.5)
            label.configureLinkAttribute = { (type, attr, isSelected) in
                var attr = attr
                if type == customType {
                    attr[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 14)
                    attr[NSForegroundColorAttributeName] = UIColor.white
                }
                return attr
            }
            label.handleCustomTap(for: customType, handler: { (str) in
                print(str)
            })
        }
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func closeAction(_ sender: Any) {
        Storyboard.setRootViewController(Storyboard.initial())
    }

}
