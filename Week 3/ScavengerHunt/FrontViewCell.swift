//
//  FrontViewCell.swift
//  AmericanKitchen
//
//  Created by Salman on 06/05/2017.
//  Copyright © 2017 Salman. All rights reserved.
//

import UIKit

class FrontViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
