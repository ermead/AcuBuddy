//
//  DetailViewController.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/17/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

var kEntry: AnyObject?

class DetailViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    
    var entry: AnyObject?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var containerView: UIView!
    
    var label1 = UILabel()
    var label2 = UILabel()
    var label3 = UILabel()
    var label4 = UILabel()
    var label5 = UILabel()
    var label6 = UILabel()
    var label7 = UILabel()
    var label8 = UILabel()
    var label9 = UILabel()
    
    let dismissButton = UIButton()
    
    /*
    label1
    label2
    label3
    label4
    label5
    label6
    label7
    label8
    label9
    */
    
    var text1 = "Lorem ipsum"
    var text2 = "Lorem ipsum"
    var text3 = "Lorem ipsum"
    var text4 = "In vel."
    var text5 = "Lorem ipsum"
    var text6 = "Lorem ipsum"
    var text7 = "Lorem ipsum"
    var text8 = "In vel."
    var text9 = "In vel."
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
        entry = kEntry
        
        setUpEntry()
        
        setUpLabels()
        
        setUpDismissButton(self.view)
        
        containerView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        
        delay(seconds: 1) { () -> () in
            
            self.animateImageUpandDown()
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    func setUpEntry(){
        
        if let entry = entry as? Point {
            
            text1 = entry.channel! + "-" + entry.number!
            label1.textAlignment = NSTextAlignment.Center
        }
        
        if let entry = entry as? Herb {
            
            text1 = entry.name!
            label1.textAlignment = NSTextAlignment.Center
        }
        
    }
    
    func animateImageUpandDown(){
      
        UIView.animateWithDuration(5, animations: { () -> Void in
            
                self.containerView.frame = CGRect(x: 30, y: 50, width: self.view.frame.width - 30, height: 100)
            
                self.containerView.alpha = 1

            
            }, completion: { _ in
                
                self.containerView.alpha = 0
                self.containerView.frame = CGRect(x: 30, y: 200, width: self.view.frame.width - 30, height: 100)

                
                delay(seconds: 3, completion: { () -> () in
                    UIView.animateWithDuration(2, animations: { () -> Void in
                        
                        self.containerView.alpha = 1
                        
                        self.containerView.frame = CGRect(x: 30, y: 200, width: self.view.frame.width - 30, height: 100)
                        
                        }, completion: { _ in
                            self.containerView.alpha = 0
                            self.animateImageUpandDown()
                    })
                    
                    
                })
        
        })
        
        
    }
    
    func animateImageLeftandRight(){
        
        UIView.animateWithDuration(5, animations: { () -> Void in
            
            self.containerView.frame = CGRect(x: 30, y: 50, width: self.view.frame.width - 30, height: 100)
            
            self.containerView.alpha = 1
            
            
            }, completion: { _ in
                
                self.containerView.alpha = 0.5
                
                
                delay(seconds: 3, completion: { () -> () in
                    UIView.animateWithDuration(2, animations: { () -> Void in
                        
                        self.containerView.alpha = 1
                        self.containerView.frame.origin.x = self.view.frame.width
                        
                        }, completion: { _ in
                            self.animateImageUpandDown()
                    })
                    
                    
                })
                
        })
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
     
        label1.text = text1
        label2.text = text2
        label3.text = text3
        label4.text = text4
        label5.text = text5
        label6.text = text6
        label7.text = text7
        label8.text = text8
        label9.text = text9
        
        //setUpLabels()
        
        containerView.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        
        bringLabels()
        
        setUpLabelConstraints()
    }
    
    func setUpLabelConstraints(){
        let labels = [self.label1, self.label2, self.label3, self.collectionView, self.label4, self.label5, self.label6, self.label7, self.label8, self.label9]
        
        var constraints: [NSLayoutConstraint] = []
        
        for label in labels {
            
            let leading = NSLayoutConstraint(item: label, attribute: .Leading, relatedBy: .Equal, toItem: contentView, attribute: .Leading, multiplier: 1, constant: 10)
            
            let trailing = NSLayoutConstraint(item: label, attribute: .Trailing, relatedBy: .Equal, toItem: contentView, attribute: .Trailing, multiplier: 1, constant: -10)
            
            constraints.append(leading)
            constraints.append(trailing)
            
        }
        
        
        let topLabel = NSLayoutConstraint(item: label1, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 60)
        
        let topLabel2 = NSLayoutConstraint(item: label2, attribute: .Top, relatedBy: .Equal, toItem: label1, attribute: .Bottom, multiplier: 1, constant: 10)
        
        let topLabel3 = NSLayoutConstraint(item: label3, attribute: .Top, relatedBy: .Equal, toItem: label2, attribute: .Bottom, multiplier: 1, constant: 10)
        
        let topCollectionView = NSLayoutConstraint(item: collectionView, attribute: .Top, relatedBy: .Equal, toItem: label3, attribute: .Bottom, multiplier: 1, constant: 10)
        
        let topLabel4 = NSLayoutConstraint(item: label4, attribute: .Top, relatedBy: .Equal, toItem: collectionView, attribute: .Bottom, multiplier: 1, constant: 10)
        
        let topLabel5 = NSLayoutConstraint(item: label5, attribute: .Top, relatedBy: .Equal, toItem: label4, attribute: .Bottom, multiplier: 1, constant: 10)
        
        let topLabel6 = NSLayoutConstraint(item: label6, attribute: .Top, relatedBy: .Equal, toItem: label5, attribute: .Bottom, multiplier: 1, constant: 10)
        
        let topLabel7 = NSLayoutConstraint(item: label7, attribute: .Top, relatedBy: .Equal, toItem: label6, attribute: .Bottom, multiplier: 1, constant: 10)
        
        let topLabel8 = NSLayoutConstraint(item: label8, attribute: .Top, relatedBy: .Equal, toItem: label7, attribute: .Bottom, multiplier: 1, constant: 10)
        
        let topLabel9 = NSLayoutConstraint(item: label9, attribute: .Top, relatedBy: .Equal, toItem: label8, attribute: .Bottom, multiplier: 1, constant: 10)
        
        let bottomLabel9 = NSLayoutConstraint(item: label9, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1, constant: -30)
        
        constraints.append(topLabel)
        constraints.append(topLabel2)
        constraints.append(topLabel3)
        constraints.append(topCollectionView)
        constraints.append(topLabel4)
        constraints.append(topLabel5)
        constraints.append(topLabel6)
        constraints.append(topLabel7)
        constraints.append(topLabel8)
        constraints.append(topLabel9)
        constraints.append(bottomLabel9)
        
        self.view.addConstraints(constraints)
        
    }
    
    func setUpLabels(){
        
        let labels = [self.label1, self.label2, self.label3, self.label4, self.label5, self.label6, self.label7, self.label8, self.label9]
      
        for label in labels {
        
            label.frame.size.height = label.requiredHeight()
            label.frame.size.width = self.contentView.frame.width
            
        }
        collectionView.frame.size.height = 50
        collectionView.frame.size.width = self.contentView.frame.width
        
        
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        contentView.addSubview(label3)
        contentView.addSubview(collectionView)
        contentView.addSubview(label4)
        contentView.addSubview(label5)
        contentView.addSubview(label6)
        contentView.addSubview(label7)
        contentView.addSubview(label8)
        contentView.addSubview(label9)
        
        for label in labels {
            
            label.center.x += self.view.bounds.width
            label.alpha = 0
            
        }
        
        collectionView.center.x += self.view.bounds.width
        collectionView.alpha = 0
    }
    
    func bringLabels(){
        
        let labels = [self.label1, self.label2, self.label3, self.collectionView, self.label4, self.label5, self.label6, self.label7, self.label8, self.label9]
        
        for label in labels {
            
            var delay = 0.1
            
            UIView.animateWithDuration(1, delay: delay, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: [.CurveEaseInOut], animations: { () -> Void in
                
                label.center.x -= self.view.bounds.width
                label.alpha = 1
                delay += 0.5
                
                }, completion: nil )
          
        }
        
    }
    
    
    //MARK: Collection View
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as? DetailCollectionViewCell
        
        cell?.imageView.image = UIImage(named: "InnerClassic")
        
        
        return cell!
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath)
        
    }
    
    func setUpDismissButton(view: UIView){
        
        dismissButton.frame = CGRect(x: 5, y: 15, width: 40, height: 40)
        dismissButton.setTitle("X", forState: .Normal)
        dismissButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        dismissButton.backgroundColor = UIColor.lightGrayColor()
        dismissButton.addTarget(self, action: "dismissButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(dismissButton)
    }
    
    @IBAction func dismissButtonTapped(sender: AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}

extension UILabel{
    
    func requiredHeight() -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, self.frame.width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        
        return label.frame.height
    }
}
