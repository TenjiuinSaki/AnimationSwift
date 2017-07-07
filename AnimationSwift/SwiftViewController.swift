//
//  SwiftViewController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/7/7.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let gradient = [#colorLiteral(red: 0.9875989556, green: 0.6492443085, blue: 0.3210561872, alpha: 1), #colorLiteral(red: 0.9901875854, green: 0.4013286829, blue: 0.2345763743, alpha: 1)].gradient()
        gradient.frame = Screen.bounds
        view.layer.addSublayer(gradient)
        
        let label = UILabel()
        label.text = "Swift"
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = Font.size(44, name: "Zapfino")
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.popViewController(animated: true)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
