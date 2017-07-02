//
//  GradientTableViewCell.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/6/23.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import Spots
import LTMorphingLabel
import SwiftyTimer

class GradientTableViewCell: UITableViewCell, ItemConfigurable {
    
    lazy var titleLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 10, width: Screen.width - 20, height: 20)
        label.textColor = Color.cellForeground
        label.font = Font.cell
        self.addSubview(label)
        return label
        
    }()
    
    func configure(with item: Item) {
        titleLabel.text = item.title
    }
    
    func computeSize(for item: Item) -> CGSize {
        return CGSize(width: Screen.width, height: 64)
    }
}
