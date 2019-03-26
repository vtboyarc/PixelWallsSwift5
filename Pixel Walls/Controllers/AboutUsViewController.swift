//
//  AboutUsViewController.swift
//  Pixel Walls
//
//  Created by Adam Carter on 12/10/17.
//  Copyright © 2017 Adam Carter. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AboutUsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,AboutUsProtocol {
    
    var bannerView: GADBannerView!
    
    // Use this in debugging environment
    private var testADUnitID = "ca-app-pub-3940256099942544/2934735716"
    
    // Use this in live environment
    private var liveADUnitID = "ca-app-pub-5536113347846727/6212605973"

    @IBOutlet weak var tableView: UITableView!
    var aboutCreators = [Creator]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let adam_creator = Creator()
        adam_creator.name = "Adam Carter"
        adam_creator._description = "Software Developer | Photographer | Runner | Music Lover"
        adam_creator.twitterUrl = "https://twitter.com/adamcarter"
        //this way allows to open in the app
        // need to add a check to make sure user has the twitter app, because if not, won't open
        //adam_creator.twitterUrl = "twitter:///user?screen_name=adamcarter"

        adam_creator.imageName = #imageLiteral(resourceName: "first_profile")
        adam_creator.headerImage = #imageLiteral(resourceName: "first_about_header")
        aboutCreators.append(adam_creator)
        
        let anil_creator = Creator()
        anil_creator.name = "Anil kumar"
        anil_creator._description = "Graphic designer | Tech addict | Mechanical Engineer | Kannadiga | Indian"
        anil_creator.twitterUrl = "https://twitter.com/akinhd"
        anil_creator.imageName = #imageLiteral(resourceName: "second_profile")
        anil_creator.headerImage = #imageLiteral(resourceName: "second_about_header")
        aboutCreators.append(anil_creator)
        
        let aboutNib = UINib(nibName: "AboutUsCell", bundle: nil)
        tableView.register(aboutNib, forCellReuseIdentifier: "aboutUsCell")
        tableView.backgroundColor = .black
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "About Us"
        initADBanner()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutCreators.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aboutUsCell", for: indexPath) as! AboutUsCell
        let object = aboutCreators[indexPath.row]
        cell.profileName.text = object.name
        cell.profileDescription.text = object._description
        cell.profileImage.image = object.imageName
        cell.profileHeader.image = object.headerImage
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    func didTapOnTwitter(cell: AboutUsCell) {
        let index = tableView.indexPath(for: cell)
        let object = aboutCreators[index!.row]
        _ = URL(string:object.twitterUrl!)
        if let url = URL(string:object.twitterUrl!) {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        }
        //older swift version, new way above seems to work
         //let url = URL(string:object.twitterUrl!)
//        if UIApplication.shared.canOpenURL(url!){
//            UIApplication.shared.openURL(url!)
//        }
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

class Creator:NSObject{
    var name:String?
    var _description:String?
    var twitterUrl:String?
    var imageName:UIImage?
    var headerImage:UIImage?
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
