//
//  SideViewController.swift
//  SriGurudham
//
//  Created by Lohith Krishna Korupolu on 22/06/17.
//  Copyright © 2017 Sri Gurudham. All rights reserved.
//

import UIKit

class SideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let sideMenuItemList = ["Home", "Guruvugaru", "Schedule", "Audios", "Videos", "Photos", "Articles", "Services", "Contact Us"]
    
    let sideMenuIconList = ["sideMenuHomeIcon", "sideMenuHomeIcon", "sideMenuHomeIcon", "sideMenuHomeIcon", "sideMenuHomeIcon", "sideMenuHomeIcon", "sideMenuHomeIcon", "sideMenuHomeIcon", "sideMenuHomeIcon"]
    
    var cell:UITableViewCell!

    @IBOutlet weak var sideMenuTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        
        let sideMenuCellNib = UINib(nibName: "SideMenuCell", bundle: nil)
        sideMenuTableView.register(sideMenuCellNib, forCellReuseIdentifier: "SideMenuCell")
        
        let sideMenuImageCellNib = UINib(nibName: "SideMenuImageCell", bundle: nil)
        sideMenuTableView.register(sideMenuImageCellNib, forCellReuseIdentifier: "SideMenuImageCell")
        
        let sideMenuCommunicateCell = UINib(nibName: "SideMenuCommunicateCell", bundle: nil)
        sideMenuTableView.register(sideMenuCommunicateCell, forCellReuseIdentifier: "SideMenuCommunicateCell")
        
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
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 220.0
            
        case 1:
            return 44.0
            
        case 2:
            return 50.0
            
        default:
            return 44.0
        
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = self.sideMenuTableView.dequeueReusableCell(withIdentifier: "SideMenuImageCell") as! SideMenuImageCell
            
            return cell
            
        case 1:
            let cell = self.sideMenuTableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as! SideMenuCell
            
//            for i in 0..<sideMenuItemList.count {
//                cell.menuItemLabel.text = sideMenuItemList[i]
//            }
            
            cell.menuItemLabel.text = sideMenuItemList[indexPath.row]
            cell.menuItemIcon.image = UIImage(named: sideMenuIconList[indexPath.row])
            
            return cell
        
        case 2:
            let cell = self.sideMenuTableView.dequeueReusableCell(withIdentifier: "SideMenuCommunicateCell") as! SideMenuCommunicateCell
            
            return cell
            
        default:
            return cell
       
        }
    }
}

