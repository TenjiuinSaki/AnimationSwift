//
//  SideViewController.swift
//  AnimationSwift
//
//  Created by HKMac on 2017/7/4.
//  Copyright © 2017年 张玉飞. All rights reserved.
//

import UIKit

class SideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let texts = ["MENU1","MENU2","MENU3","MENU4"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = texts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        evo_drawerController?.closeDrawer(animated: true) { _ in
            let nav = self.evo_drawerController?.centerViewController as! UINavigationController
            nav.pushViewController(LabelViewController(), animated: true)
        }
    }
}
