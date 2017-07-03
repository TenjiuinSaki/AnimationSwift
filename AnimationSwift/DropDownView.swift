//
//  DropDownView.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/7/3.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit
import YNDropDownMenu
import SwiftIconFont

class DropListView: YNDropDownView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let items: [Fonts] = [.FontAwesome,
                          .Iconic,
                          .Ionicon,
                          .MapIcon,
                          .MaterialIcon,
                          .Octicon,
                          .Themify]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "drop_cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drop_cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].rawValue
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "icons_type"), object: items[indexPath.row])
        hideMenu()
    }
}

class DropCustomView: YNDropDownView {
    
    @IBAction func certain(_ sender: Any) {
        hideMenu()
    }
}
