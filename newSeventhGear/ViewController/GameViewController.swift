//
//  GameViewController.swift
//  newSeventhGear
//
//  Created by Brown Jawn on 6/25/19.
//  Copyright © 2019 Brown Jawn. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    func presentMenuScene(){
        if let view = self.view as! SKView?{
            let menuScene = MenuScene(size: view.bounds.size)
            menuScene.viewController = self
            menuScene.scaleMode = .aspectFill
            view.presentScene(menuScene)

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        


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
            
          //  view.showsFPS = true
          //  view.showsNodeCount = true
        }
    }

}
