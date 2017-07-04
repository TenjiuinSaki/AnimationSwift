//
//  ChildViewController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/7/4.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit

class ChildViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var index = 0
    let tableView = UITableView(frame: Screen.bounds, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
        tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        tableView.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(index) - \(indexPath.row)"
        cell.backgroundColor = UIColor.clear
        return cell
    }

}
