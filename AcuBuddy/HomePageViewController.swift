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
    
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    var buttonOriginalWidth: CGFloat?
    var buttonOriginalHeight: CGFloat?
    
    // MARK: IB outlets
    
    var button_red = UIButton()
    var button_yellow = UIButton()
    var button_grey = UIButton()
    var button_blue = UIButton()
    var button_green = UIButton()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var cloud1: UIImageView!
    @IBOutlet var cloud2: UIImageView!
    @IBOutlet var cloud3: UIImageView!
    @IBOutlet var cloud4: UIImageView!
    
    // MARK: further UI
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let messages = ["Connecting ...", "Getting Info...", "Here it is..."]
    
    
    let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewFlowLayout.init())
    let dismissButton = UIButton()
    let hamburgerButton = UIButton()
    let popUpFromHamburger = UIView()

    
    // MARK: view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up the UI
        //setUpButtons()
        
        screenHeight = self.view.bounds.height / 8
        screenWidth = self.view.bounds.width / 8
        buttonOriginalHeight = screenWidth! * 2
        buttonOriginalWidth = screenWidth! * 2
        
        status.hidden = true
        status.center.x = self.view.center.x
        status.center.y = 50
        view.addSubview(status)

        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .Center
        status.addSubview(label)
        
        setUpHamburgerButton()
        popUpFromHamburger.hidden = true
        
        setUpTableView()
        setUpCollectionView()
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
        
        screenHeight = self.view.bounds.height / 8
        screenWidth = self.view.bounds.width / 8
        buttonOriginalHeight = screenWidth! * 2
        buttonOriginalWidth = screenWidth! * 2
        
        setUpButtons()
        
        self.navigationController?.navigationBarHidden = true
        
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
       
        if self.tableView.alpha == 1 {
            
        } else {
            bringInButtons()
        }
    
    }
    
    // MARK: further methods
    
    func removeButtonConstraints(){
        
        let buttons = [self.button_red, self.button_yellow, self.button_blue, self.button_green, self.button_grey]
        
        self.button_blue.constraints
        
        for button in buttons {
            
            let constraints = button.constraints
            
            for constraint in constraints {
                constraint.active = false
            }
            
        }
        
    }
    
    @IBAction func redButtonTapped(sender: AnyObject) {
        showMessages(0)
        VariousFunctions().expandAndDisappear(sender as! UIButton, view: self.view)
        delay(seconds: 3, completion: { _ in
            
            self.bringInButtons()
        })
    }
    
    @IBAction func greenButtonTapped(sender: AnyObject) {
        self.moveButtonsToEdges()
        delay(seconds: 1, completion: { _ in
            self.makeButtonsTransparent()
        })
        
        delay(seconds: 3, completion: { _ in
            
            //self.bringInButtons()
        })
    }
    
    @IBAction func yellowButtonTapped(sender: AnyObject) {
        presentTableView()
    }
 
    @IBAction func greyButtonTapped(sender: AnyObject) {
        
        self.moveButtonsToLeftEdge()
        
        delay(seconds: 3, completion: { _ in
            
            //self.bringInButtons()
        })
    }
    
    @IBAction func blueButtonTapped(sender: AnyObject) {
        removeButtonConstraints()
        bringButtonsToCenter()
        delay(seconds: 1, completion: { _ in
            self.expandAsStack()
        })
        delay(seconds: 3, completion: { _ in
            
            //self.bringInButtons()
        })
        
    }
    
    //MARK: Button Animations
    func bringInButtons() {
        let w: CGFloat = self.view.bounds.width / 8
        let h: CGFloat = self.view.bounds.height / 8
        
        UIView.animateWithDuration(1, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: [.CurveEaseOut], animations: { () -> Void in

            self.button_red.frame.size = CGSize(width: w * 2, height: w * 2)
            self.button_red.center = CGPoint(x: w * 4, y: h * 1.5)
            self.button_red.layer.cornerRadius = 15
            self.button_red.alpha = 1
            }, completion: {_ in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.button_red.alpha = 1
                })
                
        })
        
        
        UIView.animateWithDuration(1, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: [.CurveEaseOut], animations: {
         
            self.button_yellow.frame.size = CGSize(width: w * 2, height: w * 2)
            self.button_yellow.center = CGPoint(x: w * 6, y: h * 3.5)
            self.button_yellow.layer.cornerRadius = 15
            self.button_yellow.alpha = 1
            
            }, completion: {_ in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.button_yellow.alpha = 1
                })
                
        })
        
        UIView.animateWithDuration(1, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1,
            options: [.CurveEaseOut], animations: {
                
                self.button_green.frame.size = CGSize(width: w * 2, height: w * 2)
                self.button_green.center = CGPoint(x: w * 2, y: h * 3.5)
                self.button_green.layer.cornerRadius = 15
                self.button_green.alpha = 1
            }, completion: {_ in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.button_green.alpha = 1
                })
                
        })
        
        UIView.animateWithDuration(1, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 1,
            options: [.CurveEaseOut], animations: {
               
                self.button_grey.frame.size = CGSize(width: w * 2, height: w * 2)
                self.button_grey.center = CGPoint(x: w * 6, y: h * 7)
                self.button_grey.layer.cornerRadius = 15
                self.button_grey.alpha = 1
            }, completion: {_ in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.button_grey.alpha = 1
                })
                
        })
        
        UIView.animateWithDuration(1, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 1,
            options: [.CurveEaseOut], animations: {
                
                self.button_blue.frame.size = CGSize(width: w * 2, height: w * 2)
                self.button_blue.center = CGPoint(x: w * 2, y: h * 7)
                self.button_blue.layer.cornerRadius = 15
                self.button_blue.alpha = 1
                
            }, completion: {_ in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.button_blue.alpha = 1
                })
                
        })
        
    }
    
    func setUpButtons(){
        
        /*
        button_red
        button_yellow
        button_grey
        button_blue
        button_green
        */
        
        button_red.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button_yellow.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button_grey.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button_blue.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button_green.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        
        button_red.backgroundColor = Colors.red
        button_yellow.backgroundColor = Colors.yellow
        button_grey.backgroundColor = Colors.grey
        button_blue.backgroundColor = Colors.blue1
        button_green.backgroundColor = Colors.green
        
        button_red.layer.borderColor = UIColor.blackColor().CGColor
        button_yellow.layer.borderColor = UIColor.blackColor().CGColor
        button_grey.layer.borderColor = UIColor.blackColor().CGColor
        button_blue.layer.borderColor = UIColor.blackColor().CGColor
        button_green.layer.borderColor = UIColor.blackColor().CGColor
        
        button_red.layer.borderWidth = 1
        button_yellow.layer.borderWidth = 1
        button_grey.layer.borderWidth = 1
        button_blue.layer.borderWidth = 1
        button_green.layer.borderWidth = 1
        
        
        button_red.addTarget(self, action: "redButtonTapped:", forControlEvents: .TouchUpInside)
        button_yellow.addTarget(self, action: "yellowButtonTapped:", forControlEvents: .TouchUpInside)
        button_grey.addTarget(self, action: "greyButtonTapped:", forControlEvents: .TouchUpInside)
        button_blue.addTarget(self, action: "blueButtonTapped:", forControlEvents: .TouchUpInside)
        button_green.addTarget(self, action: "greenButtonTapped:", forControlEvents: .TouchUpInside)
        
        view.addSubview(button_red)
        view.addSubview(button_yellow)
        view.addSubview(button_green)
        view.addSubview(button_grey)
        view.addSubview(button_blue)
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
    
    func bringButtonsToCenter(){
        let buttons = [self.button_red, self.button_yellow, self.button_blue, self.button_green, self.button_grey]
        var delay = 0.1
        for button in buttons{
            UIView.animateWithDuration(0.5, delay: delay, options: .CurveEaseInOut, animations: { () -> Void in
                button.frame.size = CGSize(width: self.buttonOriginalWidth!, height: self.buttonOriginalHeight!)
                button.center = self.view.center
                delay += 0.1
                }, completion: nil )
        }
        
    }
    
    func expandAsStack(){
        let buttons = [self.button_red, self.button_green, self.button_yellow, self.button_grey, self.button_blue]
        var delay = 0.1
        var offSetY = CGFloat(5)
        for button in buttons{
            UIView.animateWithDuration(0.5, delay: delay, options: .CurveEaseInOut, animations: { () -> Void in
                button.center.x = self.view.center.x
                button.center.y = button.frame.size.height + 20 + offSetY
                delay += 0.1
                offSetY += button.frame.size.height + CGFloat(5)
                }, completion: {_ in
                  UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
                        button.frame.size.width = button.frame.size.width * 3
                        button.center.x = self.view.center.x
                    }, completion: nil)
            })
        }
        
    }
    
    func moveButtonsToLeftEdge(){
        let buttons = [self.button_red, self.button_green, self.button_yellow, self.button_grey, self.button_blue]
        var delay = 0.1
        var offSetY = CGFloat(5)
        for button in buttons{
            
            UIView.animateWithDuration(0.5, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.CurveEaseInOut], animations: { () -> Void in
                button.frame.size = CGSize(width: self.buttonOriginalWidth!, height: self.buttonOriginalHeight!)
                button.frame.origin.x = 0
                button.center.y = button.frame.size.height + 20 + offSetY
                delay += 0.1
                offSetY += button.frame.size.height + CGFloat(5)
                }, completion: nil )
            
        }
        
        
        
    }
    
    func moveButtonsToEdges(){
        
            let w: CGFloat = self.view.bounds.width / 8
            let h: CGFloat = self.view.bounds.height / 8
            
            UIView.animateWithDuration(1, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: [.CurveEaseOut], animations: { () -> Void in
                self.button_red.frame.size = CGSize(width: w * 2, height: w)
                self.button_red.center = CGPoint(x: w * 4, y: 0 + self.button_red.frame.height/2)
                self.button_red.layer.cornerRadius = 5
                self.button_red.alpha = 1
                }, completion: nil)
        
            
            UIView.animateWithDuration(1, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: [.CurveEaseOut], animations: {
                self.button_yellow.frame.size = CGSize(width: w, height: w * 2)
                self.button_yellow.center = CGPoint(x: self.view.bounds.width - self.button_yellow.frame.width/2, y: h * 3.5)
                self.button_yellow.layer.cornerRadius = 5
                self.button_yellow.alpha = 1
                
                }, completion: nil)
            
            UIView.animateWithDuration(1, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1,
                options: [.CurveEaseOut], animations: {
                    self.button_green.frame.size = CGSize(width: w, height: w * 2)
                    self.button_green.center = CGPoint(x: self.button_green.frame.width/2, y: h * 3.5)
                    self.button_green.layer.cornerRadius = 5
                    self.button_green.alpha = 1
                }, completion: nil )
            
            UIView.animateWithDuration(1, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 1,
                options: [.CurveEaseOut], animations: {
                    self.button_grey.frame.size = CGSize(width: w, height: w * 2)
                    self.button_grey.center = CGPoint(x: self.view.bounds.width - self.button_grey.frame.width/2, y: self.view.bounds.height - self.button_grey.frame.height/2)
                    self.button_grey.layer.cornerRadius = 5
                    self.button_grey.alpha = 1
                }, completion: nil)
        
            
            UIView.animateWithDuration(1, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 1,
                options: [.CurveEaseOut], animations: {
                    self.button_blue.frame.size = CGSize(width: w, height: w * 2)
                    self.button_blue.center = CGPoint(x: self.button_green.frame.width/2, y: self.view.bounds.height - self.button_blue.frame.height/2)
                    self.button_blue.layer.cornerRadius = 5
                    self.button_blue.alpha = 1
                    
                }, completion: nil)
        
    }
    
    func makeButtonsTransparent(){
       let buttons = [self.button_red, self.button_green, self.button_yellow, self.button_grey, self.button_blue]
        
        for button in buttons {
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                button.alpha = 0.3
            })
        }
        
    }
    
    func makeButtonsOpaque(){
        let buttons = [self.button_red, self.button_green, self.button_yellow, self.button_grey, self.button_blue]
        
        for button in buttons {
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                button.alpha = 1
            })
        }
        
    }
    
    //MARK: Show Messages
    
    func showMessages(index: Int) {
        
        UIView.animateWithDuration(0.33, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseOut, animations: { () -> Void in
            
            self.status.center.x += self.view.frame.size.width
            
            }, completion: { _ in
                
                self.status.hidden = true
                self.status.center.x -= self.view.frame.size.width
                self.label.text = self.messages[index]
                
                UIView.transitionWithView(self.status, duration: 0.3, options: [.CurveEaseOut, .TransitionCurlDown] , animations: { () -> Void in
                    self.status.hidden = false
                    self.view.bringSubviewToFront(self.status)
                    
                    }, completion: { _ in
                        
                        delay(seconds: 2.0, completion: {
                            if index < self.messages.count-1 {
                                
                                self.showMessages(index + 1)
                                
                            } else {
                                self.status.hidden = true
                            }
                        
                        })
                        
                        
                })
        })
    }
    
    //MARK: TableView
    func setUpTableView() {
        tableView.hidden = true
        tableView.alpha = 0
       
        tableView.frame.size = CGSize(width: self.view.bounds.width - 40, height: self.view.bounds.height - 40)
        tableView.center.x = self.view.center.x
        tableView.center.y = self.view.center.y + 40
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        tableView.tableHeaderView?.backgroundColor = UIColor.blueColor()
        view.addSubview(tableView)

    }
    
    func presentTableView(){
        sendButtonsAway()
        tableView.reloadData()
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: .CurveEaseInOut, animations: { () -> Void in
            self.tableView.hidden = false
            self.tableView.alpha = 1
            self.setUpDismissButton(self.tableView)
            }, completion: nil )
    }
    
    func setUpCollectionView(){
        
        collectionView.hidden = true
        collectionView.alpha = 0
        collectionView.frame.size = CGSize(width: self.view.bounds.width - 40, height: self.view.bounds.height - 40)
        collectionView.center.x = self.view.center.x
        collectionView.center.y = self.view.center.y
        collectionView.backgroundColor = UIColor.blueColor()
    
    }
    
    func presentCollectionView(){
        sendButtonsAway()
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: .CurveEaseInOut, animations: { () -> Void in
            self.collectionView.hidden = false
            self.collectionView.alpha = 1
            }, completion: nil )
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
        UIView.animateWithDuration(0.3) { () -> Void in
            superView!!.alpha = 0
        }
        bringInButtons()
    }
    
    func setUpHamburgerButton(){
        hamburgerButton.frame = CGRect(x: self.view.bounds.width - 60, y: 20, width: 50, height: 50)
        hamburgerButton.setImage((UIImage(named: "Hamburger")), forState: .Normal)
        hamburgerButton.addTarget(self, action: "hamburgerButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(hamburgerButton)
        
        self.popUpFromHamburger.frame = CGRect(x: (self.view.bounds.width), y: 70, width: 0, height: 0)
        popUpFromHamburger.alpha = 0
        popUpFromHamburger.layer.cornerRadius = 10
        popUpFromHamburger.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(popUpFromHamburger)
        
    }
    
    @IBAction func hamburgerButtonTapped(){
    
        if popUpFromHamburger.hidden == true {
            popUpFromHamburger.hidden = false
            self.view.bringSubviewToFront(popUpFromHamburger)
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
                self.popUpFromHamburger.frame = CGRect(x: (self.view.bounds.width/3), y: 70, width: (self.view.bounds.width/3) * 2, height: self.view.bounds.height - 90)
                self.popUpFromHamburger.alpha = 1
                }, completion: nil)
            self.makeButtonsTransparent()
        } else {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
                self.popUpFromHamburger.frame = CGRect(x: (self.view.bounds.width), y: 70, width: 0, height: 0)
                self.popUpFromHamburger.alpha = 1
                }, completion: nil)
            self.makeButtonsOpaque()
            popUpFromHamburger.hidden = true
        }
      
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetailView" {
            
            if let dvc: DetailViewController = segue.destinationViewController as? DetailViewController {

                   
            }
        }
    }

    
}

