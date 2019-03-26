//
//  CategoriesViewController.swift
//  Pixel Walls
//
//  Created by Adam Carter on 12/10/17.
//  Copyright © 2017 Adam Carter. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CategoriesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var bannerView: GADBannerView!
    
    // Use this in debugging environment
    private var testADUnitID = "ca-app-pub-3940256099942544/2934735716"
    
    // Use this in live environment
    private var liveADUnitID = "ca-app-pub-5536113347846727/6212605973"
    
    @IBOutlet weak var tableView: UITableView!
    let appInstance = AppInstance.shared
    var category = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let categoryNib = UINib(nibName: "CategoryCell", bundle: nil)
        tableView.register(categoryNib, forCellReuseIdentifier: "categoryCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Categories"
        for category in appInstance.categories!{
            let object = appInstance.allWpaper.filter({$0.category == category.name})
            category.wpaper = object
            category.count = object.count
            category.thumbUrl = object.first?.thumbUrl
        }
       initADBanner()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = appInstance.categories?.count{
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        let object = appInstance.categories?[indexPath.row]
        cell.authorName.text = "\(String(describing: object!.count)) Wallpapers"
        cell.imageName.text = object?.name
        if let _ = object?.thumbUrl{
            let url = URL(string:object!.thumbUrl!)
            cell.wpImageView.setImageWithUrl(url!)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = appInstance.categories?[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllWallPapersController") as! AllWallPapersViewController
        vc.wPaper = object?.wpaper
        vc.navTitle =  object?.name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    


}
