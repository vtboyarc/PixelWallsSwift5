//
//  AppInstance.swift
//  Pixel Walls
//
//  Created by Adam Carter on 12/10/17.
//  Copyright © 2017 Adam Carter. All rights reserved.
//

import Foundation
import SVProgressHUD
import Photos

class AppInstance:NSObject{
    static let shared =  AppInstance()
    var wpDay:WPaper?
    var allWpaper = [WPaper]()
    var categories:[Category]?
}

extension UIViewController: FWPaperProtocol{
    
    func showProgress(_ message: String?) {
        if let msg = message {
            SVProgressHUD.show(withStatus: msg)
        } else {
            SVProgressHUD.show()
        }
    }
    
    func hideProgress() {
        SVProgressHUD.dismiss()
    }
    
    
    func showAlert(_ target: UIViewController, message: String?, title: String?, buttonTitle: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: buttonTitle, style: .default) { (action) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        target.present(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.black
    }
    func didTapOnSaveImageToGallery(imageView:UIImageView){
        if let image = imageView.image{
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status{
                case .authorized:
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAsset(from: image)
                    }) { (success, error) in
                        if success{
                            self.showAlert(self, message: "Image Saved Successfully", title: "Success", buttonTitle: "Ok")
                            return
                        }else{
                            self.showAlert(self, message: "Something went wrong!", title: "Error", buttonTitle: "Ok")
                        }
                    }
                case .denied,.notDetermined,.restricted:self.showAlert(self, message: "Need Access To Photos. Check Privacy Settings", title: "Error", buttonTitle: "Ok")
                }
            }
        }
    }
    //commented out for set as wallpaper
//    func didTapOnSetWallPaper() {
//        let url = URL(string:"App-Prefs:root=Wallpaper")
//        if UIApplication.shared.canOpenURL(url!){
//            UIApplication.shared.openURL(url!)
//        }else{
//            print("error")
//        }
//    }
}
