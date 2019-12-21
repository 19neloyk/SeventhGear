//
//  GameScene.swift
//  newSeventhGear
//
//  Created by Brown Jawn on 6/25/19.
//  Copyright © 2019 Brown Jawn. All rights reserved.
//


import SpriteKit
import UIKit
import Foundation
import GoogleMobileAds

class GameScene: SKScene {
	var viewController: GameViewController!
	
	
	//Gear Image Color Test
	var maroonGear = SKSpriteNode(imageNamed:"GearGrannySmithApple")
	var blueGear = SKSpriteNode(imageNamed:"GearBurlyWood")
	var greenGear = SKSpriteNode(imageNamed:"GearDesaturatedCyan")
	var pinkGear = SKSpriteNode(imageNamed:"GearPaleAqua")
	
	//Default Background Color
	let defaultBackgroundColor = UIColor(red:0.93, green:0.49, blue:0.64, alpha:1.0)
	
    //Gears on the screen
    var leftGear: SKSpriteNode!
    var rightGear: SKSpriteNode!
	
	//color for each gear
	var leftGearColor: UIColor?
	var rightGearColor: UIColor?
	
	//Holder for Right Gear (Used in reference by Left Gear)
	var rightGearHolder : SKSpriteNode?
	
    //Score Label
    var score = 0.0
    let scoreLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    
    //Teeth pointing Out Label
    let teethLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
	
	//Instruction Label
	let nteethLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
	var instructionTimer: Timer?
	
	//Working with setting time
	var isTimeSet = false
	var referenceTime: Double?

	//Starting direction of leftGear; false is clockwise, true is counter clockwise
    var leftGearDirection = false
    
    //Starting Speed Factor, default is 0.2
    var speedFactor = 0.2
	
	
    //Generate Speed for Iteration
    func generateSpeed()->Double{
		let limit = 0.5
        let baseSpeed = (limit * pow(0.1, 1/(score+2)))
        let variation = arc4random_uniform(3)
        if variation == 1{
            return baseSpeed * 0.96
        } else if variation == 2{
            return baseSpeed * 1.04
        } else{
            return baseSpeed
        }
        
    }
    
    
    //Random Gear Generators
    func randomLeftGearGenerator() -> SKSpriteNode{
        let randomNumber = arc4random_uniform(4)
		var leftGearHolder: SKSpriteNode?
        print(randomNumber)
        if (randomNumber == 1){
            print("maroon")
			leftGearHolder = maroonGear.copy() as? SKSpriteNode
			return leftGearHolder?.copy() as! SKSpriteNode;
        } else if (randomNumber == 2){
            print("blue")
			leftGearHolder = blueGear.copy() as? SKSpriteNode
			return leftGearHolder?.copy() as! SKSpriteNode;
        } else if (randomNumber == 3){
            print("green")
			leftGearHolder = greenGear.copy() as? SKSpriteNode
			return leftGearHolder?.copy() as! SKSpriteNode;
        } else{
            print("pink")
			leftGearHolder = pinkGear.copy() as? SKSpriteNode
			return leftGearHolder?.copy() as! SKSpriteNode;
        }
    }
	
	func randomRightGearGenerator() -> SKSpriteNode{
		let randomNumber = arc4random_uniform(4)
		print(randomNumber)
		if (randomNumber == 1){
			print("maroon")
			rightGearHolder = maroonGear.copy() as? SKSpriteNode
			return rightGearHolder?.copy() as! SKSpriteNode;
		} else if (randomNumber == 2){
			print("blue")
			rightGearHolder = blueGear.copy() as? SKSpriteNode
			return rightGearHolder?.copy() as! SKSpriteNode;
		} else if (randomNumber == 3){
			print("green")
			rightGearHolder = greenGear.copy() as? SKSpriteNode
			return rightGearHolder?.copy() as! SKSpriteNode;
		} else{
			print("pink")
			rightGearHolder = pinkGear.copy() as? SKSpriteNode
			return rightGearHolder?.copy() as! SKSpriteNode;
		}
	}
	
    //Rotate Gear Indefinitely
    func rotateGearIndefinitely(gear: SKSpriteNode , positive: Bool, speedFactor: Double){
        var x:Double = 1.000;
        if positive == false{
            x = -1.000
        }
        let oneRevolution: SKAction = SKAction.rotate(byAngle: CGFloat(6.2831853 * x * speedFactor), duration: 1) //Make float an accurate 2pi representation
        let repeatRotation: SKAction = SKAction.repeatForever(oneRevolution)
        gear.run(repeatRotation)

    }
    
