//
//  HolderView.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/16/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

protocol HolderViewDelegate:class {
    func animateLabel()
}

class HolderView: UIView {
    
    let ovalLayer = OvalLayer()
    let triangleLayer = TriangleLayer()
    let redRectangleLayer = RectangleLayer()
    let blueRectangleLayer = RectangleLayer()
    let arcLayer = ArcLayer()
    
    var parentFrame :CGRect = CGRectZero
    weak var delegate:HolderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addOval() {
        layer.addSublayer(ovalLayer)
        ovalLayer.expand()
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "wobbleOval",
            userInfo: nil, repeats: false)
    }
    
    func wobbleOval() {
        // 1
        layer.addSublayer(triangleLayer) // Add this line
        ovalLayer.wobble()
        
        // 2
        // Add the code below
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self,
            selector: "drawAnimatedTriangle", userInfo: nil,
            repeats: false)
    }
    
    func drawAnimatedTriangle() {
        triangleLayer.animate()
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: "spinAndTransform",
            userInfo: nil, repeats: false)
    }
    
    func spinAndTransform() {
        // 1
        layer.anchorPoint = CGPointMake(0.5, 0.6)
        
        // 2
        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat(M_PI * 2.0)
        rotationAnimation.duration = 0.45
        rotationAnimation.removedOnCompletion = true
        layer.addAnimation(rotationAnimation, forKey: nil)
        
        // 3
        ovalLayer.contract()
        
        NSTimer.scheduledTimerWithTimeInterval(0.45, target: self,
            selector: "drawRedAnimatedRectangle",
            userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(0.65, target: self,
            selector: "drawBlueAnimatedRectangle",
            userInfo: nil, repeats: false)
    }
    
    func drawRedAnimatedRectangle() {
        layer.addSublayer(redRectangleLayer)
        redRectangleLayer.animateStrokeWithColor(Colors.red)
    }
    
    func drawBlueAnimatedRectangle() {
        layer.addSublayer(blueRectangleLayer)
        blueRectangleLayer.animateStrokeWithColor(Colors.blue)
        NSTimer.scheduledTimerWithTimeInterval(0.40, target: self, selector: "drawArc",
            userInfo: nil, repeats: false)
    }
    
    func drawArc() {
        layer.addSublayer(arcLayer)
        arcLayer.animate()
        NSTimer.scheduledTimerWithTimeInterval(0.90, target: self, selector: "expandView",
            userInfo: nil, repeats: false)
    }
    
    func expandView() {
        // 1
        backgroundColor = Colors.blue
        
        // 2
        frame = CGRectMake(frame.origin.x - blueRectangleLayer.lineWidth,
            frame.origin.y - blueRectangleLayer.lineWidth,
            frame.size.width + blueRectangleLayer.lineWidth * 2,
            frame.size.height + blueRectangleLayer.lineWidth * 2)
        
        // 3
        layer.sublayers = nil
        
        // 4
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                self.frame = self.parentFrame
            }, completion: { finished in
                self.addLabel()
        })
    }
    
    func addLabel() {
        delegate?.animateLabel()
    }
}



