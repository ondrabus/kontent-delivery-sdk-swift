//
//  CafeCellTableViewCell.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 16/08/2017.
//  Copyright © 2017 Kentico Software. All rights reserved..
//

import UIKit

class CafeTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var cafeTitle: UILabel!
    @IBOutlet weak var cafeSubtitle: UILabel!
    @IBOutlet weak var photo: UIImageView!

    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
