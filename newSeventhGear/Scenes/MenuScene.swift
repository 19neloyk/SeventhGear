//
//  MenuScene.swift
//  newSeventhGear
//
//  Created by Brown Jawn on 7/4/19.
//  Copyright © 2019 Brown Jawn. All rights reserved.
//

import UIKit
import SpriteKit


class MenuScene: SKScene {
    var viewController: GameViewController!
    //Initialize logo and labels for use
    
    var logo = SKSpriteNode(imageNamed: "GearDesaturatedCyan")
    let highScoreLabel = SKLabelNode(text: "Highscore: " + "\(UserDefaults.standard.integer(forKey: "Highscore"))")
    let playLabel = SKLabelNode(text: "GO")
    let tutorialLabel = SKLabelNode(text: "" )
    let storeLabel = SKLabelNode(text: "Theme Store")
    let defaultBackgroundColor = UIColor(red:0.93, green:0.49, blue:0.64, alpha:1.0)
    
    
    
    override func didMove(to view: SKView) {
      //  refreshPointsAndHighscore()
        viewController!.gameScene = nil
        if UserDefaults.standard.integer(forKey: "Theme") == 0{
            backgroundColor = defaultBackgroundColor
        } else if UserDefaults.standard.integer(forKey: "Theme") == 1{
            backgroundColor = UIColor(red:216/255, green:151/255, blue:61/255, alpha:1.0)
        } else if UserDefaults.standard.integer(forKey: "Theme") == 2{
            backgroundColor = UIColor(red:52/255, green:90/255, blue:149/255, alpha:1.0)
        } else if UserDefaults.standard.integer(forKey: "Theme") == 3{
            backgroundColor = UIColor(red:0.70, green:0.74, blue:0.69, alpha:1.0)
        } else if UserDefaults.standard.integer(forKey: "Theme") == 4{
            backgroundColor = UIColor.black

        }
        
        addLogo()
        addLabels()
        
    }
    
    func addLogo(){
        if UserDefaults.standard.integer(forKey: "Theme") == 1 {
            logo = SKSpriteNode(imageNamed: "Gear3-1")
        } else if UserDefaults.standard.integer(forKey: "Theme") == 2 {
            logo = SKSpriteNode(imageNamed: "Gear2-1")
        } else if UserDefaults.standard.integer(forKey: "Theme") == 3 {
            logo = SKSpriteNode(imageNamed: "GearOnyx")
        } else if UserDefaults.standard.integer(forKey: "Theme") == 4 {
            logo = SKSpriteNode(imageNamed: "GearWhite")
        }
        logo.size = CGSize(width:frame.size.width/1.5, height:frame.size.width/1.5)
        logo.position = CGPoint(x: frame.midX,y: frame.midY * 1.25)
        let oneRevolution: SKAction = SKAction.rotate(byAngle: CGFloat(2.5), duration: 1) //Make float an accurate 2pi representation
        let repeatRotation: SKAction = SKAction.repeatForever(oneRevolution)
        logo.run(repeatRotation)
        addChild(logo)
    }
    
    
    func addLabels(){
        playLabel.fontSize = 70
        playLabel.fontName = "AvenirNext-Bold"
        if UserDefaults.standard.integer(forKey: "Theme") == 4 {
            playLabel.fontColor = SKColor.black
        } else {
            playLabel.fontColor = SKColor.white
        }
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY * 1.25 - 25)
        playLabel.zPosition = 1
        
        highScoreLabel.fontSize = 30
        highScoreLabel.fontName = "AvenirNext-Bold"
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height * 3)
        
        let highestMode: String
        let highScore =  UserDefaults.standard.integer(forKey: "Highscore")
        let modeColor:UIColor
        modeColor = UIColor.white
        if highScore < 7 {
            highestMode = "walker"
         //   modeColor = UIColor.yellow
        } else if highScore < 14 {
            highestMode = "jogger"
         //   modeColor = UIColor.green
        } else if highScore < 21 {
            highestMode = "biker"
          //  modeColor = UIColor.gray
        } else if highScore < 28 {
            highestMode = "trucker"
         //   modeColor = UIColor.blue
        } else if highScore < 35 {
            highestMode = "cruiser"
          //  modeColor = UIColor.orange
        } else if highScore < 42 {
            highestMode = "speeder"
          //  modeColor = UIColor.purple
        }else if highScore < 49 {
            highestMode = "racer"
         //   modeColor = UIColor.green
        } else if highScore < 56 {
            highestMode = "drifter"
        } else if highScore < 63 {
            highestMode = "blaster"
        } else if highScore < 70 {
            highestMode = "zoomer"
        } else {
            highestMode = "beamer"
        }
        highScoreLabel.text = "Highscore: " + "\(UserDefaults.standard.integer(forKey: "Highscore"))" + " (" + highestMode + ")"
        highScoreLabel.fontColor = modeColor
        
        tutorialLabel.fontSize = 30
        tutorialLabel.fontName = "AvenirNext-Bold"
        tutorialLabel.fontColor = modeColor
        tutorialLabel.position = CGPoint(x: frame.midX, y: highScoreLabel.position.y - 2*(highScoreLabel.frame.size.height))
        tutorialLabel.text = "Gear Points: " + String(UserDefaults.standard.integer(forKey: "GearPoints")) + " ⚙"
        
        storeLabel.fontSize = 40
        storeLabel.fontName = "AvenirNext-Bold"
        storeLabel.fontColor = UIColor.white
        storeLabel.position = CGPoint(x: frame.midX, y: tutorialLabel.position.y - 2*tutorialLabel.frame.size.height)
        
        addChild(playLabel)
        addChild(highScoreLabel)
        addChild(storeLabel)
        addChild(tutorialLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch = touches.first!
        let location = touch.location(in: self)
        if self.atPoint(location) == logo || self.atPoint(location) == playLabel{
            let gameScene = GameScene(size: view!.bounds.size)
            gameScene.viewController = self.viewController
            view!.presentScene(gameScene)
        } else if self.atPoint(location) == storeLabel{
            let shopScene = ShopScene(size: view!.bounds.size)
            shopScene.viewController = self.viewController
            view!.presentScene(shopScene)
        }
    }
    
    //Refreshing these attributes for the sake of testing
    func refreshPointsAndHighscore () {
        UserDefaults.standard.set(0, forKey: "Highscore")
        UserDefaults.standard.set(0, forKey: "GearPoints")
    }
    
    
}
