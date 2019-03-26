//
//  CategoryCell.swift
//  Pixel Walls
//
//  Created by Adam Carter on 12/10/17.
//  Copyright © 2017 Adam Carter. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var wpImageView: UIImageView!
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var authorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
