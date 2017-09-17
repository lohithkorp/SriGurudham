//
//  SideViewController.swift
//  SriGurudham
//
//  Created by Lohith Krishna Korupolu on 22/06/17.
//  Copyright © 2017 Sri Gurudham. All rights reserved.
//

import UIKit

class SideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let sideMenuItemList = ["Item1", "Item2", "Item3", "Item4", "Item5"]

    @IBOutlet weak var sideMenuTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        
        let sideMenuCellNib = UINib(nibName: "SideMenuCell", bundle: nil)
        sideMenuTableView.register(sideMenuCellNib, forCellReuseIdentifier: "SideMenuCell")
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return sideMenuItemList.count
        case 2:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.sideMenuTableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as! SideMenuCell
        
        cell.menuItemLabel.text = sideMenuItemList[0]
        
        return cell
    }
}

