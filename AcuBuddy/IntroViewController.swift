//
//  ViewController.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/16/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, HolderViewDelegate {

     var holderView = HolderView(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        addHolderView()
    }

    func addHolderView() {
        let boxSize: CGFloat = 100.0
        holderView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
            y: view.bounds.height / 2 - boxSize / 2,
            width: boxSize,
            height: boxSize)
        holderView.parentFrame = view.frame
        holderView.delegate = self
        view.addSubview(holderView)
        holderView.addOval()
    }
    
    func animateLabel() {
        
        // 1
        holderView.removeFromSuperview()
        view.backgroundColor = Colors.blue
        
        // 2
        var label: UILabel = UILabel(frame: view.frame)
        label.textColor = Colors.white
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 170.0)
        label.textAlignment = NSTextAlignment.Center
        label.text = "AB"
        label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25)
        view.addSubview(label)
        
        // 3
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut,
            animations: ({
                label.transform = CGAffineTransformScale(label.transform, 4.0, 4.0)
            }), completion: { finished in
            
                self.view.backgroundColor = Colors.white
                self.view.subviews.map({ $0.removeFromSuperview() })
                
               self.performSegueWithIdentifier("GoToHomePage", sender: self)
                
        })
    }
    



}

