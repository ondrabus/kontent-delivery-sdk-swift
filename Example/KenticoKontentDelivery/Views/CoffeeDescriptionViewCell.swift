//
//  CoffeeDescriptionCell.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 26/09/2017.
//  Copyright © 2017 Kentico Software. All rights reserved.
//

import UIKit

class CoffeeDescriptionViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var coffeeDescription: UILabel!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
