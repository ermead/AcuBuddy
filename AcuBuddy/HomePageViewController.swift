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
    
    var pastValues: [AnyObject] = []
    var i = 0
    
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    var buttonOriginalWidth: CGFloat?
    var buttonOriginalHeight: CGFloat?
    
    let array1 = ["Fire", "Earth", "Metal", "Water", "Wood"]
    let array2 = ["Moxa", "Diet", "Acupuncture", "Microsystems", "Herbs"]
    
    // MARK: IB outlets
    
    let undoButton = UIButton()
    let actionButton = UIButton()
    
    let popUpButton1 = UIButton()
    let popUpButton2 = UIButton()
    let popUpButton3 = UIButton()
    let popUpButton4 = UIButton()
    let popUpButton5 = UIButton()
    let popUpButton6 = UIButton()
    let popUpButton7 = UIButton()
    let popUpButton8 = UIButton()
    
    let button_red = UIButton()
    let button_yellow = UIButton()
    let button_grey = UIButton()
    let button_blue = UIButton()
    let button_green = UIButton()
    
    var allButtons: [UIButton] = []
    
    let bottomTabBarButton = UIButton()
    let tabBarButtonLeft = UIButton()
    let tabBarButtonRight = UIButton()
    
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
    let messages1 = ["Generating Cycle"]
    let messages2 = ["Controlling Cycle"]
    
    let dismissButton = UIButton()
    let hamburgerButton = UIButton()
    let popUpFromHamburger = UIView()
    let tabBar = UIView()
    
    let shadow = UIView()

    
    // MARK: view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up the UI
        
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
        setUpUndoButton()
        setUpActionButton()
        setUpBottomTabBarButton()
        
        setUpTableView()
        
        
        
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
            delay(seconds: 0.5, completion: { () -> () in
                self.setButtonsLikeStar()
            })
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
        storeBackFunctions()
        showMessages(0, arrayOfMessages: messages)
        VariousFunctions().expandAndDisappear(sender as! UIButton, view: self.view)
        delay(seconds: 3, completion: { _ in
            
            self.setButtonsLikeStar()
            
        })
    }
    
    @IBAction func greenButtonTapped(sender: AnyObject) {
        storeBackFunctions()
        self.moveButtonsToEdges()
        delay(seconds: 1, completion: { _ in
            self.makeButtonsTransparent()
        })
        
        delay(seconds: 3, completion: { _ in
            
            //self.bringInButtons()
        })
    }
    
    @IBAction func yellowButtonTapped(sender: AnyObject) {
        storeBackFunctions()
        //presentTableView()
     
    }
 
    @IBAction func greyButtonTapped(sender: AnyObject) {
        storeBackFunctions()
        self.moveButtonsToLeftEdge()
        self.setButtonTitles(array2)
        
        delay(seconds: 3, completion: { _ in
            
            //self.bringInButtons()
        })
    }
    
    @IBAction func blueButtonTapped(sender: AnyObject) {
        storeBackFunctions()
        
        bringButtonsToCenter()
        
        delay(seconds: 1, completion: { _ in
            self.expandAsStack()
        })
        delay(seconds: 3, completion: { _ in
            
            //self.bringInButtons()
        })
        
    }
    
    //MARK: setup Main Buttons UI
    
    func setUpButtons(){
        
        /*
        button_red
        button_yellow
        button_grey
        button_blue
        button_green
        */
        self.allButtons = [self.button_red, self.button_yellow, self.button_blue, self.button_grey, self.button_green]
        
        for button in allButtons {
            button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            button.layer.borderColor = UIColor.blackColor().CGColor
            button.layer.borderWidth = 1
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.layer.shadowColor = UIColor.darkGrayColor().CGColor
            button.layer.shadowOffset = CGSizeMake(5,5)
            button.layer.masksToBounds = false
            button.layer.shadowRadius = 5.0
            button.layer.shadowOpacity = 0
            
        }
        
        button_red.backgroundColor = Colors.red
        button_yellow.backgroundColor = Colors.yellow
        button_grey.backgroundColor = Colors.grey
        button_blue.backgroundColor = Colors.blue1
        button_green.backgroundColor = Colors.green
        
        self.setButtonTitles(array1)
        
        
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
        
        if tabBar.hidden == false {
            let buttonYpositions = [self.button_red,self.button_yellow, self.button_green, self.button_grey, self.button_blue].sort({$0.frame.origin.y > $1.frame.origin.y})
            let twoBottomButtons = [buttonYpositions[0], buttonYpositions[1]]
            
            for button in twoBottomButtons{
                
                button.frame.origin.y -= (self.view.frame.size.height/8)
            }            
        }
        
    }
    
    func setButtonsLikeStar() {
        let titles = ["Fire", "Earth", "Metal", "Water", "Wood"]
        setButtonTitles(titles)
        
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
            self.button_yellow.center = CGPoint(x: w * 7, y: h * 3.5)
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
                self.button_green.center = CGPoint(x: w * 1, y: h * 3.5)
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
                self.button_grey.center = CGPoint(x: w * 7, y: h * 7)
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
                self.button_blue.center = CGPoint(x: w * 1, y: h * 7)
                self.button_blue.layer.cornerRadius = 15
                self.button_blue.alpha = 1
                
            }, completion: {_ in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.button_blue.alpha = 1
                })
                
        })
        for button in allButtons {
            
            updateShadowWithOffset(button)
        }
     
        
    }
    
    func controllingCycle(){
        showMessages(0, arrayOfMessages: messages2)

        _ = [self.button_red, self.button_grey, self.button_green, self.button_yellow, self.button_blue]
        
        let newRedFrame = self.button_grey.frame
        let newGreyFrame = self.button_green.frame
        let newGreenFrame = self.button_yellow.frame
        let newYellowFrame = self.button_blue.frame
        let newBlueFrame = self.button_red.frame
   
        UIView.animateWithDuration(1, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.button_red.frame = newRedFrame
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.button_grey.frame = newGreyFrame
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.7, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.button_green.frame = newGreenFrame
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.button_yellow.frame = newYellowFrame
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 1.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.button_blue.frame = newBlueFrame
            }, completion: nil)
        

    }
    
    func generatingCycle(){
        
        showMessages(0, arrayOfMessages: messages1)
        
        _ = [self.button_red, self.button_grey, self.button_green, self.button_yellow, self.button_blue]
        
        let newRedFrame = self.button_yellow.frame
        let newYellowFrame = self.button_grey.frame
        let newGreyFrame = self.button_blue.frame
        let newBlueFrame = self.button_green.frame
        let newGreenFrame = self.button_red.frame
        
        UIView.animateWithDuration(1, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.button_red.frame = newRedFrame
            }, completion: nil)
        
        UIView.animateWithDuration(1, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.button_yellow.frame = newYellowFrame
            }, completion: nil)
        
        UIView.animateWithDuration(1, delay: 0.7, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.button_grey.frame = newGreyFrame
            }, completion: nil)
      
        UIView.animateWithDuration(1, delay: 1, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.button_blue.frame = newBlueFrame
            }, completion: nil)
        
        UIView.animateWithDuration(1, delay: 1.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.button_green.frame = newGreenFrame
            }, completion: nil)
        
        
    }
    
    func setButtonTitles(femww_ArrayofTitles: [String]){
        
        let buttons = [self.button_red, self.button_yellow, self.button_grey, self.button_blue, self.button_green]
        var i = 0
        for button in buttons{
            button.setTitle(femww_ArrayofTitles[i], forState: .Normal)
            button.titleLabel!.numberOfLines = 1
            button.titleLabel!.adjustsFontSizeToFitWidth = true
            button.titleLabel?.lineBreakMode = NSLineBreakMode.ByClipping
            i++
        }
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
        let titles = ["Heat", "Dampness", "Dryness", "Cold", "Wind"]
        setButtonTitles(titles)
        
        let buttons = [self.button_red, self.button_green, self.button_yellow, self.button_grey, self.button_blue]
        var delay = 0.1
        var offSetY = CGFloat(5)
        for button in buttons{
            UIView.animateWithDuration(0.5, delay: delay, options: .CurveEaseInOut, animations: { () -> Void in
               
                button.center.x = self.view.center.x
                button.center.y = button.frame.size.height + 10 + offSetY
                delay += 0.1
                offSetY += button.frame.size.height + CGFloat(5)
                }, completion: {_ in
                  UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
                    
                    if button.frame.size.width == self.buttonOriginalWidth! {
                        button.frame.size.width = button.frame.size.width * 3
                    }
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
                button.center.y = button.frame.size.height + 10 + offSetY
                delay += 0.1
                offSetY += button.frame.size.height + CGFloat(5)
                }, completion: { _ in
                    
                    let titles = ["Moxa", "Diet", "Acupuncture", "Microsystems", "Herbs"]
                    self.setButtonTitles(titles)
            
            } )
            
        }
        
        
        
    }
    
    func moveButtonsToEdges(){
        
            let titles = ["Fire", "Earth", "Metal", "Water", "Wood"]
            setButtonTitles(titles)
        
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
    func showMessages(index: Int, arrayOfMessages: [String]) {
        
        let thisArrayOfMessages = arrayOfMessages
        
        UIView.animateWithDuration(0.33, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseOut, animations: { () -> Void in
            
            self.status.center.x += self.view.frame.size.width
            
            }, completion: { _ in
                
                self.status.hidden = true
                self.status.center.x -= self.view.frame.size.width
                self.label.text = thisArrayOfMessages[index]
                
                UIView.transitionWithView(self.status, duration: 0.3, options: [.CurveEaseOut, .TransitionCurlDown] , animations: { () -> Void in
                    self.status.hidden = false
                    self.view.bringSubviewToFront(self.status)
                    
                    }, completion: { _ in
                        
                        delay(seconds: 2.0, completion: {
                            if index < thisArrayOfMessages.count-1 {
                                
                                self.showMessages(index + 1, arrayOfMessages: thisArrayOfMessages)
                                
                            } else {
                                self.status.hidden = true
                            }
                        
                        })
                        
                        
                })
        })
    }
    
    //MARK: Undo
    func storeBackFunctions(){
        
        let buttons = [self.button_red, self.button_yellow, self.button_grey, self.button_blue, self.button_green]
        
        var arrayOfValues: [AnyObject] = []
        
        for button in buttons{
            let frame = NSValue(CGRect: button.frame)
            let title = button.titleLabel?.text
            let cornerRadius = button.layer.cornerRadius
            arrayOfValues.append(frame)
            arrayOfValues.append(title!)
            arrayOfValues.append(cornerRadius)
        }
        
        self.pastValues = arrayOfValues
    }
    
    func restoreToPastValues(){
        
        if pastValues.count < 15 {
            return
        }
        
        
        let buttons = [self.button_red, self.button_yellow, self.button_grey, self.button_blue, self.button_green]
        
        var arrayOfValues: [AnyObject] = []
        
        for button in buttons{
            let frame = NSValue(CGRect: button.frame)
            let title = button.titleLabel?.text
            let cornerRadius = button.layer.cornerRadius
            arrayOfValues.append(frame)
            arrayOfValues.append(title!)
            arrayOfValues.append(cornerRadius)
        }
        
        var i = 0
        
        for button in buttons{
            
            UIView.animateWithDuration(1, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: [], animations: { () -> Void in
                
                let value = self.pastValues[i] as! NSValue
                let rect = value.CGRectValue()
                button.frame = rect
                
                i++
                
                let stringTitle = self.pastValues[i] as! String
                
                button.setTitle(stringTitle, forState: .Normal)
                
                i++
                
                button.layer.cornerRadius = self.pastValues[i] as! CGFloat
                
                i++
                
                button.alpha = 1
                
                }, completion: nil )
        }
        
        self.pastValues = arrayOfValues
        
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
    
    //MARK: Various UI Buttons
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
    
    func setUpUndoButton(){
        undoButton.frame = CGRect(x: 5, y: 15, width: 40, height: 40)
        undoButton.setTitle("Undo", forState: .Normal)
        undoButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        undoButton.layer.cornerRadius = 3
        undoButton.layer.borderWidth = 1
        undoButton.layer.borderColor = UIColor.blackColor().CGColor
        undoButton.titleLabel!.numberOfLines = 1
        undoButton.titleLabel!.adjustsFontSizeToFitWidth = true
        undoButton.titleLabel?.lineBreakMode = NSLineBreakMode.ByClipping
        undoButton.backgroundColor = UIColor.lightGrayColor()
        undoButton.addTarget(self, action: "undoButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(undoButton)
        
    }
    
    @IBAction func undoButtonTapped(){
        
            restoreToPastValues()
        
    }
    
    func setUpActionButton(){
        
        actionButton.frame.size = CGSize(width: 80, height: 20)
        actionButton.center.x = self.view.center.x
        actionButton.center.y = 20
        actionButton.layer.cornerRadius = 5
        actionButton.backgroundColor = UIColor.lightGrayColor()
        actionButton.addTarget(self, action: "actionButtonTapped", forControlEvents: .TouchUpInside)
        view.addSubview(actionButton)
    }
    
    @IBAction func actionButtonTapped(){
        
        self.storeBackFunctions()
        
        let arrayOfactions = [self.generatingCycle, self.setButtonsLikeStar, self.controllingCycle, self.bringButtonsToCenter, self.expandAsStack, self.moveButtonsToLeftEdge, self.moveButtonsToEdges, self.setButtonsLikeStar]
        
        let action = arrayOfactions[i]
        
        self.i++
        
        if i == arrayOfactions.count {
            self.i = 0
        }
        
        action()
    
    }
    
    func setUpHamburgerButton(){
        
        hamburgerButton.frame = CGRect(x: self.view.bounds.width - 60, y: 20, width: 50, height: 50)
        hamburgerButton.setImage((UIImage(named: "Hamburger")), forState: .Normal)
        hamburgerButton.addTarget(self, action: "hamburgerButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(hamburgerButton)
        
        self.popUpFromHamburger.frame = CGRect(x: (self.view.bounds.width), y: 70, width: (self.view.bounds.width/3) * 2, height: self.view.bounds.height - 90)
        popUpFromHamburger.alpha = 0
        popUpFromHamburger.layer.cornerRadius = 10
        popUpFromHamburger.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(popUpFromHamburger)
        popUpFromHamburger.hidden = true
        
        self.setUpPopUpButtonsFromHamburger()

    }
    
    @IBAction func hamburgerButtonTapped(){
    
        if popUpFromHamburger.hidden == true {
            popUpFromHamburger.hidden = false
            
            self.view.bringSubviewToFront(popUpFromHamburger)
            
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
                self.popUpFromHamburger.frame = CGRect(x: (self.view.bounds.width/3) + 10, y: 70, width: (self.view.bounds.width/3) * 2 + 10, height: self.view.bounds.height - 90)
                self.popUpFromHamburger.alpha = 1
                }, completion: { _ in
                    
                    
            })
            
            self.makeButtonsTransparent()
            
        } else {
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
                self.popUpFromHamburger.frame = CGRect(x: (self.view.bounds.width), y: 70, width: (self.view.bounds.width/3) * 2 + 10, height: self.view.bounds.height - 90)
                self.popUpFromHamburger.alpha = 1
                }, completion: { _ in
                    self.popUpFromHamburger.hidden = true
            })
            self.makeButtonsOpaque()
            
        }
      
    }
    
    func setUpPopUpButtonsFromHamburger(){
        
        let offsetX = CGFloat(5)
        let offsetY = CGFloat(5)
        let width = popUpFromHamburger.frame.size.width - offsetX - 10
        let height = popUpFromHamburger.frame.size.height / 8 - ((offsetY * 2)/8)
       
        
        let popUpButtons = [popUpButton1, popUpButton2, popUpButton3, popUpButton4, popUpButton5, popUpButton6, popUpButton7, popUpButton8]
        
        popUpButton1.frame.origin.y = 0 + offsetY
        popUpButton2.frame.origin.y = height + offsetY
        popUpButton3.frame.origin.y = height * 2 + offsetY
        popUpButton4.frame.origin.y = height * 3 + offsetY
        popUpButton5.frame.origin.y = height * 4 + offsetY
        popUpButton6.frame.origin.y = height * 5 + offsetY
        popUpButton7.frame.origin.y = height * 6 + offsetY
        popUpButton8.frame.origin.y = height * 7 + offsetY
        
        popUpButton1.addTarget(self, action: "popUpButton1Tapped", forControlEvents: .TouchUpInside)
        popUpButton2.addTarget(self, action: "popUpButton2Tapped", forControlEvents: .TouchUpInside)
        popUpButton3.addTarget(self, action: "popUpButton3Tapped", forControlEvents: .TouchUpInside)
        popUpButton4.addTarget(self, action: "popUpButton4Tapped", forControlEvents: .TouchUpInside)
        popUpButton5.addTarget(self, action: "popUpButton5Tapped", forControlEvents: .TouchUpInside)
        popUpButton6.addTarget(self, action: "popUpButton6Tapped", forControlEvents: .TouchUpInside)
        popUpButton7.addTarget(self, action: "popUpButton7Tapped", forControlEvents: .TouchUpInside)
        popUpButton8.addTarget(self, action: "popUpButton8Tapped", forControlEvents: .TouchUpInside)
        
        popUpButton1.setTitle("button1", forState: .Normal)
        popUpButton2.setTitle("button2", forState: .Normal)
        popUpButton3.setTitle("button3", forState: .Normal)
        popUpButton4.setTitle("button4", forState: .Normal)
        popUpButton5.setTitle("button5", forState: .Normal)
        popUpButton6.setTitle("button6", forState: .Normal)
        popUpButton7.setTitle("button7", forState: .Normal)
        popUpButton8.setTitle("button8", forState: .Normal)
        
        for button in popUpButtons {
            
            button.frame.size = CGSize(width: width, height: height)
            button.backgroundColor = Colors.blue
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.whiteColor().CGColor
            button.frame.origin.x = offsetX
            button.alpha = 1
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            popUpFromHamburger.addSubview(button)
        }
        
    }
    
    func setUpBottomTabBarButton(){
      
        bottomTabBarButton.frame.size = CGSize(width: 80, height: 20)
        bottomTabBarButton.center.x = self.view.center.x
        bottomTabBarButton.frame.origin.y = self.view.frame.height - 15
        bottomTabBarButton.layer.cornerRadius = 5
        bottomTabBarButton.backgroundColor = UIColor.lightGrayColor()
        bottomTabBarButton.setTitle("▲", forState: .Normal)
        bottomTabBarButton.addTarget(self, action: "bottomTabBarButtonTapped", forControlEvents: .TouchUpInside)
        view.addSubview(bottomTabBarButton)
        
        tabBar.frame = CGRect(x: 0, y: self.view.frame.size.height, width: (self.view.bounds.width), height: self.view.frame.size.height/8)
        tabBar.backgroundColor = UIColor.grayColor()
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.blackColor().CGColor
        view.addSubview(tabBar)
        tabBar.hidden = true
        
        self.setUpTabBarButtons()
    }
    
    @IBAction func bottomTabBarButtonTapped(){
        
        if tabBar.hidden == true {
            tabBar.hidden = false
            
            self.view.bringSubviewToFront(tabBar)
            
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
                self.tabBar.frame.origin.y = (self.view.frame.size.height - (self.view.frame.size.height/8))
                
                self.bottomTabBarButton.frame.origin.y -= (self.tabBar.frame.size.height - 15)
                self.view.bringSubviewToFront(self.bottomTabBarButton)
                self.bottomTabBarButton.setTitle("▼", forState: .Normal)
                
                let buttonYpositions = [self.button_red,self.button_yellow, self.button_green, self.button_grey, self.button_blue].sort({$0.frame.origin.y > $1.frame.origin.y})
                let twoBottomButtons = [buttonYpositions[0], buttonYpositions[1]]
                
                for button in twoBottomButtons{
                    
                    button.frame.origin.y -= (self.view.frame.size.height/8)
                }
            
                }, completion: { _ in
                   //self.makeButtonsTransparent()
            })
            
            
            
        } else {
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
                
                self.tabBar.frame.origin.y = self.view.frame.size.height
                self.bottomTabBarButton.frame.origin.y += (self.tabBar.frame.size.height - 15)
                self.bottomTabBarButton.setTitle("▲", forState: .Normal)
                
                let buttonYpositions = [self.button_red,self.button_yellow, self.button_green, self.button_grey, self.button_blue].sort({$0.frame.origin.y > $1.frame.origin.y})
                
                let twoBottomButtons = [buttonYpositions[0], buttonYpositions[1]]

                for button in twoBottomButtons {
                        
                    button.frame.origin.y += (self.view.frame.size.height/8)
                        
                    }
                
                for button in self.allButtons {
    
                    if button.frame.origin.y + button.frame.size.height > self.view.bounds.height {
                        button.frame.origin.y = self.view.bounds.height - button.frame.size.height
                    }
                    
                    if button.frame.size.width > self.buttonOriginalWidth {
                        
                       self.expandAsStack()
                    }
                }
                
                
                }, completion: { _ in
                    self.tabBar.hidden = true
                    //self.makeButtonsOpaque()
            })
            
            
            
        }
        
        
    }
    
    func setUpTabBarButtons(){
        tabBarButtonLeft.frame.origin.y = 5
        tabBarButtonRight.frame.origin.y = 5
        tabBarButtonLeft.frame.size.width = (self.tabBar.frame.size.width / 3) - 5
        tabBarButtonRight.frame.size.width = (self.tabBar.frame.size.width / 3) - 5
        tabBarButtonLeft.frame.size.height = self.tabBar.frame.size.height - 7
        tabBarButtonRight.frame.size.height = self.tabBar.frame.size.height - 7
        tabBarButtonLeft.center.x = self.tabBar.frame.size.width / 6
        tabBarButtonRight.center.x = (self.tabBar.frame.size.width / 6) * 5
        tabBarButtonLeft.backgroundColor = Colors.blue
        tabBarButtonRight.backgroundColor = Colors.blue
        tabBarButtonLeft.layer.borderColor = UIColor.whiteColor().CGColor
        tabBarButtonLeft.layer.borderWidth = 1
        tabBarButtonRight.layer.borderColor = UIColor.whiteColor().CGColor
        tabBarButtonRight.layer.borderWidth = 1
        tabBarButtonLeft.layer.cornerRadius = 3
        tabBarButtonRight.layer.cornerRadius = 3
        tabBarButtonLeft.setTitle("Points", forState: .Normal)
        tabBarButtonRight.setTitle("Herbs", forState: .Normal)
        tabBarButtonLeft.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        tabBarButtonRight.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        tabBarButtonLeft.addTarget(self, action: "leftTabBarButtonTapped", forControlEvents: .TouchUpInside)
        tabBarButtonRight.addTarget(self, action: "rightTabBarButtonTapped", forControlEvents: .TouchUpInside)
        tabBar.addSubview(tabBarButtonLeft)
        tabBar.addSubview(tabBarButtonRight)
    }
    
    //MARK: PopUpButton Functions
    
    @IBAction func popUpButton1Tapped(){
        print("1 tapped")
    }
    @IBAction func popUpButton2Tapped(){
        print("2 tapped")
    }
    @IBAction func popUpButton3Tapped(){
        print("3 tapped")
    }
    @IBAction func popUpButton4Tapped(){
        print("4 tapped")
    }
    @IBAction func popUpButton5Tapped(){
        print("5 tapped")
    }
    @IBAction func popUpButton6Tapped(){
        print("6 tapped")
    }
    @IBAction func popUpButton7Tapped(){
        print("7 tapped")
    }
    @IBAction func popUpButton8Tapped(){
        print("8 tapped")
    }
    
    //MARK: TabBarButton Functions
    
    @IBAction func leftTabBarButtonTapped() {
        print("left tab")
        
        PointsController.sharedInstance.data = ["pointA", "pointB","pointC","pointD","pointE"]
        tableView.reloadData()
        presentTableView()
    }
    
    @IBAction func rightTabBarButtonTapped() {
        print("right tab")
        
        PointsController.sharedInstance.data = ["herbA", "herbB","herbC","herbD","herbE"]
        tableView.reloadData()
        presentTableView()
    }
    
    func updateShadowWithOffset(viewWithShadow: UIView){
        
        var offSetY: CGFloat?
        var offSetX: CGFloat?
        
        let lightSource: CGPoint = CGPoint(x: self.view.center.x, y: 0)
        let viewX = viewWithShadow.center.x
        let viewY = viewWithShadow.frame.origin.y
        let distanceX = viewX - lightSource.x
        let distanceY = viewY - lightSource.y

        offSetX = distanceX * 0.1
       // offSetY = distanceY * 0.1
        offSetY = 5
        
        viewWithShadow.layer.shadowOffset = CGSizeMake(offSetX!,offSetY!)
        //viewWithShadow.layer.shadowOpacity = 1 - Float(Double(distanceY) * 0.005)
    }
    
    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetailView" {
            
            if let dvc: DetailViewController = segue.destinationViewController as? DetailViewController {

                   
            }
        }
    }

    
}

