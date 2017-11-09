//
//  UIViewControllerExtension.swift
//  SriGurudham
//
//  Created by Lohith Krishna Korupolu on 04/10/2017.
//  Copyright © 2017 Sri Gurudham. All rights reserved.
//

import UIKit
import SwiftSoup

extension UIViewController {
    
    func getSriGurudhamTextData(urlString: String, classId: String) -> String {
        
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
                        return receivedTextData
                    }
                    
                    else {
                        let cachedTextData = UserDefaults.standard.string(forKey: classId)
                        return cachedTextData!
                    }
                    
                }catch Exception.Error(let type, let message){
                    return message
                }catch{
                    print("error")
                    return ""
                }
                
            } catch {
                if let cachedTextData = UserDefaults.standard.string(forKey: classId) {
                    return cachedTextData
                }
                else {
                    return ""
                    showServiceAlert()
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
}
