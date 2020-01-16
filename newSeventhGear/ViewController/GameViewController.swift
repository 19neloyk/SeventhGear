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
    var gameScene:GameScene?
    var lastScore:Double?
    var lastLeftGear:SKSpriteNode?
    var lastRightGear:SKSpriteNode?
    var sceneActive:Bool?
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-4955915426675862/2924970725") //production id: ca-app-pub-4955915426675862/2924970725
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
        bannerView.adUnitID = "ca-app-pub-4955915426675862/8971504320" //production id: ca-app-pub-4955915426675862/8971504320
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
     
        interstitial = createAndLoadInterstitial()
        
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)

        
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
    
    @objc func willResignActive(_ notification: Notification) {
        if gameScene != nil{
            lastScore = gameScene?.score
        }
    }
    
    @objc func didBecomeActive(_ notification: Notification) {
        if gameScene != nil{
            
            if let view = self.view as! SKView?{
                let newGameScene = GameScene(size: view.bounds.size)
                newGameScene.viewController = self
                view.presentScene(newGameScene)
                
            }
        }
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
