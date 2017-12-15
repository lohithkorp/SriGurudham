//
//  AudioViewController.swift
//  SriGurudham
//
//  Created by Lohith Krishna Korupolu on 09/11/2017.
//  Copyright © 2017 Sri Gurudham. All rights reserved.
//

import UIKit

class AudioViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startSpinner()
        let urlString = "https://soundcloud.com/search?q=sri%20gurudham"
        let myUrl = URL(string: urlString)
        
        if let myUrl = myUrl {
            let urlRequest = URLRequest(url: myUrl)
            webView.loadRequest(urlRequest)
            self.stopSpinner()
        }

    }
    
    @IBAction func sideMenuButtonAction(_ sender: Any) {
        if let container = self.so_containerViewController {
            container.isSideViewControllerPresented = true
        }
    }
}
