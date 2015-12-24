//
//  GameViewController.swift
//  SurfDemo
//
//  Created by Eric Mead on 12/23/15.
//  Copyright (c) 2015 Eric Mead. All rights reserved.
//
//Many Thanks to Nick Walter on Udemy


import UIKit
import SpriteKit



extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

//class GameViewController: UIViewController {
class GameViewController: UIViewController {
    
    @IBOutlet weak var myDismissView: UIView!
    let dismissView = UIView()
    let dismissButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
            
            setUpDismissView()
           
            
            
            
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }
    
    func setUpDismissView(){
        
            dismissView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            setUpDismissButton(dismissView)
            myDismissView.addSubview(dismissView)
        
    }
    
    func setUpDismissButton(view: UIView){
        
        dismissButton.frame = CGRect(x: 7, y: 5, width: 40, height: 40)
        dismissButton.setTitle("X", forState: .Normal)
        dismissButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        dismissButton.backgroundColor = UIColor.lightGrayColor()
        dismissButton.addTarget(self, action: "dismissButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(dismissButton)
        
    }
    
    @IBAction func dismissButtonTapped(sender: AnyObject){
        _ = sender.superview

        print("game dismiss tapped")
        let nc = NSNotificationCenter.defaultCenter()
        nc.postNotificationName(dismissNotification, object: self)
        UIView.animateWithDuration(0.3) { () -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

