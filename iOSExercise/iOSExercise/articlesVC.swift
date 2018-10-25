//
//  articlesVC.swift
//  iOSExercise
//
//  
//  Copyright © 2018  rawan. All rights reserved.
//

import UIKit

class articlesVC: UIViewController,UITableViewDelegate , UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let cellId = "articleCell"
    var articles:[Article]?
    var refreshControl: UIRefreshControl!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloudJOS()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.addSubview(refreshControl)    }
    
    ////////josn
    func downloudJOS(){
        let urlString = "https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise"
        guard let gitUrl = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else {
                print("something is wrong!!!!")
                return }
            do {
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(InitialArticle.self, from: data)
                
                DispatchQueue.main.async {
                   self.navigationItem.title = gitData.title
                    self.articles = gitData.articles
                    self.tableView?.reloadData()
                    
                }
                
            } catch let err {
                print("errorrrr", err)
            }
            }.resume()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: articleCell! = tableView.dequeueReusableCell(withIdentifier: cellId) as? articleCell
        if cell == nil {
           tableView.register(UINib(nibName: "articleCell", bundle: nil), forCellReuseIdentifier: cellId)
            cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? articleCell
            
        }
         cell.article = articles?[indexPath.item]

       return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = datailsVC(nibName: "datailsVC", bundle: nil)
        vc.article = articles?[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    

    @objc func refresh(_ sender: Any) {
        let urlString = "https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise"
       guard let gitUrl = URL(string: urlString) else { return }
       URLSession.shared.dataTask(with: gitUrl) { (data, response
           , error) in
           guard let data = data else { return }
           do {
              let decoder = JSONDecoder()
               let gitData = try decoder.decode(InitialArticle.self, from: data)
                
              DispatchQueue.main.async {
                    self.navigationItem.title = gitData.title
                    self.articles = gitData.articles
                   self.tableView?.reloadData()
                    self.refreshControl.endRefreshing()

            }
                
           } catch let err {
               print("Err", err)
        }
      
        }.resume()
  }
}

