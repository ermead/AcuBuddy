//
//  GameScene.swift
//  SurfDemo
//
//  Created by Eric Mead on 12/23/15.
//  Copyright (c) 2015 Eric Mead. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var didSetDefaultOffSets: Bool = false
    var xOffSetAdjust: CGFloat? = 0
    var yOffSetAdjust: CGFloat? = 1
    
    var backgroundView = UIView()
    var blueSquare = SKSpriteNode()
    var motionManager = CMMotionManager()
    
    
    ///////
    var surfer = SKSpriteNode()
    var wave = SKSpriteNode()
    var TopCoin = SKSpriteNode()
    
    let surferCategory : UInt32 = 1 << 0
    let groundCategory : UInt32 = 1 << 1
    let polesCategory : UInt32 = 1 << 2
    let scoreCategory : UInt32 = 1 << 3
    let coinsCategory : UInt32 = 1 << 2
    
    var sky = SKSpriteNode(imageNamed: "Surfer Sky")
    var waveBase = SKSpriteNode(imageNamed: "Wave Base1")
    
    var movingParts = SKNode()
    
    var poles = SKNode()
    
    var scoreLabel = SKLabelNode()
    var score = NSInteger()
    

    
    override func didMoveToView(view: SKView) {
        
        
        
        self.blueSquare.position = self.view!.center
        self.blueSquare.size = CGSize(width: 15, height: 15)
        self.addChild(blueSquare)
       
        
        //monitorMotion()
        //animateBlueIntoRed()
        
        self.addChild(self.movingParts)
        self.movingParts.addChild(self.poles)
        
        self.physicsWorld.gravity = CGVectorMake(0.48, -5)
        self.physicsWorld.contactDelegate = self
        
        self.sky.position = CGPoint(x: self.frame.size.width / 2, y:  self.frame.size.height / 2)
        self.sky.zPosition = -2
        self.addChild(self.sky)
        
        self.waveBase.position = CGPoint(x: self.frame.size.width / 2, y:  self.frame.size.height / 2 + 5)
        self.waveBase.zPosition = -1
        self.addChild(self.waveBase)
        
        //add wavebase
        
        /*var wavebase1 = SKTexture(imageNamed: "Wave Base1")
        var wavebase2 = SKTexture(imageNamed: "Wave Base2")
        self.waveBase = SKSpriteNode(texture: wavebase1)
        
        var wavebaseanim = SKAction.animateWithTextures([wavebase1, wavebase2], timePerFrame: 3)
        var wavebaseforever = SKAction.repeatActionForever(wavebaseanim)
        
        self.runAction(wavebaseforever)
        self.waveBase.zPosition = -2
        self.addChild(waveBase)*/
        
        
        var createPoles = SKAction.runBlock({() in self.createPoles()})
        var waitAMinute = SKAction.waitForDuration(3)
        var createAndWait = SKAction.sequence([createPoles, waitAMinute])
        var createAndWaitForever = SKAction.repeatActionForever(createAndWait)
        self.runAction(createAndWaitForever)
        
        
        
        var groundTexture = SKTexture(imageNamed: "Ground")
        
        var groundMovingLeft = SKAction.moveByX(-groundTexture.size().width, y: 0, duration: NSTimeInterval( groundTexture.size().width * 0.005))
        var resetGround = SKAction.moveByX(groundTexture.size().width, y: 0, duration: 0)
        var groundMovingLeftForever = SKAction.repeatActionForever(SKAction.sequence([groundMovingLeft,resetGround]))
        
        for var i:CGFloat = 0; i < self.frame.size.width / (groundTexture.size().width); ++i {
            var groundPiece = SKSpriteNode(texture: groundTexture)
            groundPiece.position = CGPoint(x: i * groundPiece.size.width, y: groundPiece.size.height / 10)
            groundPiece.runAction(groundMovingLeftForever)
            self.movingParts.addChild(groundPiece)
            
            /* var CaveCeilingTexture = SKTexture(imageNamed: "Ceiling")
            
            var CeilingMovingLeft = SKAction.moveByX(-CaveCeilingTexture.size().width, y: 0, duration: NSTimeInterval( CaveCeilingTexture.size().width * 0.01))
            var resetCeiling = SKAction.moveByX(CaveCeilingTexture.size().width, y: 0, duration: 0)
            var CeilingMovingLeftForever = SKAction.repeatActionForever(SKAction.sequence([CeilingMovingLeft,resetGround]))
            
            for var i:CGFloat = 0; i < self.frame.size.width / (CaveCeilingTexture.size().width); ++i {
            var CeilingPiece = SKSpriteNode(texture: CaveCeilingTexture)
            CeilingPiece.position = CGPoint(x: i * CeilingPiece.size.width, y: CeilingPiece.size.height / 1.3)
            CeilingPiece.runAction(CeilingMovingLeftForever)
            self.movingParts.addChild(CeilingPiece)*/
            
        }
        
        var surferTexture1 = SKTexture(imageNamed: "Surfer1")
        var surferTexture2 = SKTexture(imageNamed: "Surfer2")
        var surferTexture3 = SKTexture(imageNamed: "Surfer3")
        var surferTexture4 = SKTexture(imageNamed: "Surfer4")
        var surferTexture5 = SKTexture(imageNamed: "Surfer5")
        
        self.surfer = SKSpriteNode(texture: surferTexture1)
        self.surfer.zPosition = 200
        
        var flap = SKAction.animateWithTextures([surferTexture1,/*surferTexture2,surferTexture3,surferTexture4,surferTexture5*/], timePerFrame: 0.1)
        var flapForever = SKAction.repeatAction(flap, count: 1)
        self.surfer.runAction(flapForever)
        
        self.surfer.position = CGPoint(x: self.frame.size.width / 2.1 , y: self.frame.size.height / 1.3)
        
        self.surfer.physicsBody = SKPhysicsBody(circleOfRadius: self.surfer.size.height / 2)
        self.surfer.physicsBody?.dynamic = true
        self.surfer.physicsBody?.allowsRotation = false
        
        self.surfer.physicsBody?.categoryBitMask = self.surferCategory
        self.surfer.physicsBody?.collisionBitMask = self.groundCategory | self.polesCategory
        self.surfer.physicsBody?.contactTestBitMask = self.groundCategory | self.polesCategory
        
        self.surfer.setScale(0.9)
        self.addChild(self.surfer)
        
        
        var fakeGround = SKNode()
        fakeGround.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, groundTexture.size().height))
        fakeGround.position = CGPointMake(0, groundTexture.size().height / 10)
        fakeGround.physicsBody?.dynamic = false
        fakeGround.physicsBody?.categoryBitMask = self.groundCategory
        self.addChild(fakeGround)
        
        self.score = 0
        self.addChild(self.scoreLabel)
        self.scoreLabel.position = CGPoint(x: self.frame.size.width / 4 * 1.45, y: self.frame.size.height / 4 * 3.55)
        self.scoreLabel.fontSize = 100
        self.scoreLabel.fontColor = SKColor.whiteColor()
        self.scoreLabel.zPosition = 200
        self.scoreLabel.text = "\(self.score)"
        
        
        
        
        //add wave
        var waveTexture1 = SKTexture(imageNamed: "Wave_1-1")
        var waveTexture2 = SKTexture(imageNamed: "Wave_2-1")
        var waveTexture3 = SKTexture(imageNamed: "Wave_3-1")
        var waveTexture4 = SKTexture(imageNamed: "Wave_4-1")
        var waveTexture5 = SKTexture(imageNamed: "Wave_5-1")
        self.wave = SKSpriteNode(texture: waveTexture1)
        self.wave.zPosition = 300
        
        var waveBreaking = SKAction.animateWithTextures([waveTexture5,waveTexture4,waveTexture5,waveTexture4,waveTexture5,waveTexture4,waveTexture5,waveTexture4,waveTexture3,waveTexture2,waveTexture1,waveTexture2,waveTexture1,waveTexture2,waveTexture3,waveTexture4], timePerFrame: 0.4)
        var waveBarrelling = SKAction.animateWithTextures([waveTexture4,waveTexture3,waveTexture2,waveTexture1,waveTexture2,waveTexture1,waveTexture2,waveTexture3,waveTexture4], timePerFrame: 0.4)
        
        var waveBreakingSequence = SKAction.sequence([waveBreaking, waveBreaking, waveBreaking,waveBarrelling,waveBreaking, waveBreaking,waveBarrelling])
        var waveBreakingForever = SKAction.repeatActionForever(waveBreakingSequence)
        
        self.wave.runAction(waveBreakingForever)
        
        self.wave.position = CGPoint(x: self.frame.size.width / 2 , y: self.frame.size.height / 2)
        
        self.addChild(self.wave)
        
    }
    
    func createPoles() {
        
        var twinPoles = SKNode()
        
        var random = arc4random_uniform(15)
        
        var bottomPole1 = SKTexture(imageNamed: "bottomPole1")
        var bottomPole2 = SKTexture(imageNamed: "bottomPole2")
        var bottomPoleAnimation = SKAction.animateWithTextures([bottomPole1,bottomPole2], timePerFrame: 0.4)
        var bottomPoleAnimateForever = SKAction.repeatActionForever(bottomPoleAnimation)
        
        twinPoles.position = CGPoint(x: self.frame.size.width, y: CGFloat(random * 15) - 100)
        
        var topPole = SKSpriteNode(imageNamed: "topPole")
        topPole.position = CGPoint(x: 0, y: ((self.frame.size.height)+100))
        topPole.physicsBody = SKPhysicsBody(rectangleOfSize: topPole.size)
        topPole.physicsBody?.dynamic = false
        topPole.physicsBody?.categoryBitMask = self.polesCategory
        twinPoles.addChild(topPole)
        
        var bottomPole = SKSpriteNode(imageNamed: "bottomPole1")
        bottomPole.position = CGPoint(x: 0, y: -50)
        bottomPole.physicsBody = SKPhysicsBody(rectangleOfSize: bottomPole.size)
        bottomPole.physicsBody?.dynamic = false
        bottomPole.physicsBody?.categoryBitMask = self.polesCategory
        bottomPole.runAction(bottomPoleAnimateForever)
        bottomPole.xScale = 1
        twinPoles.addChild(bottomPole)
        
        var scoreArea = SKNode()
        scoreArea.position = CGPoint(x: bottomPole.size.width, y: self.frame.size.height / 2)
        scoreArea.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(bottomPole.size.width, self.frame.size.height))
        scoreArea.physicsBody?.dynamic = false
        scoreArea.physicsBody?.categoryBitMask = self.scoreCategory
        scoreArea.physicsBody?.contactTestBitMask = self.surferCategory
        twinPoles.addChild(scoreArea)
        
        var otherBottomPole = SKSpriteNode(imageNamed: "otherBottomPole")
        otherBottomPole.position = CGPoint(x: -200, y: 100)
        //otherBottomPole.runAction(bottomPoleAnimateForever)
        otherBottomPole.zPosition = 400
        otherBottomPole.setScale(1.11)
        twinPoles.addChild(otherBottomPole)
        
        
        
        /*var BottomCoin = SKSpriteNode(imageNamed: "Coin")
        BottomCoin.position = CGPoint(x: 350, y: 250)
        //otherBottomPole.runAction(bottomPoleAnimateForever)
        BottomCoin.zPosition = 1
        BottomCoin.setScale(0.5)
        twinPoles.addChild(BottomCoin)*/
        
        var TopCoin = SKSpriteNode(imageNamed: "Coin")
        TopCoin.position = CGPoint(x: 350, y: ((self.frame.size.height)-100))
        //TopCoin.runAction(bottomPoleAnimateForever)
        TopCoin.physicsBody = SKPhysicsBody(rectangleOfSize: TopCoin.size)
        TopCoin.physicsBody?.dynamic = false
        TopCoin.physicsBody?.categoryBitMask = 0
        TopCoin.zPosition = 100
        TopCoin.setScale(0.5)
        twinPoles.addChild(TopCoin)
        
        //func surferDidCollideWithCoin {
        //   (TopCoin.position() = surfer.position())
        //        thisTopCoin.removeFromParent()
        //      score++
        //}
        
        
        var movingDistance = CGFloat(self.frame.size.width + 2 * topPole.size.width)
        var movePoles = SKAction.moveByX(-movingDistance, y: 0, duration: NSTimeInterval(movingDistance * 0.00199))
        var removePoles = SKAction.removeFromParent()
        var moveAndRemovePoles = SKAction.sequence([movePoles,removePoles])
        
        twinPoles.runAction(moveAndRemovePoles)
        
        self.poles.zPosition = -1
        self.poles.addChild(twinPoles)
        
    }
    /* in touches began func
    var AscendingTexture1 = SKTexture(imageNamed: "Surfer6")
    var AscendingTexture2 = SKTexture(imageNamed: "Surfer7")
    var AscendingTexture3 = SKTexture(imageNamed: "Surfer8")
    var AscendingTexture4 = SKTexture(imageNamed: "Surfer9")
    var surferTexture1 = SKTexture(imageNamed: "Surfer1")
    var surferTexture2 = SKTexture(imageNamed: "Surfer2")
    var surferTexture3 = SKTexture(imageNamed: "Surfer3")
    var surferTexture4 = SKTexture(imageNamed: "Surfer4")
    var surferTexture5 = SKTexture(imageNamed: "Surfer5")
    
    var flap = SKAction.animateWithTextures([surferTexture1,surferTexture4,surferTexture4,surferTexture5,surferTexture5], timePerFrame: 0.1)
    var flapForever = SKAction.repeatAction(flap, count: 1)
    self.surfer.runAction(flapForever)
    
    var ascend = SKAction.animateWithTextures([AscendingTexture2,AscendingTexture3], timePerFrame: 0.1)
    var ascendForATime = SKAction.sequence([ascend,flapForever])
    */
    
    //MARK: Motion:
    func setDefaultOffSets(x: CGFloat, y: CGFloat){
        self.didSetDefaultOffSets = true
        self.xOffSetAdjust = x
        self.yOffSetAdjust = y
        
    }
    
    func monitorMotion(){
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) { (motion, error ) -> Void in
            
            //print(motion?.attitude)
            
            if let attitude = motion?.attitude {
                
                
                var AscendingTexture1 = SKTexture(imageNamed: "Surfer6")
                var AscendingTexture2 = SKTexture(imageNamed: "Surfer7")
                var AscendingTexture3 = SKTexture(imageNamed: "Surfer8")
                var AscendingTexture4 = SKTexture(imageNamed: "Surfer9")
                var surferTexture1 = SKTexture(imageNamed: "Surfer1")
                var surferTexture2 = SKTexture(imageNamed: "Surfer2")
                var surferTexture3 = SKTexture(imageNamed: "Surfer3")
                var surferTexture4 = SKTexture(imageNamed: "Surfer4")
                var surferTexture5 = SKTexture(imageNamed: "Surfer5")
                
                var flap = SKAction.animateWithTextures([surferTexture1,surferTexture4,surferTexture4,surferTexture5,surferTexture5], timePerFrame: 0.1)
                var flapForever = SKAction.repeatAction(flap, count: 1)
                self.surfer.runAction(flapForever)
                
                var ascend = SKAction.animateWithTextures([AscendingTexture2,AscendingTexture3], timePerFrame: 0.1)
                var ascendForATime = SKAction.sequence([ascend,flapForever])
                
                let xOffset = (self.view!.frame.size.width/2.0 * CGFloat(attitude.roll * 1.2))
                var yOffset = (self.view!.frame.size.height/2.0 * CGFloat((attitude.pitch - Double(self.yOffSetAdjust!)) * 1.8))
                
                print(attitude.pitch)
                
//                //UIView.animateWithDuration(1, animations: { () -> Void in
//                    self.surfer.position = CGPointMake(self.view!.center.x + xOffset, self.view!.center.y + yOffset)
//                    }, completion: nil )
                
                //print("Pitch: \(attitude.pitch), Yaw: \(attitude.yaw), Roll: \(attitude.roll)")
                
//                if self.didSetDefaultOffSets == false {
//                    self.setDefaultOffSets(xOffset, y: CGFloat(attitude.pitch ))
//                }
                
                if self.didSetDefaultOffSets == false {
                    //self.setDefaultOffSets(xOffset, y: CGFloat(attitude.pitch ))
                }
                
                
                if self.movingParts.speed > 0 {
                    
                    
                    self.surfer.physicsBody?.velocity = CGVectorMake(0,0)
                   // self.surfer.physicsBody?.applyImpulse(CGVectorMake(0, 25))
                    
                    self.surfer.position.y += CGFloat(attitude.pitch)
                    
                   
                    //self.surfer.position.y += yOffset
                   
                    
                    //print(yOffset)
                    var flap = SKAction.animateWithTextures([surferTexture1,surferTexture4,surferTexture4,surferTexture5,surferTexture5], timePerFrame: 0.1)
                    var flapForever = SKAction.repeatAction(flap, count: 1)
                    var ascend = SKAction.animateWithTextures([AscendingTexture2,AscendingTexture3], timePerFrame: 0.1)
                    var ascendForATime = SKAction.sequence([ascend,flapForever])
                    self.surfer.runAction(ascendForATime)
                    //self.surfer.zRotation = 12.5
                }
                    
                else {
                    //self.resetGame()
                    
                    
                }
                
                
              
            }
            
            //print(motion)
        }
    }
    
    

    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        var AscendingTexture1 = SKTexture(imageNamed: "Surfer6")
        var AscendingTexture2 = SKTexture(imageNamed: "Surfer7")
        var AscendingTexture3 = SKTexture(imageNamed: "Surfer8")
        var AscendingTexture4 = SKTexture(imageNamed: "Surfer9")
        var surferTexture1 = SKTexture(imageNamed: "Surfer1")
        var surferTexture2 = SKTexture(imageNamed: "Surfer2")
        var surferTexture3 = SKTexture(imageNamed: "Surfer3")
        var surferTexture4 = SKTexture(imageNamed: "Surfer4")
        var surferTexture5 = SKTexture(imageNamed: "Surfer5")
        
        var flap = SKAction.animateWithTextures([surferTexture1,surferTexture4,surferTexture4,surferTexture5,surferTexture5], timePerFrame: 0.1)
        var flapForever = SKAction.repeatAction(flap, count: 1)
        self.surfer.runAction(flapForever)
        
        var ascend = SKAction.animateWithTextures([AscendingTexture2,AscendingTexture3], timePerFrame: 0.1)
        var ascendForATime = SKAction.sequence([ascend,flapForever])
        
        
                if self.movingParts.speed > 0 {
                    
                    
                    self.surfer.physicsBody?.velocity = CGVectorMake(0, 50)
                    self.surfer.physicsBody?.applyImpulse(CGVectorMake(-30, 270))
                    var flap = SKAction.animateWithTextures([surferTexture1,surferTexture4,surferTexture4,surferTexture5,surferTexture5], timePerFrame: 0.1)
                    var flapForever = SKAction.repeatAction(flap, count: 1)
                    var ascend = SKAction.animateWithTextures([AscendingTexture2,AscendingTexture3], timePerFrame: 0.1)
                    var ascendForATime = SKAction.sequence([ascend,flapForever])
                    self.surfer.runAction(ascendForATime)
                    self.surfer.zRotation = 12.5
                }
        
                else {
                    resetGame()
                    
                    
                }
        
        
    }
        
     
        
        
