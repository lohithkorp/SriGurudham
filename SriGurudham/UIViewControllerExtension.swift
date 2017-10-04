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
                
                do{
                    let html = contents
                    let doc: Document = try SwiftSoup.parse(html)
                    receivedTextData = try doc.getElementsByClass(classId).text()
                    
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
                print("could not load")
                let cachedTextData = UserDefaults.standard.string(forKey: classId)
                return cachedTextData!
            }
        }
        
        else {
            print("URL was bad")
            return ""
        }
    }
}
