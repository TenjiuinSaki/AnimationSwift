//
//  BlurViewController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/7/7.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import SABlurImageView

class BlurViewController: UIViewController {

    let blurView = SABlurImageView()
    let container = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Blur"
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        view.addSubview(container)
        container.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        container.snp.makeConstraints { (make) in
            make.centerY.left.right.equalTo(view)
            make.height.equalTo(Screen.width)
        }
        
        
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "unicorn")
        container.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.right.equalTo(container).inset(10)
            make.centerY.equalTo(container)
            make.height.equalTo(imageView.snp.width).multipliedBy(9.0 / 16)  //比例适配要有浮点型数据
        }
        
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        blurView.image = container.snapshot()
        blurView.frame = container.frame
        view.addSubview(blurView)
        blurView.configrationForBlurAnimation()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        blurView.startBlurAnimation(1.5)
    }

}
