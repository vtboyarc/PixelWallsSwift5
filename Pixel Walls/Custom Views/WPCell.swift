//
//  WPCell.swift
//  Pixel Walls
//
//  Created by Adam Carter on 12/10/17.
//  Copyright © 2017 Adam Carter. All rights reserved.
//

import UIKit

class WPCell: UICollectionViewCell {
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var wpImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
}
