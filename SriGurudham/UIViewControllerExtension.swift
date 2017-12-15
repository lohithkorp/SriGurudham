//
//  UIViewControllerExtension.swift
//  SriGurudham
//
//  Created by Lohith Krishna Korupolu on 04/10/2017.
//  Copyright © 2017 Sri Gurudham. All rights reserved.
//

import UIKit
import SwiftSoup

var imageViewObject: UIImageView?

extension UIViewController {
    
    func getSriGurudhamTextData(urlString: String, classId: String, isAnnouncements: Bool) -> String {
        
        let receivedTextData: String?
        
        if let url = URL(string: urlString) {
            do {
                let contents = try String(contentsOf: url)
                
                do {
                    let html = contents
                    let doc: Document = try SwiftSoup.parse(html)
                    receivedTextData = try doc.getElementsByClass(classId).tagName("h").text()
                    
                    if let receivedTextData = receivedTextData {
                        UserDefaults.standard.setValue(receivedTextData, forKey: classId)
                        
                        if isAnnouncements {
                            return "శ్రీ హనుమ జయ హనుమ జయ శివానంద హనుమ"
                        }
                        else {
                            return receivedTextData
                        }
                    }
                    
                    else {
                        let cachedTextData = UserDefaults.standard.string(forKey: classId)
                        
                        if isAnnouncements {
                            return "శ్రీ హనుమ జయ హనుమ జయ శివానంద హనుమ"
                        }
                        else {
                            return cachedTextData!
                        }
                    }
                    
                }catch Exception.Error(let type, let message){
                     
                    return message
                }catch{
                    print("error")
                     
                    return ""
                }
                
            } catch {
                if let cachedTextData = UserDefaults.standard.string(forKey: classId) {
                     
                    if isAnnouncements {
                        return "శ్రీ హనుమ జయ హనుమ జయ శివానంద హనుమ"
                    }
                    else {
                        return cachedTextData
                    }
                }
                else {
                    showServiceAlert()
                     
                    return ""
                }
            }
        }
        
        else {
             
            print("URL was bad")
            return ""
        }
    }
    
    func showServiceAlert() {
        DispatchQueue.main.async(execute: {
            let alert = UIAlertView(title: "Sri Gurudham", message: "Could not reach servers at the moment. Please try again", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        })
    }
    
    func showInternetConnectivityAlert() {
        DispatchQueue.main.async(execute: {
            let alert = UIAlertView(title: "Sri Gurudham", message: "Your device is not Connected to the Internet.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        })
    }
    
    func startSpinner() {
        
        imageViewObject = UIImageView(frame:CGRect(x: 10, y: 10, width: 40, height: 40))
        imageViewObject?.center = self.view.center
        
        if let activitySpinner = imageViewObject {
            
            activitySpinner.image = UIImage(named:"activity_indicator")
            self.view.addSubview(activitySpinner)
            
            rotateImageView(activitySpinner)
            
        }
    }
    
    func rotateImageView(_ spinnerImage: UIImageView) {
        UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            spinnerImage.transform = spinnerImage.transform.rotated(by: CGFloat(M_PI_2))
        }) { (finished) -> Void in
            DispatchQueue.main.async(execute: {
                self.rotateImageView(spinnerImage)
            })
        }
    }
    
    func stopSpinner() {
        if let activitySpinner = imageViewObject {
            activitySpinner.removeFromSuperview()
        }
    }
}
