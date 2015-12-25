//
//  EM_CalligraphyViewController.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/24/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

class EM_CalligraphyViewController: UIViewController {

    let drawView = EM_CalligraphyView()
    let dismissButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawView.frame = CGRect.zero
        drawView.backgroundColor = UIColor.lightGrayColor()
        self.view = drawView
        
        setUpDismissButton(self.view)

        // Do any additional setup after loading the view.
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
        let superView = sender.superview

        print("dismiss tapped")
       
        self.dismissViewControllerAnimated(true, completion: nil)
  
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
