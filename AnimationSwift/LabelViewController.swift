//
//  LabelViewController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/6/27.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import GlitchLabel
import LTMorphingLabel
import SnapKit

class LabelViewController: UIViewController {

    let lLabel = LTMorphingLabel()
    
    let texts = ["Swift",
                 "ObjectiveC",
                 "MacBook Pro",
                 "iPhone",
                 "iPad",
                 "Watch",
                 "iTunes"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        // Do any additional setup after loading the view.
        let gLabel = GlitchLabel()
        gLabel.text = "LTMorphingLabel"
        gLabel.font = UIFont.boldSystemFont(ofSize: 40)
        view.addSubview(gLabel)
        gLabel.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.centerX.equalTo(view)
        }
        
        lLabel.text = "A morphing UILabel"
        view.addSubview(lLabel)
        lLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lLabel.font = UIFont.systemFont(ofSize: 24)
//        lLabel.numberOfLines = 5      //不支持多行
        lLabel.textAlignment = .center
        lLabel.snp.makeConstraints { (make) in
            make.top.equalTo(200)
            make.centerX.equalTo(view)
            make.width.equalTo(300)
            make.height.equalTo(200)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lLabel.morphingEffect = LTMorphingEffect(rawValue: Int(arc4random()) % 7)!
        lLabel.text = texts.sm_random()
    }

}
