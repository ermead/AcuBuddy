//
//  PopAnimator.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/20/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration    = 1.5
    var presenting  = true
    var originFrame = CGRect.zero
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return duration
        
        
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()!
        
        let toView =
        transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let herbView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)
        
        let initialFrame = presenting ? originFrame : herbView!.frame
        let finalFrame = presenting ? herbView!.frame : originFrame
        
        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        
        if presenting {
            herbView!.transform = scaleTransform
            herbView!.center = CGPoint(
                x: CGRectGetMidX(initialFrame),
                y: CGRectGetMidY(initialFrame))
            herbView!.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(herbView!)
        
        UIView.animateWithDuration(duration, delay:0.0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.0,
            options: [],
            animations: {
                herbView!.transform = self.presenting ?
                    CGAffineTransformIdentity : scaleTransform
                
                herbView!.center = CGPoint(x: CGRectGetMidX(finalFrame),
                    y: CGRectGetMidY(finalFrame))
                
            }, completion:{_ in
                transitionContext.completeTransition(true)
        })
        
        let round = CABasicAnimation(keyPath: "cornerRadius")
        round.fromValue = presenting ? 10.0/xScaleFactor : 0.0
        round.toValue = presenting ? 0.0 : 10.0/xScaleFactor
        round.duration = duration / 2
        herbView!.layer.addAnimation(round, forKey: nil)
        herbView!.layer.cornerRadius = presenting ? 0.0 : 10.0/xScaleFactor
        
    }
    
}
