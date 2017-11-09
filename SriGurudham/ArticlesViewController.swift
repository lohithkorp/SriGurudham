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
    var articleImagesData = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let articleViewCell = UINib(nibName: "ArticlesCollectionViewCell", bundle: nil)
        self.collectionView.register(articleViewCell, forCellWithReuseIdentifier: "ArticlesCollectionViewCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        self.fetchArticlesData()
    }
    
    func fetchArticlesData() {
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
                    
                    for i in 0..<self.articleImages.count {
                    
                        let myURL = URL(string: articleImages[i])
                        
                        let articleImage = try? Data(contentsOf: myURL!)
                        
                        if let articleImage = articleImage {
                            articleImagesData.append(articleImage)
                            UserDefaults.standard.setValue(articleImagesData, forKey: "cahcedArticleImages")
                        }
                        else {
                            let cachedArticleImages = UserDefaults.standard.array(forKey: "cahcedArticleImages")
                            articleImagesData = cachedArticleImages as! [Data]
                        }
                    }
                    collectionView.reloadData()
                    
                }catch Exception.Error(let type, let message){
                    print(message)
                }catch{
                    print("error")
                }
                
            } catch {
                print("servers not reachable")
                let cachedArticleImages = UserDefaults.standard.array(forKey: "cahcedArticleImages")
                articleImagesData = cachedArticleImages as! [Data]
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
        if articleImagesData.count > 0 {
            return (articleImagesData.count)
        }
        
        else {
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ArticlesCollectionViewCell", for: indexPath) as! ArticlesCollectionViewCell
        
        if articleImagesData.count > 0 {
            collectionViewCell.articleImage.image = UIImage(data: articleImagesData[indexPath.row])
        }
        
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let articleDetailVc = storyboard?.instantiateViewController(withIdentifier: "ArticleDetailViewController") as! ArticleDetailViewController
        articleDetailVc.articleImage = articleImagesData[indexPath.row]
        let navigationController = UINavigationController(rootViewController: articleDetailVc)
        self.present(navigationController, animated: true, completion: nil)
        
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
