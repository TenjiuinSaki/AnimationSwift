//
//  ButtonsViewController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/6/27.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import SwiftIconFont
import DOFavoriteButton

class ButtonsViewController: UICollectionViewController {

    var buttons = [(String, DOFavoriteButton)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        // Do any additional setup after loading the view.
        
        
        collectionView?.register(UINib(nibName: "ButtonViewCell", bundle: nil), forCellWithReuseIdentifier: "button_cell")
        let imageSize: CGFloat = 30
        let rect = CGRect(x: 15, y: 25, width: 50, height: 50)
        for (key, _) in fontAwesomeIconArr {
            let image = UIImage.icon(from: .FontAwesome, code: key, imageSize: CGSize(width: imageSize, height: imageSize), ofSize: imageSize)
            let button = DOFavoriteButton(frame: rect, image: image)
            button.addTarget(self, action: #selector(tapped(sender:)), for: .touchUpInside)
            buttons.append((key, button))
        }
        
        
    }
    func tapped(sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
        } else {
            sender.select()
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "button_cell", for: indexPath) as! ButtonViewCell
        let (name, button) = buttons[indexPath.row]
        
        cell.nameLabel.text = name
        for view in cell.contentView.subviews {
            if view is DOFavoriteButton {
                view.removeFromSuperview()
            }
        }
        cell.contentView.addSubview(button)
        return cell
    }

}
