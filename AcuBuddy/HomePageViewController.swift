//
//  HomePageViewController.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/16/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit


// A delay function
func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class HomePageViewController: UIViewController {
    
    // MARK: IB outlets
    
    @IBOutlet weak var button_red: UIButton!
    @IBOutlet weak var button_yellow: UIButton!
    @IBOutlet weak var button_grey: UIButton!
    @IBOutlet weak var button_blue: UIButton!
    @IBOutlet weak var button_green: UIButton!
    
    @IBOutlet var cloud1: UIImageView!
    @IBOutlet var cloud2: UIImageView!
    @IBOutlet var cloud3: UIImageView!
    @IBOutlet var cloud4: UIImageView!
    
    // MARK: further UI
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    
    let tableView = UITableView()
    
    // MARK: view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up the UI
        
        status.hidden = true
        status.center = self.view.center
        view.addSubview(status)

        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .Center
        status.addSubview(label)
        
        setUpTableView()
        view.addSubview(tableView)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        /*
        button_red
        button_yellow
        button_grey
        button_blue
        button_green
        */
        
        button_red.center = CGPoint(x: self.view.bounds.width / 2, y: -view.bounds.height)
        button_yellow.center = CGPoint(x: self.view.bounds.width * 2, y: -view.bounds.height)
        button_grey.center = CGPoint(x: self.view.bounds.width * 2, y: view.bounds.height * 2)
        button_blue.center = CGPoint(x: -view.bounds.width, y: view.bounds.height * 2)
        button_green.center = CGPoint(x: -view.bounds.width, y: -view.bounds.height)
        button_red.alpha = 0
        button_yellow.alpha = 0
        button_grey.alpha = 0
        button_blue.alpha = 0
        button_green.alpha = 0
      
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let w: CGFloat = self.view.bounds.width / 8
        let h: CGFloat = self.view.bounds.height / 8
        
        UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: [.CurveEaseOut], animations: { () -> Void in
            self.button_red.center = CGPoint(x: w * 4, y: h * 1.5)
            self.button_red.layer.cornerRadius = 15
            self.button_red.alpha = 0.5
            }, completion: {_ in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.button_red.alpha = 1
                })
                
            })
        
        
        
        UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: [.CurveEaseOut], animations: {
            self.button_yellow.center = CGPoint(x: w * 6, y: h * 3.5)
            self.button_yellow.layer.cornerRadius = 15
            self.button_yellow.alpha = 0.5
            
            }, completion: {_ in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.button_yellow.alpha = 1
                })
                
        })
        
        UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1,
            options: [.CurveEaseOut], animations: {
            self.button_green.center = CGPoint(x: w * 2, y: h * 3.5)
            self.button_green.layer.cornerRadius = 15
            self.button_green.alpha = 0.5
            }, completion: {_ in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.button_green.alpha = 1
                })
                
        })
        
        UIView.animateWithDuration(1.5, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 1,
            options: [.CurveEaseOut], animations: {
            self.button_grey.center = CGPoint(x: w * 6, y: h * 7)
            self.button_grey.layer.cornerRadius = 15
            self.button_grey.alpha = 0.5
            }, completion: {_ in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.button_grey.alpha = 1
                })
                
        })
        
        UIView.animateWithDuration(1.5, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 1,
            options: [.CurveEaseOut], animations: {
            self.button_blue.center = CGPoint(x: w * 2, y: h * 7)
            self.button_blue.layer.cornerRadius = 15
            self.button_blue.alpha = 0.5
                
            }, completion: {_ in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.button_blue.alpha = 1
                })
                
        })
        
    

    }
    
    // MARK: further methods
    
    @IBAction func redButtonTapped(sender: AnyObject) {
        showMessages(0)
        VariousFunctions().expandAndDisappear(sender as! UIButton, view: self.view)
    }
    
    @IBAction func greenButtonTapped(sender: AnyObject) {
        VariousFunctions().expandAndDisappear(sender as! UIButton, view: self.view)
    }
    
    @IBAction func yellowButtonTapped(sender: AnyObject) {
        presentTableView()
    }
 
    @IBAction func greyButtonTapped(sender: AnyObject) {
        
    }
    
    @IBAction func blueButtonTapped(sender: AnyObject) {
        
    }
    
    
    func showMessages(index: Int) {
        
        UIView.animateWithDuration(0.33, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseOut, animations: { () -> Void in
            
            self.status.center.x += self.view.frame.size.width
            
            }, completion: { _ in
                
                self.status.hidden = true
                self.status.center.x -= self.view.frame.size.width
                self.label.text = self.messages[index]
                
                UIView.transitionWithView(self.status, duration: 0.3, options: [.CurveEaseOut, .TransitionCurlDown] , animations: { () -> Void in
                    self.status.hidden = false
                    
                    }, completion: { _ in
                        
                        delay(seconds: 2.0, completion: {
                            if index < self.messages.count-1 {
                                
                                self.showMessages(index + 1)
                                
                            }
                        })
                })
        })
    }
    
    func setUpTableView() {
        tableView.hidden = true
        tableView.alpha = 0
        tableView.frame.size = CGSize(width: self.view.bounds.width - 40, height: self.view.bounds.height - 40)
        tableView.center = self.view.center
        tableView.backgroundColor = UIColor.blueColor()
    }
    
    func presentTableView(){
        sendButtonsAway()
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: .CurveEaseInOut, animations: { () -> Void in
            self.tableView.center = self.view.center
            self.tableView.hidden = false
            self.tableView.alpha = 1
            }, completion: nil )
    }
    
    func sendButtonsAway(){
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseIn, animations: { () -> Void in
            self.button_red.center = CGPoint(x: self.view.bounds.width / 2, y: -self.view.bounds.height)
            self.button_yellow.center = CGPoint(x: self.view.bounds.width * 2, y: -self.view.bounds.height)
            self.button_grey.center = CGPoint(x: self.view.bounds.width * 2, y: self.view.bounds.height * 2)
            self.button_blue.center = CGPoint(x: -self.view.bounds.width, y: self.view.bounds.height * 2)
            self.button_green.center = CGPoint(x: -self.view.bounds.width, y: -self.view.bounds.height)
          
            }, completion: nil )
        
        
        
    }
    
    
    
    
}