    //Check if left gear tooth is out
	func isToothOut(speedFactor: Double, timeInMilliseconds: Double) -> Bool{
        let msPerTeethAndInsert = ((1/speedFactor) * 1000) / 8
        let teethAndInsertsPassed = Double(timeInMilliseconds) / (msPerTeethAndInsert)
        let passedModOne = teethAndInsertsPassed.truncatingRemainder(dividingBy: 1.00)
        if passedModOne < 0.70 && passedModOne > 0.35{
            return false
        }else{
            return true
        }
    }

    func layoutScene(){
		if UserDefaults.standard.integer(forKey: "Theme") == 0{
			backgroundColor = defaultBackgroundColor
		} else if UserDefaults.standard.integer(forKey: "Theme") == 1{
			backgroundColor = UIColor.black
			maroonGear = SKSpriteNode(imageNamed: "GearWhite")
			blueGear = SKSpriteNode(imageNamed: "GearWhite")
			greenGear = SKSpriteNode(imageNamed: "GearWhite")
			pinkGear = SKSpriteNode(imageNamed: "GearWhite")
			
		} else if UserDefaults.standard.integer(forKey: "Theme") == 2{
			backgroundColor = UIColor(red:0.36, green:0.75, blue:0.92, alpha:1.0)
			maroonGear = SKSpriteNode(imageNamed: "GearSaffron")
			blueGear = SKSpriteNode(imageNamed: "GearStarCommandBlue")
			greenGear = SKSpriteNode(imageNamed: "GearRoseRed")
			pinkGear = SKSpriteNode(imageNamed: "GearCarribeanGreen")
			
		} else if UserDefaults.standard.integer(forKey: "Theme") == 3{
			backgroundColor =  UIColor(red:1.00, green:0.87, blue:0.63, alpha:1.0)
			maroonGear = SKSpriteNode(imageNamed: "GearPrussianBlue")
			blueGear = SKSpriteNode(imageNamed: "GearRed(Pigment)")
			greenGear = SKSpriteNode(imageNamed: "GearMangoTango")
			pinkGear = SKSpriteNode(imageNamed: "GearBottleGreen")
			
		} else if UserDefaults.standard.integer(forKey: "Theme") == 4{
			backgroundColor = UIColor(red:0.70, green:0.74, blue:0.69, alpha:1.0)
			maroonGear = SKSpriteNode(imageNamed: "GearBananaYellow")
			blueGear = SKSpriteNode(imageNamed: "GearSapphire")
			greenGear = SKSpriteNode(imageNamed: "GearOnyx")
			pinkGear = SKSpriteNode(imageNamed: "GearRed-Orange")
			
		}
		
		//Initialize Gears
        leftGear = randomLeftGearGenerator()
        rightGear = randomRightGearGenerator()
        leftGear.size = CGSize(width:frame.size.width/1.5, height:frame.size.width/1.5)
        print(leftGear.size)
        rightGear.size = leftGear.size
        leftGear.position = CGPoint(x: 0, y: frame.size.width/6)
        rightGear.position = CGPoint(x: frame.size.width, y: frame.size.width/6)

        //Initialize Score Label
        scoreLabel.text = "SCORE"
        scoreLabel.fontSize = 80
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
		
		//Initialize Teeth Label
        teethLabel.fontSize = 20
        teethLabel.fontColor = SKColor.red
        teethLabel.position = CGPoint(x: frame.midX, y: frame.midY - 40)
        teethLabel.text = "TEETH LABEL"
		
		//Initialize Intruction Label and Timer (including fading in/out animation)
		nteethLabel.fontSize = 25
		nteethLabel.fontColor = SKColor.white
		nteethLabel.position = CGPoint(x: frame.midX, y: rightGear.position.y + frame.size.width/2)
		nteethLabel.text = "connect right gear to left gear"
		
		let instructionTimeInterval = 2
		nteethLabel.run(SKAction.fadeOut(withDuration: TimeInterval(instructionTimeInterval/2)))
		Timer.scheduledTimer(withTimeInterval: TimeInterval(instructionTimeInterval/2), repeats: false, block: {_ in
			self.nteethLabel.run(SKAction.fadeIn(withDuration: TimeInterval(instructionTimeInterval/2)))
		})
		self.instructionTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(instructionTimeInterval), repeats: true, block: {_ in
			self.nteethLabel.run(SKAction.fadeOut(withDuration: TimeInterval(instructionTimeInterval/2)))
			Timer.scheduledTimer(withTimeInterval: TimeInterval(instructionTimeInterval/2), repeats: false, block: {_ in
				self.nteethLabel.run(SKAction.fadeIn(withDuration: TimeInterval(instructionTimeInterval/2)))
			})
		})
 
