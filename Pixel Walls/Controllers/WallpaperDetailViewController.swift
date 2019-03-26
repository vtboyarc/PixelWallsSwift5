//
//  WallpaperDetailViewController.swift
//  Pixel Walls
//
//  Created by Adam Carter on 12/10/17.
//  Copyright © 2017 Adam Carter. All rights reserved.
//

import UIKit
import GoogleMobileAds

class WallpaperDetailViewController: UIViewController {
    
    var bannerView: GADBannerView!
    
    // Use this in debugging environment
    private var testADUnitID = "ca-app-pub-3940256099942544/2934735716"
    
    // Use this in live environment
    private var liveADUnitID = "ca-app-pub-5536113347846727/6212605973"
    
    var wPaper:WPaper?
    var fwPaper:FWPaper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fwPaper = FWPaper.loadView()
        fwPaper.frame = self.view.frame
        fwPaper.backgroundColor = .black
        fwPaper.delegate = self
        self.view.addSubview(fwPaper)
        let url = URL(string: wPaper!.url!)
        fwPaper.wpImageView.setImageWithUrl(url!)
        //the below line is for showing the title in the full screen view
        //self.title = wPaper?.name
        fwPaper.imageName.text = wPaper?.name
        fwPaper.authorName.text = wPaper?.author
        initADBanner()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
