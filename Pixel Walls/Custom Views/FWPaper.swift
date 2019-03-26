//
//  FWPaper.swift
//  Pixel Walls
//
//  Created by Adam Carter on 12/10/17.
//  Copyright © 2017 Adam Carter. All rights reserved.
//

import UIKit
protocol FWPaperProtocol{
    func didTapOnSaveImageToGallery(imageView:UIImageView)
    //commented out for set as wallpaper
    //to use in future, need to add back button for it in FWPaper.xib
    // add some constraints as other button, except set to the below function for touch up insisde segue
    //func didTapOnSetWallPaper()
}

class FWPaper: UIView {

    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var wpImageView: UIImageView!
    
    var delegate:FWPaperProtocol? = nil
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //commented out for set as wallpaper
//    @IBAction func didTapOnSetWallpaper(_ sender: Any) {
//        if let _ = delegate{
//            delegate?.didTapOnSetWallPaper()
//        }
//    }
    @IBAction func didTapOnSaveImage(_ sender: Any) {
        //add interstital ad here, this method gets fired when save button is clicked
        
        if let _ = delegate{
            delegate?.didTapOnSaveImageToGallery(imageView: wpImageView)
        }
    }
    
    class func loadView() -> FWPaper{
        let fwPaper =  Bundle.main.loadNibNamed("FWPaper", owner: self, options: nil)?.first as! FWPaper
        return fwPaper
    }
}
