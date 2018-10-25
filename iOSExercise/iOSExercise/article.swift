//
//  article.swift
//  iOSExercise
//
//  Copyright © 2018  rawan. All rights reserved.
//

import UIKit
import Foundation


struct InitialArticle: Codable {
    let title: String
    let articles: [Article]
  
}

struct Article : Codable {
   
    let title: String
    let website: String
    let authors: String
    let date: String
    let content: String
    let image_url: String
    let tags: [Tags]

}

struct Tags: Codable {
    let id: Int
    let label: String
    
}
extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