        addChild(leftGear)
        addChild(rightGear)
        addChild(scoreLabel)
     // addChild(teethLabel) (FOR DEBUGGING TIME MOD GEAR INSERTS)
	 	addChild(nteethLabel) // (FOR DEBUGGING WHEN TEETH ARE STICKING OUT)
 
        rightGear.run(SKAction.rotate(byAngle: CGFloat(6.2831853/16), duration: 0.01))
        leftGear.run(SKAction.rotate(byAngle: CGFloat(6.2831853/16), duration: 0.01))
		rotateGearIndefinitely(gear: leftGear, positive: leftGearDirection, speedFactor: speedFactor)
        //Timer for Testing
    }
    
    
    override func didMove(to view: SKView) {
		
        layoutScene()
        }
    
    var touchedNode : SKNode?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        print(location)
        if self.atPoint(location) == rightGear{
            touchedNode = self.atPoint(location)
        }
    }
    //Location of Left Gear insertion
    //var insertionLocation = 0.85 * (frame.size.width/1.5)
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		let insertionLocation = 0.93 * (frame.size.width/1.5)
        if touchedNode != nil{
            let touch = touches.first!
            let location = touch.location(in: self)
            let oldNodeLocation = touchedNode?.position
            let previousPosition = touch.previousLocation(in: self)
            let xTranslation = CGPoint(x: location.x - previousPosition.x, y: 0)
            if (touchedNode?.position.x)! >= insertionLocation{
				if nteethLabel.parent != nil {
					nteethLabel.removeAllActions()
					nteethLabel.removeFromParent()
					instructionTimer?.invalidate()
				}
				let futureNodeLocation = xTranslation.x + oldNodeLocation!.x
														// frame.size.width
                if !(futureNodeLocation >= frame.size.width) && (inProcessOfUpdating == false){
					if (futureNodeLocation <= insertionLocation) {
						rightGear.position.x = insertionLocation
					} else{
						touchedNode?.position = CGPoint(x: xTranslation.x + oldNodeLocation!.x, y: oldNodeLocation!.y)
					}
					print("Location of Right Gear is... " + String(Double(rightGear.position.x)))
                }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchedNode = nil
    }
	
	override func update(_ currentTime: TimeInterval) {
		theCurrentTime = currentTime
		if isTimeSet == false{
			referenceTime = currentTime
			isTimeSet = true
		}
		let msInterval = (currentTime - referenceTime!)*1000
		teethLabel.text = String(speedFactor)
		
		//The code under this is for debugging
		// nteethLabel.text = String(isToothOut(speedFactor: speedFactor, timeInMilliseconds: msInterval))
		if !(inProcessOfUpdating){scoreLabel.text = String(Int(score))}
		let insertionLocation = 0.93 * (self.frame.size.width/1.5)
		if rightGear.position.x <= (self.frame.size.width/1.5) {
			if rightGear.position.x <= insertionLocation && !(isToothOut(speedFactor: speedFactor, timeInMilliseconds: msInterval)) && !(rightGear.hasActions()) && !(inProcessOfUpdating){
				updateScenePositive()
			} else if isToothOut(speedFactor: speedFactor, timeInMilliseconds: msInterval) && !(rightGear.hasActions()) && !(inProcessOfUpdating){
				inProcessOfUpdating = true
				scoreLabel.fontSize = 40
				scoreLabel.text = "Final Score: " + String(Int(score))
				leftGear.removeAllActions()
				leftGear.run(SKAction.fadeOut(withDuration: 2))
				rightGear.run(SKAction.fadeOut(withDuration: 2))
				let scoreInt = Int(score)
				UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "GearPoints") + scoreInt, forKey: "GearPoints")
				if scoreInt > UserDefaults.standard.integer(forKey: "Highscore"){
					UserDefaults.standard.set(scoreInt, forKey: "Highscore")
				}
				UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "PointsAccumulated") + scoreInt, forKey: "PointsAccumulated")
				
				Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: {_ in
					if UserDefaults.standard.integer(forKey: "PointsAccumulated") > 5 {
					self.viewController.presentMenuScene()
					UserDefaults.standard.set( 0, forKey: "PointsAccumulated" )
				self.viewController.interstitialDidDismissScreen(self.viewController.interstitial)
					} else {
					let menuScene = MenuScene(size: self.view!.bounds.size)
					self.view!.presentScene(menuScene)
					menuScene.viewController = self.viewController
					}
				})
			}
		}
	}
	
	var inProcessOfUpdating = false
	var theCurrentTime: TimeInterval?
	
	//used in update function to change the scene after point is scored
	func updateScenePositive(){
		inProcessOfUpdating = true
		switch self.score{
		case 0 : do{self.scoreLabel.text = "gets faster mate"
				self.scoreLabel.fontSize = 40
			}
		case 1: do {self.scoreLabel.text = "walking"
				self.scoreLabel.fontColor = UIColor.yellow
			}
		case 6:  do {self.scoreLabel.text = "jogging"
				self.scoreLabel.fontColor = UIColor.green
			}
		case 13: do {self.scoreLabel.text = "biking"
			self.scoreLabel.fontColor = UIColor.gray
			}
		case 20: do {self.scoreLabel.text = "trucking"
			self.scoreLabel.fontColor = UIColor.blue
			}
		case 27: do {self.scoreLabel.text = "cruising"
			self.scoreLabel.fontColor = UIColor.orange
			}
		case 34: do {self.scoreLabel.text = "speeding"
			self.scoreLabel.fontColor = UIColor.purple
			}
		case 41: do {self.scoreLabel.text = "racing"
			self.scoreLabel.fontColor = UIColor.green
			}
		case 48: do {self.scoreLabel.text = "drifting"
			self.scoreLabel.fontColor = UIColor.red
			}
		default: self.scoreLabel.text = String(Int(score + 1))
		}
		leftGear.removeAllActions()
		speedFactor = generateSpeed()
		let durationDecreaserMultiple = 2.25 //Used to be 1.8
		let actionDuration = 1/(durationDecreaserMultiple*self.speedFactor)
		let horizontalTranslation = -1 * (self.frame.size.width/1.75) //as opposed to -200
		leftGear.run(SKAction.moveBy(x: horizontalTranslation, y: 0, duration: actionDuration))
		leftGear.run(SKAction.rotate(byAngle: CGFloat(durationDecreaserMultiple*(-6.2831853)), duration: actionDuration))
		rightGear.run(SKAction.moveBy(x: horizontalTranslation, y: 0, duration: actionDuration))
		rightGear.run(SKAction.rotate(byAngle: CGFloat(durationDecreaserMultiple*6.2831853), duration: actionDuration))
		Timer.scheduledTimer(withTimeInterval: actionDuration, repeats: false, block: {_ in
			self.score = self.score + 1
			self.leftGear.removeAllActions()
			self.leftGear.removeFromParent()
			self.leftGear = self.rightGearHolder
			self.leftGear.size = CGSize(width:self.frame.size.width/1.5, height:self.frame.size.width/1.5)
			self.leftGear.position = CGPoint(x: 0, y: self.frame.size.width/6)
			self.rightGear.removeAllActions()
			self.rightGear.removeFromParent()
			self.rightGear = self.randomRightGearGenerator()
			self.rightGear.size = CGSize(width:self.frame.size.width/1.5, height:self.frame.size.width/1.5)
			self.rightGear.position = CGPoint(x: self.frame.size.width + self.frame.size.width/1.5, y: self.frame.size.width/6)
			self.rightGear.run(SKAction.moveBy(x: -1 * (self.frame.size.width/1.5), y: 0, duration: actionDuration/3))
		
		
			self.addChild(self.leftGear)
			self.addChild(self.rightGear)
			//self.speedFactor = self.generateSpeed()
		
			self.rightGear.run(SKAction.rotate(byAngle: CGFloat(6.2831853/16), duration: 0.0))
			self.leftGear.run(SKAction.rotate(byAngle: CGFloat(6.2831853/16), duration: 0.0))
			self.rotateGearIndefinitely(gear: self.leftGear, positive: self.leftGearDirection, speedFactor: self.speedFactor)
			//self.scoreLabel.fontColor = UIColor.white
			self.scoreLabel.fontSize = 80
			self.referenceTime = self.theCurrentTime
			self.inProcessOfUpdating = false
		})
	}
}
