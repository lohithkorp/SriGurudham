//
//  ArticleDetailViewController.swift
//  SriGurudham
//
//  Created by Lohith Krishna Korupolu on 08/11/2017.
//  Copyright © 2017 Sri Gurudham. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var articleDetailImageView: UIImageView!
    
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let urlString = urlString {
            if let myURL = URL(string: urlString) {
                let articleImage = try? Data(contentsOf: myURL)
                
                if let articleImage = articleImage {
                    articleDetailImageView.image = UIImage(data: articleImage)
                }
            }
        }
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Sri Gurudham"
        
        let button =  UIButton(type: .custom)
        button.setImage(UIImage(named: "IconBack"), for: UIControlState())
        button.addTarget(self, action: #selector(backAction), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -60, 0, -32)//move image to the right
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        let presentingViewController = self.presentingViewController
        self.dismiss(animated: false, completion: {
            presentingViewController!.dismiss(animated: true, completion: {})
        })
    }
}
