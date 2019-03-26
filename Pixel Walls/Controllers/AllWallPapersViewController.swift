//
//  AllWallPapersViewController.swift
//  Pixel Walls
//
//  Created by Adam Carter on 12/10/17.
//  Copyright © 2017 Adam Carter. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AllWallPapersViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var navTitle:String?
    var wPaper:[WPaper]?
    var bannerView: GADBannerView!
    
    // Use this in debugging environment
    private var testADUnitID = "ca-app-pub-3940256099942544/2934735716"
    
    // Use this in live environment
    private var liveADUnitID = "ca-app-pub-5536113347846727/6212605973"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let wpCellNib = UINib(nibName: "WPCell", bundle: nil)
        collectionView.register(wpCellNib, forCellWithReuseIdentifier: "wpCell")
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = navTitle{
            self.title = navTitle
        }else{
            self.tabBarController?.navigationItem.title = "All Wallpapers"
            wPaper = AppInstance.shared.allWpaper
        }
       initADBanner()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = wPaper?.count{
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wpCell", for: indexPath) as! WPCell
        let object = wPaper?[indexPath.row]
        cell.authorName.text = object?.author
        cell.imageName.text = object?.name
        if let _ = object?.thumbUrl{
            let url = URL(string:object!.thumbUrl!)
            cell.wpImageView.setImageWithUrl(url!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
//        if UI_USER_INTERFACE_IDIOM() == .pad{
//            return CGSize(width: screenSize.size.width/2, height: 300)
//        }else{
//
//        }
         return CGSize(width: screenSize.size.width/2, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = wPaper?[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WallpaperDetailController") as! WallpaperDetailViewController
        vc.wPaper = object
        self.navigationController?.pushViewController(vc, animated: true)
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
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    

}
