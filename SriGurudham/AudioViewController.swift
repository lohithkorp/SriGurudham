//
//  AudioViewController.swift
//  SriGurudham
//
//  Created by Lohith Krishna Korupolu on 09/11/2017.
//  Copyright © 2017 Sri Gurudham. All rights reserved.
//

import UIKit

class AudioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sideMenuButtonAction(_ sender: Any) {
        if let container = self.so_containerViewController {
            container.isSideViewControllerPresented = true
        }
    }
}
