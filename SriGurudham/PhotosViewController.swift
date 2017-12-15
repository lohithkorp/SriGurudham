//
//  PhotosViewController.swift
//  SriGurudham
//
//  Created by Lohith Krishna Korupolu on 14/11/2017.
//  Copyright © 2017 Sri Gurudham. All rights reserved.
//

import UIKit
import SwiftSoup

class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let kLoadColumnsPerRow = 2.0
    let kLoadSpan:CGFloat = 26.0
    let kLoadAspectRatio:CGFloat = 1.0
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    var thumbnailImages = [String]()
    var thumbnailTitles = [String]()
    var albumLinks = [String]()
    var thumbnailImagesData = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let photoThumbnailViewCell = UINib(nibName: "PhotoThumbnailCollectionViewCell", bundle: nil)
        self.collectionView.register(photoThumbnailViewCell, forCellWithReuseIdentifier: "PhotoThumbnailCollectionViewCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
    }

    override func viewDidAppear(_ animated: Bool) {
        self.fetchPhotosData()
    }
    
    func fetchPhotosData() {
        self.startSpinner()
        if thumbnailImages.count > 0 && thumbnailImagesData.count > 0 {
            thumbnailImages.removeAll()
            thumbnailImagesData.removeAll()
        }
        
        let urlString = "http://srigurudham.org/photos"
        if let url = URL(string: urlString) {
            do {
                let contents = try String(contentsOf: url)
                
                do {
                    let html = contents
                    let doc: Document = try SwiftSoup.parse(html)
                    
                    let srcs: Elements = try doc.getElementsByClass("thumbnail").select("img[src]")
                    
                    let srcsStringArray: [String] = srcs.array().map { try! $0.attr("src").description }
                    
                    thumbnailTitles = srcs.array().map { try! $0.attr("alt").description }
                    
                    
                    let albumLinkSrcs: Elements = try doc.getElementsByClass("title").select("a[href]")
                    
                    albumLinks = albumLinkSrcs.array().map { try! $0.attr("href").description }
                    
                    let httpArray: [String] = srcsStringArray.map { $0.replacingOccurrences(of: "https", with: "http")}
                    
                    print("httpArray \(httpArray)")
                    
                    self.thumbnailImages = httpArray
                    
                    for i in 0..<self.thumbnailImages.count {
                        
                        let myURL = URL(string: thumbnailImages[i])
                        
                        let thumbnailImage = try? Data(contentsOf: myURL!)
                        
                        if let thumbnailImage = thumbnailImage {
                            thumbnailImagesData.append(thumbnailImage)
                            UserDefaults.standard.setValue(thumbnailImagesData, forKey: "cahcedThumbnailImages")
                        }
                        else {
                            let cachedArticleImages = UserDefaults.standard.array(forKey: "cahcedThumbnailImages")
                            thumbnailImagesData = cachedArticleImages as! [Data]
                        }
                    }
                    collectionView.reloadData()
                    self.stopSpinner()
                    
                }catch Exception.Error(let type, let message){
                    print(message)
                    self.stopSpinner()
                }catch{
                    print("error")
                    self.stopSpinner()
                }
                
            } catch {
                print("servers not reachable")
                let cachedThumbnailImages = UserDefaults.standard.array(forKey: "cahcedThumbnailImages")
                thumbnailImagesData = cachedThumbnailImages as! [Data]
                self.stopSpinner()
            }
        }
            
        else {
            print("URL was bad")
            self.stopSpinner()
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
        if thumbnailImagesData.count > 0 {
            return (thumbnailImagesData.count)
        }
            
        else {
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoThumbnailCollectionViewCell", for: indexPath) as! PhotoThumbnailCollectionViewCell
        
        if thumbnailImagesData.count > 0 && thumbnailTitles.count > 0 {
            collectionViewCell.thumbnailImage.image = UIImage(data: thumbnailImagesData[indexPath.row])
            collectionViewCell.thumbnailDescription.text = thumbnailTitles[indexPath.row]
        }
        
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photosListVc = storyboard?.instantiateViewController(withIdentifier: "PhotosListViewController") as! PhotosListViewController
        photosListVc.photoAlbumName = albumLinks[indexPath.row]
        
        let navigationController = UINavigationController(rootViewController: photosListVc)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let collectionCellWidth = (screenWidth - (CGFloat(kLoadColumnsPerRow) * kLoadSpan))/CGFloat(kLoadColumnsPerRow) - 1
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
    
}
