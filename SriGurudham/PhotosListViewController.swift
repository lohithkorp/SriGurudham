//
//  PhotosListViewController.swift
//  SriGurudham
//
//  Created by Lohith Krishna Korupolu on 17/11/2017.
//  Copyright © 2017 Sri Gurudham. All rights reserved.
//

import UIKit
import SwiftSoup

class PhotosListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var photoAlbumName: String?
    @IBOutlet weak var collectionView: UICollectionView!
    
    var thumbnailImages = [String]()
    var thumbnailImagesData = [Data]()
    
    let kLoadColumnsPerRow = 2.0
    let kLoadSpan:CGFloat = 26.0
    let kLoadAspectRatio:CGFloat = 1.0
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Selected Album \(photoAlbumName)")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let photoListThumbnailViewCell = UINib(nibName: "PhotoListThumbnailCollectionViewCell", bundle: nil)
        self.collectionView.register(photoListThumbnailViewCell, forCellWithReuseIdentifier: "PhotoListThumbnailCollectionViewCell")
        
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
        
        self.fetchPhotosList(albumName: photoAlbumName!)
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
    }
    
    func fetchPhotosList(albumName: String) {
        
        if thumbnailImages.count > 0 && thumbnailImagesData.count > 0 {
            thumbnailImagesData.removeAll()
            thumbnailImages.removeAll()
        }
        
        let urlString = "http://srigurudham.org/\(albumName)"
        let percentEncodedUrlString = urlString.replacingOccurrences(of: " ", with: "%20")
        
        if let url = URL(string: percentEncodedUrlString) {
            do {
                let contents = try String(contentsOf: url)
                
                do {
                    let html = contents
                    let doc: Document = try SwiftSoup.parse(html)
                    
                    let srcs: Elements = try doc.getElementsByClass("thumbnail").select("img[src]")
                    
                    let srcsStringArray: [String] = srcs.array().map { try! $0.attr("src").description }
                    
                    let httpArray: [String] = srcsStringArray.map { $0.replacingOccurrences(of: "https", with: "http")}
                    
                    print("httpArray \(httpArray)")
                    
                    self.thumbnailImages = httpArray
                    
                    for i in 0..<self.thumbnailImages.count {
                        
                        let myURL = URL(string: thumbnailImages[i])
                        
                        let thumbnailImage = try? Data(contentsOf: myURL!)
                        
                        if let thumbnailImage = thumbnailImage {
                            thumbnailImagesData.append(thumbnailImage)
                            UserDefaults.standard.setValue(thumbnailImagesData, forKey: "\(photoAlbumName!)")
                        }
                        else {
                            let cachedArticleImages = UserDefaults.standard.array(forKey: "\(photoAlbumName!)")
                            thumbnailImagesData = cachedArticleImages as! [Data]
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
                let cachedThumbnailImages = UserDefaults.standard.array(forKey: "cachedPhotosListImages")
                thumbnailImagesData = cachedThumbnailImages as! [Data]
            }
        }
            
        else {
            print("URL was bad")
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        let presentingViewController = self.presentingViewController
        self.dismiss(animated: false, completion: {
            presentingViewController!.dismiss(animated: true, completion: {})
        })
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
        
        let collectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoListThumbnailCollectionViewCell", for: indexPath) as! PhotoListThumbnailCollectionViewCell
        
        if thumbnailImagesData.count > 0 {
            collectionViewCell.photoListThumbnail.image = UIImage(data: thumbnailImagesData[indexPath.row])
        }
        
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
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
