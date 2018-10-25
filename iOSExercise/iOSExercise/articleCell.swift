//
//  articleCell.swift
//  iOSExercise

//  Copyright © 2018  rawan. All rights reserved.
//

import UIKit

class articleCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var articleImg: UIImageView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func awakeFromNib() {
       super.awakeFromNib()

    }
    var article:Article? {
       didSet {
         titleLbl.text = article?.title
           detailsLbl.text = article?.content
           articleImg.downloadImageFrom(link: (article?.image_url)!, contentMode: UIViewContentMode.scaleAspectFit)
            
       }
    }
}
