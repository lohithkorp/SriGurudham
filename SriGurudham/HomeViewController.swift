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
    
    @IBOutlet weak var quotationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let slideImages: [UIImage] = [UIImage(named: "slide1")!, UIImage(named: "slide2")!, UIImage(named: "slide3")!, UIImage(named: "slide4")!]
        
        self.gurujiImageView.animationImages = slideImages
        self.gurujiImageView.animationDuration = 12
        self.gurujiImageView.startAnimating()

        announcementsLabel.text = "Sivananda"
        
        UIView.animate(withDuration: 12.0, delay: 1, options: ([.curveLinear, .repeat]), animations: {() -> Void in

            self.announcementsLabel.center = CGPoint(x: 0 - self.announcementsLabel.bounds.size.width / 2, y: self.announcementsLabel.center.y)
        }, completion:  { _ in })
        
        if let url = URL(string: "http://srigurudham.org") {
            do {
                let contents = try String(contentsOf: url)
                
                do{
                    let html = contents
                    let doc: Document = try SwiftSoup.parse(html)
                    quotationLabel.text = try doc.getElementsByClass("ntr").text()
                }catch Exception.Error(let type, let message){
                    print(message)
                }catch{
                    print("error")
                }

            } catch {
                print("could not load")
            }
        } else {
            print("URL was bad")
        }
        
        if let url = URL(string: "http://srigurudham.org/schedule") {
            do {
                let contents = try String(contentsOf: url)
                
                do{
                    let html = contents
                    let doc: Document = try SwiftSoup.parse(html)
                    announcementsLabel.text = try doc.getElementsByClass("inside").text()
                }catch Exception.Error(let type, let message){
                    print(message)
                }catch{
                    print("error")
                }
                
            } catch {
                print("could not load")
            }
        } else {
            print("URL was bad")
        }
    }

    @IBAction func sideMenuButtonAction(_ sender: Any) {
        if let container = self.so_containerViewController {
            container.isSideViewControllerPresented = true
        }
    }
    
}
