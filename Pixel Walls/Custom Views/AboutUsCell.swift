//
//  AboutUsCell.swift
//  Pixel Walls
//
//  Created by Adam Carter on 12/10/17.
//  Copyright © 2017 Adam Carter. All rights reserved.
//

import UIKit
protocol AboutUsProtocol{
    func didTapOnTwitter(cell:AboutUsCell)
}
class AboutUsCell: UITableViewCell {

    @IBOutlet weak var profileHeader: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileDescription: UILabel!
    
    var delegate:AboutUsProtocol? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.layer.masksToBounds = true
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.borderWidth = 1.0
    }

    @IBAction func didTapOnTwitter(_ sender: Any) {
        if let _ = delegate{
            delegate?.didTapOnTwitter(cell: self)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
