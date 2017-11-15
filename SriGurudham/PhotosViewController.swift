//
//  PhotosViewController.swift
//  SriGurudham
//
//  Created by Lohith Krishna Korupolu on 14/11/2017.
//  Copyright © 2017 Sri Gurudham. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let kLoadColumnsPerRow = 2.0
    let kLoadSpan:CGFloat = 26.0
    let kLoadAspectRatio:CGFloat = 1.0
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let photoThumbnailViewCell = UINib(nibName: "PhotoThumbnailCollectionViewCell", bundle: nil)
        self.collectionView.register(photoThumbnailViewCell, forCellWithReuseIdentifier: "PhotoThumbnailCollectionViewCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
//        self.fetchPhotosData()
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
//        if articleImagesData.count > 0 {
//            return (articleImagesData.count)
//        }
//            
//        else {
//            return 0
//        }
        
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoThumbnailCollectionViewCell", for: indexPath) as! PhotoThumbnailCollectionViewCell
        
//        if articleImagesData.count > 0 {
//            collectionViewCell.articleImage.image = UIImage(data: articleImagesData[indexPath.row])
//        }
        
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let articleDetailVc = storyboard?.instantiateViewController(withIdentifier: "PhotoThumbnailCollectionViewCell") as! PhotoThumbnailCollectionViewCell
//        articleDetailVc.articleImage = articleImagesData[indexPath.row]
//        let navigationController = UINavigationController(rootViewController: articleDetailVc)
//        self.present(navigationController, animated: true, completion: nil)
//        
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
    
}
