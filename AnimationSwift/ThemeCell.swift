//
//  ThemeCell.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/6/25.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import Themes
import Spots

class ThemeCell: UITableViewCell, ItemConfigurable {

    @IBOutlet weak var pictureView: UIImageView!

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var rowHeight: CGFloat = 44
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        pictureView.layer.cornerRadius = 5
        pictureView.layer.masksToBounds = true
        
        container.layer.cornerRadius = 10
        container.layer.shadowOpacity = 0
        container.layer.shadowOffset = CGSize.zero
        
        use(MyTheme.self) { (weakSelf, theme) in
            weakSelf.container.backgroundColor = theme.cellColor
            weakSelf.titleLabel.font = theme.titleFont
            weakSelf.titleLabel.textColor = theme.foreColor
            weakSelf.subTitleLabel.font = theme.titleFont
            weakSelf.subTitleLabel.textColor = theme.foreColor
            weakSelf.pictureView.backgroundColor = theme.backgroundColor
            weakSelf.pictureView.image = theme.topImage
            weakSelf.rowHeight = theme.cellHeight
        }
        
        selectionStyle = .none
    }
    
    func configure(with item: Item) {
        titleLabel.text = item.title
        subTitleLabel.text = item.subtitle
    }

    func computeSize(for item: Item) -> CGSize {
        return CGSize(width: Screen.width, height: rowHeight)
    }
}
