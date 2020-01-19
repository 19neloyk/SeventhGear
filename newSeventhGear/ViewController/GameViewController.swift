//
//  GameViewController.swift
//  newSeventhGear
//
//  Created by Brown Jawn on 6/25/19.
//  Copyright © 2019 Brown Jawn. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleMobileAds

class GameViewController: UIViewController {
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var gameScenePresent: GameScene?
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910") //production id: ca-app-pub-4955915426675862/2924970725
        interstitial.delegate = self as? GADInterstitialDelegate
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    func presentMenuScene(){
        if let view = self.view as! SKView?{
            let menuScene = MenuScene(size: view.bounds.size)
            menuScene.viewController = self
            menuScene.scaleMode = .aspectFill
            view.presentScene(menuScene)
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToViewTop(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" //production id: ca-app-pub-4955915426675862/8971504320
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
     
        interstitial = createAndLoadInterstitial()
        


        presentMenuScene()
        if let view = self.view as! SKView? {
            
        /*
            // Load the SKScene from 'GameScene.sks'
            let menuScene = MenuScene(size: view.bounds.size)
            
            // Set the scale mode to scale to fit the window
            menuScene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(menuScene)
        */
           
            view.ignoresSiblingOrder = true
            
            //view.showsFPS = true
            //view.showsNodeCount = true
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
    }
    @objc func appMovedToBackground() {
        print("Moved to background")
        if gameScenePresent != nil {
            gameScenePresent!.returningFromInactiveState = true
        }
    }

    func addBannerViewToViewTop(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .top,
                                relatedBy: .equal,
                                toItem: view.safeAreaLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    /*
    func addBannerViewToViewBottom(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    } */
}
