//
//  ShopScene.swift
//  newSeventhGear
//
//  Created by Brown Jawn on 7/8/19.
//  Copyright © 2019 Brown Jawn. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class ShopScene: SKScene {
    var viewController: GameViewController!
    
    let gearPointsLabel = SKLabelNode(text: "Gear Points: " + String(UserDefaults.standard.integer(forKey: "GearPoints")) + " ⚙")
    
    let defaultBackgroundColor = UIColor(red:0.93, green:0.49, blue:0.64, alpha:1.0)
    
    let theme0 = SKLabelNode(text:"Default")
    let theme1 = SKLabelNode(text:"Theme 1")
    let theme2 = SKLabelNode(text:"Theme 2")
    let theme3 = SKLabelNode(text:"Theme 3")
    let theme4 = SKLabelNode(text:"Theme 4")
    
    let theme0Options = SKLabelNode(text:"Use")
    let theme1Options = SKLabelNode(text:"Use")
    let theme2Options = SKLabelNode(text:"Use")
    let theme3Options = SKLabelNode(text:"Use")
    let theme4Options = SKLabelNode(text:"Use")
    
    let theme1Cost = 75
    let theme2Cost = 75
    let theme3Cost = 75
    let theme4Cost = 75
    
    let menuButton = SKLabelNode(text:"Main Menu")
    
    
    func changeScene(){
        let menuScene = MenuScene(size: view!.bounds.size)
        menuScene.viewController = self.viewController
        view!.presentScene(menuScene)
    }
    
    override func didMove(to view: SKView) {
        viewController.currentScene = "shop"
        if UserDefaults.standard.bool(forKey: "theme1Purchased") == false{
            if UserDefaults.standard.integer(forKey: "GearPoints") >= theme1Cost{
                theme1Options.text = "Buy (\(theme1Cost) ⚙)"
            } else {
                theme1Options.text = "\(theme1Cost) ⚙"
            }
        }
        
        if UserDefaults.standard.bool(forKey: "theme2Purchased") == false{
            if UserDefaults.standard.integer(forKey: "GearPoints") >= theme2Cost{
                theme2Options.text = "Buy (\(theme2Cost) ⚙)"
            } else {
                theme2Options.text = "\(theme2Cost) ⚙"
                
            }
        }
        
        if UserDefaults.standard.bool(forKey: "theme3Purchased") == false{
            if UserDefaults.standard.integer(forKey: "GearPoints") >= theme3Cost{
                theme3Options.text = "Buy (\(theme3Cost) ⚙)"
            } else {
                theme3Options.text = "\(theme3Cost) ⚙"
            }
        }
        
        if UserDefaults.standard.bool(forKey: "theme4Purchased") == false{
            if UserDefaults.standard.integer(forKey: "GearPoints") >= theme4Cost{
                theme4Options.text = "Buy (\(theme4Cost) ⚙)"
            } else {
                theme4Options.text = "\(theme4Cost) ⚙"
            }
        }
        
        
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
        
        /* //For debugging
         
         UserDefaults.standard.set(false, forKey: "theme1Purchased")
         UserDefaults.standard.set(false, forKey: "theme2Purchased")
         UserDefaults.standard.set(false, forKey: "theme3Purchased")
         UserDefaults.standard.set(false, forKey: "theme4Purchased")
         */
        
        setUpThemes()
        

    }
    
    func setUpThemes(){
        
        gearPointsLabel.fontSize = 35
        gearPointsLabel.fontName = "AvenirNext-Bold"
        gearPointsLabel.fontColor = UIColor.white
        gearPointsLabel.position = CGPoint(x: frame.midX, y: frame.size.height*0.75)
        
        theme0.fontSize = 30
        theme0.fontName = "AvenirNext-Bold"
        theme0.fontColor = UIColor.white
        theme0.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        theme0.position = CGPoint(x: 10, y: frame.size.height*0.6)
        
        theme1.fontSize = 30
        theme1.fontName = "AvenirNext-Bold"
        theme1.fontColor = UIColor.white
        theme1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        theme1.position = CGPoint(x: 10, y: theme0.position.y - 2*theme0.frame.size.height)
        //White Gears, Black Background
        
        theme2.fontSize = 30
        theme2.fontName = "AvenirNext-Bold"
        theme2.fontColor = UIColor.white
        theme2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        theme2.position = CGPoint(x: 10, y: theme1.position.y - 2*theme1.frame.size.height)
        //
        
        theme3.fontSize = 30
        theme3.fontName = "AvenirNext-Bold"
        theme3.fontColor = UIColor.white
        theme3.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        theme3.position = CGPoint(x: 10, y: theme2.position.y - 2*theme2.frame.size.height)
        //
        
        theme4.fontSize = 30
        theme4.fontName = "AvenirNext-Bold"
        theme4.fontColor = UIColor.white
        theme4.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        theme4.position = CGPoint(x: 10, y: theme3.position.y - 2*theme3.frame.size.height)
        //
        
        theme0Options.fontSize = 30
        theme0Options.fontName = "AvenirNext-Bold"
        theme0Options.fontColor = UIColor.white
        theme0Options.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        theme0Options.position = CGPoint(x: frame.maxX - 10, y: theme0.position.y)
        
        theme1Options.fontSize = 30
        theme1Options.fontName = "AvenirNext-Bold"
        theme1Options.fontColor = UIColor.white
        theme1Options.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        theme1Options.position = CGPoint(x: frame.maxX - 10, y: theme1.position.y)
        
        theme2Options.fontSize = 30
        theme2Options.fontName = "AvenirNext-Bold"
        theme2Options.fontColor = UIColor.white
        theme2Options.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        theme2Options.position = CGPoint(x: frame.maxX - 10, y: theme2.position.y)
        
        theme3Options.fontSize = 30
        theme3Options.fontName = "AvenirNext-Bold"
        theme3Options.fontColor = UIColor.white
        theme3Options.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        theme3Options.position = CGPoint(x: frame.maxX - 10, y: theme3.position.y)
        
        theme4Options.fontSize = 30
        theme4Options.fontName = "AvenirNext-Bold"
        theme4Options.fontColor = UIColor.white
        theme4Options.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        theme4Options.position = CGPoint(x: frame.maxX - 10, y: theme4.position.y)
        
        menuButton.fontSize = 40
        menuButton.fontName = "AvenirNext-Bold"
        menuButton.fontColor = UIColor.white
        menuButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        menuButton.position = CGPoint(x: frame.minX + 10, y: theme4.position.y/2)
        
        addChild(gearPointsLabel)
        addChild(theme0)
        addChild(theme1)
        addChild(theme2)
        addChild(theme3)
        addChild(theme4)
        addChild(theme0Options)
        addChild(theme1Options)
        addChild(theme2Options)
        addChild(theme3Options)
        addChild(theme4Options)
        addChild(menuButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        

        let touch = touches.first!
        let location = touch.location(in: self)
        
        if self.atPoint(location) == theme0Options{
            UserDefaults.standard.set(0, forKey: "Theme")
            changeScene()
        }
        
        if self.atPoint(location) == theme1Options{
            if UserDefaults.standard.bool(forKey: "theme1Purchased"){
                UserDefaults.standard.set(1, forKey: "Theme")
                changeScene()
            } else if UserDefaults.standard.integer(forKey: "GearPoints") >= theme1Cost{
                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "GearPoints") - theme1Cost, forKey: "GearPoints")
                UserDefaults.standard.set(true, forKey: "theme1Purchased")
                UserDefaults.standard.set(1, forKey: "Theme")
                changeScene()
            }
        }
        
        if self.atPoint(location) == theme2Options{
            if UserDefaults.standard.bool(forKey: "theme2Purchased"){
                UserDefaults.standard.set(2, forKey: "Theme")
                changeScene()
            } else if UserDefaults.standard.integer(forKey: "GearPoints") >= theme2Cost{
                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "GearPoints") - theme2Cost, forKey: "GearPoints")
                UserDefaults.standard.set(true, forKey: "theme2Purchased")
                UserDefaults.standard.set(2, forKey: "Theme")
                changeScene()
            }
        }
        
        if self.atPoint(location) == theme3Options{
            if UserDefaults.standard.bool(forKey: "theme3Purchased"){
                UserDefaults.standard.set(3, forKey: "Theme")
                changeScene()
            } else if UserDefaults.standard.integer(forKey: "GearPoints") >= theme3Cost{
                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "GearPoints") - theme3Cost, forKey: "GearPoints")
                UserDefaults.standard.set(true, forKey: "theme3Purchased")
                UserDefaults.standard.set(3, forKey: "Theme")
                changeScene()
            }
        }
        
        if self.atPoint(location) == theme4Options{
            if UserDefaults.standard.bool(forKey: "theme4Purchased"){
                UserDefaults.standard.set(4, forKey: "Theme")
                changeScene()
            } else if UserDefaults.standard.integer(forKey: "GearPoints") >= theme4Cost{
                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "GearPoints") - theme4Cost, forKey: "GearPoints")
                UserDefaults.standard.set(true, forKey: "theme4Purchased")
                UserDefaults.standard.set(4, forKey: "Theme")
                changeScene()
            }
        }
        
        if self.atPoint(location) == menuButton{
            changeScene()
        }
    }
}
