//
//  ArticlesViewController.swift
//  SriGurudham
//
//  Created by Lohith Krishna Korupolu on 07/11/2017.
//  Copyright © 2017 Sri Gurudham. All rights reserved.
//

import UIKit
import SwiftSoup

class ArticlesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let kLoadColumnsPerRow = 2.0
    let kLoadSpan:CGFloat = 26.0
    let kLoadAspectRatio:CGFloat = 1.0

    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    var articleImages: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let articleViewCell = UINib(nibName: "ArticlesCollectionViewCell", bundle: nil)
        self.collectionView.register(articleViewCell, forCellWithReuseIdentifier: "ArticlesCollectionViewCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let urlString = "http://srigurudham.org/articles"
        
        if let url = URL(string: urlString) {
            do {
                let contents = try String(contentsOf: url)
                
                do {
                    let html = contents
                    let doc: Document = try SwiftSoup.parse(html)
                    
                    let srcs: Elements = try doc.getElementById("Content")!.select("img[src]")
                    let srcsStringArray: [String] = srcs.array().map { try! $0.attr("src").description }
                    print("srcsStringArray \(srcsStringArray)")
                    
                    self.articleImages = srcsStringArray
                    
                    collectionView.reloadData()

                }catch Exception.Error(let type, let message){
                    print(message)
                }catch{
                    print("error")
                }
                
            } catch {
                //TODO:- ALERT saying could not reach servers!\
            }
        }
            
        else {
            print("URL was bad")
        }
    }
    
    @IBAction func sideMenuButtonAction(_ sender: Any) {
        if let container = self.so_containerViewController {
            container.isSideViewControllerPresented = true
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleImages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ArticlesCollectionViewCell", for: indexPath) as! ArticlesCollectionViewCell
        
        let myURL = URL(string: articleImages[indexPath.row])
        
        let testImage = try? Data(contentsOf: myURL!)
        
        if let testImage = testImage {
            collectionViewCell.articleImage.image = UIImage(data: testImage)
        }
        
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let collectionCellWidth = (screenWidth - (CGFloat(kLoadColumnsPerRow + 1.0) * kLoadSpan))/CGFloat(kLoadColumnsPerRow) - 1
        
        return CGSize(width: collectionCellWidth , height: collectionCellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20.0
    }
    
}
