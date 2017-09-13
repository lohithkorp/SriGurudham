//
//  TopViewController.swift
//  SriGurudham
//
//  Created by Colruyt Group on 22/06/17.
//  Copyright © 2017 Sri Gurudham. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func showMenuButtonAction(_ sender: AnyObject) {
        if let container = self.so_containerViewController {
            container.isSideViewControllerPresented = true
        }
    }
}
