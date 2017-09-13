//
//  ContainerViewController.swift
//  SriGurudham
//
//  Created by Lohith Krishna Korupolu on 22/06/17.
//  Copyright © 2017 Sri Gurudham. All rights reserved.
//

import UIKit
import SidebarOverlay

class ContainerViewController: SOContainerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.menuSide = .left
        self.topViewController = self.storyboard?.instantiateViewController(withIdentifier: "topScreen")
        self.sideViewController = self.storyboard?.instantiateViewController(withIdentifier: "leftScreen")
    }
    
}
