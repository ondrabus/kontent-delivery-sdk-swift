//
//  ArticleTableViewCell.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 17/08/2017.
//  Copyright © 2017 Kentico Software. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var date: UILabel!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
