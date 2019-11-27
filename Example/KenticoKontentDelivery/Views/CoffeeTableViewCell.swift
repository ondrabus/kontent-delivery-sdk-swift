//
//  CoffeeTableViewCell.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 31/08/2017.
//  Copyright © 2017 Kentico Software. All rights reserved.
//

import UIKit

class CoffeeTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var coffeeDescription: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var processing: UILabel!
    @IBOutlet weak var featured: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
