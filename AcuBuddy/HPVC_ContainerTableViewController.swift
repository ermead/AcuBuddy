//
//  HVC_containerTableViewController.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/21/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation
import UIKit

class EM_HPVC_ContainerTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let dismissButton = UIButton()
    
    var indexSection = 0
    
    @IBAction func rightButtonTapped(sender: AnyObject) {
        indexSection += 5
        if indexSection >= tableView.numberOfSections - 1 {
            indexSection = 0
        }
        let indexPath = NSIndexPath(forRow: 0, inSection: indexSection)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: false)
    }
   
    @IBAction func leftButtonTapped(sender: AnyObject) {
        indexSection -= 5
        if indexSection <= 0 {
            indexSection = 0
        }
        let indexPath = NSIndexPath(forRow: 0, inSection: indexSection)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: false)
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let dictionary: NSDictionary = ["colors": ["Red", "Green", "Yellow", "White", "Blue"], "organs" : ["Heart", "Liver", "Spleen", "Lung", "Kidney"], "emotions": ["Joy", "Anger", "Worry", "Grief", "Fear"]]
    
    var array: [String] = []
    
    var height: CGFloat?
    
    override func viewDidLoad() {
        
        height = EM_HomePageViewController().buttonOriginalHeight
        
        array = (dictionary["colors"] as! [String]) + (dictionary["organs"] as! [String]) + (dictionary["emotions"] as! [String])
        
        setUpDismissButton(self.view)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.array.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        let headerView = UITableViewHeaderFooterView()
        headerView.contentView.backgroundColor = UIColor.blackColor()
        return headerView
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if self.height != nil {
            
            return self.height!
            
        } else {
            
            return 90
            
        }
        
    }
    
  
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        var string: String?
        
        let section = indexPath.section
        string = array[section]
        
        cell.textLabel?.text = string
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func setUpDismissButton(view: UIView){
        
        dismissButton.frame = CGRect(x: 5, y: 5, width: 40, height: 40)
        dismissButton.setTitle("X", forState: .Normal)
        dismissButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        dismissButton.backgroundColor = UIColor.lightGrayColor()
        dismissButton.addTarget(self, action: "dismissButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(dismissButton)
        
    }
    
    @IBAction func dismissButtonTapped(sender: AnyObject){
        let superView = sender.superview
        print("tapped")
        UIView.animateWithDuration(0.3) { () -> Void in
            //superView!!.alpha = 0
        }

    }
    
    
    
    
    
}