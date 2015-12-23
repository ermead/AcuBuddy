//
//  PopOutContainerViewController.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/22/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

    let popOutDismissed = "popOutDismissed"

class EM_PopOutContainerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dismissView: UIView!
    let dismissButton = UIButton()
    let nc = NSNotificationCenter.defaultCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDismissButton(self.dismissView)
        
        // Do any additional setup after loading the view.
    }
    
    func setUpDismissButton(view: UIView){
        
        dismissButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        dismissButton.setTitle("X", forState: .Normal)
        dismissButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        dismissButton.backgroundColor = UIColor.lightGrayColor()
        dismissButton.addTarget(self, action: "dismissButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(dismissButton)
        
    }
    
    @IBAction func dismissButtonTapped(sender: AnyObject){
        let superView = sender.superview
        print("HPVC_PopOut dismiss button tapped")
        UIView.animateWithDuration(0.3) { () -> Void in
            // superView!!.alpha = 0
        }
        
        nc.postNotificationName(popOutDismissed, object: self)
        
        
    }

    
    //MARK: Table Views
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "Button"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 8
        
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