//        if self.movingParts.speed > 0 {
//            self.surfer.physicsBody?.velocity = CGVectorMake(0, 50)
//            self.surfer.physicsBody?.applyImpulse(CGVectorMake(-30, 270))
//            var flap = SKAction.animateWithTextures([surferTexture1,surferTexture4,surferTexture4,surferTexture5,surferTexture5], timePerFrame: 0.1)
//            var flapForever = SKAction.repeatAction(flap, count: 1)
//            var ascend = SKAction.animateWithTextures([AscendingTexture2,AscendingTexture3], timePerFrame: 0.1)
//            var ascendForATime = SKAction.sequence([ascend,flapForever])
//            self.surfer.runAction(ascendForATime)
//            self.surfer.zRotation = 12.5
//        }
//            
//        else {
//            resetGame()
//            
//            
//        }
//    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == self.scoreCategory || contact.bodyB.categoryBitMask == self.scoreCategory {
            self.score++
            self.scoreLabel.text = "\(self.score)"
        } else {
            endGame()
        }
    }
    
    func resetGame() {
        
        self.didSetDefaultOffSets = false
        
        // reset the position of the surfer
        self.surfer.position = CGPoint(x: self.frame.size.width / 2.1 , y: self.frame.size.height / 1.3)
        self.surfer.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        // remove all the pipes
        self.poles.removeAllChildren()
        
        //reset wave...can't figure this out yet
        
        // set the speed again for the movingParts
        self.movingParts.speed = 1
        
        self.surfer.physicsBody?.collisionBitMask = self.groundCategory | self.polesCategory
        
        self.score = 0
        self.scoreLabel.text = "\(self.score)"
    }
    
    func endGame() {
        
        if self.movingParts.speed > 0 {
            self.movingParts.speed = 0
            
            self.surfer.physicsBody?.collisionBitMask = self.groundCategory
            
            let hideSky = SKAction.runBlock({() in self.sky.hidden = true})
            let whiteBackground = SKAction.runBlock({() in self.backgroundColor = UIColor.whiteColor()})
            let wait = SKAction.waitForDuration(0.06)
            let orangeBackground = SKAction.runBlock({() in self.backgroundColor = UIColor.cyanColor()})
            let showSky = SKAction.runBlock({() in self.sky.hidden = false})
            let gameOver = SKAction.sequence([hideSky, whiteBackground, wait, orangeBackground, wait, whiteBackground, wait, showSky])
            self.runAction(gameOver)
        }
    }
}
