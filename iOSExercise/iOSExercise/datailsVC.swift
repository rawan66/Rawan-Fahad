//
//  datailsVC.swift
//  iOSExercise
//

//  Copyright © 2018  rawan. All rights reserved.
//

import UIKit

class datailsVC: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var articleImg: UIImageView!
   
var article:Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        titleLbl.text = article?.title
        detailsLbl.text = article?.content
        
        if let url = URL(string: (article?.image_url)!) {

        downloadImage(from: url)

        }
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Downloaddd")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Finishedddd")
           
            DispatchQueue.main.async() {
                self.progress.stopAnimating()
               // self.progress.hidesWhenStopped = true
                self.articleImg.image = UIImage(data: data)
            }
        }
    }
    
}
    



