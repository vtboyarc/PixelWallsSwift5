//
//  ViewController.swift
//  Pixel Walls
//
//  Created by Adam Carter on 12/10/17.
//  Copyright © 2017 Adam Carter. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMobileAds

class ViewController: UIViewController {
    
    var fwPaper:FWPaper!
    let appInstance  = AppInstance.shared
    
    //    @IBOutlet var bannerView: GADBannerView!
    @objc var bannerView: GADBannerView!
    
    //var bannerView: GADBannerView!
    // Use this in debugging environment
    private var testADUnitID = "ca-app-pub-3940256099942544/2934735716"
    
    // Use this in live environment
    private var liveADUnitID = "ca-app-pub-5536113347846727/6212605973"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.isViewLoaded {
            fwPaper =  FWPaper.loadView()
            fwPaper.frame = self.view.frame
            fwPaper.delegate = self
            self.view.addSubview(fwPaper)
            
            showProgress(nil)
            let wallPaperOfDayURL = "https://www.dropbox.com/s/1w8qz3su8hyc57y/wod%20ios.json?dl=1"
            Alamofire.request(wallPaperOfDayURL).responseJSON { (response) in
                self.hideProgress()
                if let error = response.result.error{
                    self.showAlert(self, message: error.localizedDescription, title: "Error", buttonTitle: "Ok")
                }else{
                    let response = response.result.value as? [String:Any]
                    if let wpaperObject = response!["Wallpaper of the day"] as? NSArray{
                        let response = wpaperObject.firstObject as? [String:Any]
                        let wpaper = WPaper.handleResponse(responseObject: response)
                        self.appInstance.wpDay = wpaper
                        let url = URL(string: wpaper.url!)
                        self.fwPaper.wpImageView.setImageWithUrl(url!)
                        self.fwPaper.authorName.text = wpaper.author
                        self.fwPaper.imageName.text = wpaper.name
                    }
                }
            }
            showProgress(nil)
            let allWallpapersURL = "https://www.dropbox.com/s/hd27oz8zc1ad8u6/ios%20version.json?dl=1"
            Alamofire.request(allWallpapersURL).responseJSON { (response) in
                self.hideProgress()
                if let error = response.result.error{
                    self.showAlert(self, message: error.localizedDescription, title: "Error", buttonTitle: "Ok")
                }else{
                    let response = response.result.value
                    self.appInstance.categories = Category.handleResponse(response: response!)
                    if let response = response as? [String:Any] {
                        if let wallpapers = response["Wallpapers"] as? NSArray {
                            
                            for wallpaper in wallpapers{
                                let wallpaper = wallpaper as? [String:Any]
                                let object = WPaper.handleResponse(responseObject: wallpaper!)
                                self.appInstance.allWpaper.append(object)
                            }
                        }
                    }
                }
            }
            
        }
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Wallpaper of the Week"
        initADBanner()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Admob
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
    
    
    func initADBanner() {
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToView(bannerView)
        
        // change this to the liveADUnitID before building for app store!
        bannerView.adUnitID = liveADUnitID
        bannerView.rootViewController = self
        
        let theRequest = GADRequest()
        theRequest.testDevices = [kGADSimulatorID]
        bannerView.load(theRequest)
        
        //        bannerView.delegate = self as GADBannerViewDelegate
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .top,
                                relatedBy: .equal,
                                toItem: topLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
}

