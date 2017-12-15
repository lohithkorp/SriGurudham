//
//  HomeViewController.swift
//  SriGurudham
//
//  Created by Lohith Krishna Korupolu on 02/10/2017.
//  Copyright © 2017 Sri Gurudham. All rights reserved.
//

import UIKit
import SwiftSoup

class HomeViewController: UIViewController {

    @IBOutlet weak var announcementsLabel: UILabel!
    @IBOutlet weak var gurujiImageView: UIImageView!
    
    @IBOutlet weak var announcementsView: UIView!
    @IBOutlet weak var quotationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let slideImages: [UIImage] = [UIImage(named: "slide1")!, UIImage(named: "slide2")!, UIImage(named: "slide3")!, UIImage(named: "slide4")!]
        
        self.gurujiImageView.animationImages = slideImages
        self.gurujiImageView.animationDuration = 12
        self.gurujiImageView.startAnimating()
        
        UIView.animate(withDuration: 12.0, delay: 1, options: ([.curveLinear, .repeat]), animations: {() -> Void in
            self.announcementsLabel.center = CGPoint(x: 0 - self.announcementsLabel.bounds.size.width / 2, y: self.announcementsLabel.center.y)
        }, completion:  { _ in })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        quotationLabel.text = self.getSriGurudhamTextData(urlString: "http://srigurudham.org", classId: "ntr", isAnnouncements: false)
        announcementsLabel.text = self.getSriGurudhamTextData(urlString: "http://srigurudham.org/schedule", classId: "inside", isAnnouncements: true)
        
        if announcementsLabel.text == "శ్రీ హనుమ జయ హనుమ జయ శివానంద హనుమ" {
            return
        }
        else {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.showScheduleVc))
            announcementsView.addGestureRecognizer(tapGesture)
        }
    }
    
    func showScheduleVc() {
        self.so_containerViewController?.topViewController = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleDetailViewController")
    }

    @IBAction func sideMenuButtonAction(_ sender: Any) {
        if let container = self.so_containerViewController {
            container.isSideViewControllerPresented = true
        }
    }
}
