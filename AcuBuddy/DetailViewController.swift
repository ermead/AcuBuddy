//
//  DetailViewController.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/17/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
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
    
    let text = "Lorem ipsum dolor sit amet, ei odio omittantur pri, cu vidisse moderatius vis, mea id debet omnium laoreet. Ne dicat augue eos, apeirian voluptaria id qui. Mei audire aperiri diceret ea. Ne stet tota eos, mei cu purto nominavi, at sed esse corpora maluisset. His purto simul apeirian ea.\n Definiebas reprimique te ius, ad pro rebum dictas. Pro nihil epicurei tincidunt ne, est oratio invidunt disputationi et. Tale invenire eum an, facilis suscipiantur ex quo, nec tota vocent ei. Nam ei utroque definiebas, ea agam vivendo consequat mei, eum ne quaerendum repudiandae. Nam doctus vituperatoribus in, ex sit dignissim vituperata, an eos viris tantas. Te facilisi electram aliquando eos. \n An per prompta fabellas explicari, usu mucius malorum definitiones in. In vel partiendo ocurreret, has cibo gloriatur constituto ea, et eos alii animal. Ad oportere urbanitas vim, sed eu unum probo timeam. Vel omnium erroribus incorrupte an, duo ad euismod mediocrem reprimique, pri eu duis torquatos abhorreant. \n Et malis prodesset vis, per illum utamur sanctus te. Feugait postulant mnesarchum eu eam, te vim accusata assueverit. Id sit modus decore fuisset. Offendit perfecto repudiandae ne vix."
    
    let text2 = "Lorem ipsum dolor sit amet, ei odio omittantur pri, cu vidisse moderatius vis, mea id debet omnium laoreet. Ne dicat augue eos, apeirian voluptaria id qui. Mei audire aperiri diceret ea. Ne stet tota eos, mei cu purto nominavi, at sed esse corpora maluisset. His purto simul apeirian ea.\n Definiebas reprimique te ius, ad pro rebum dictas. Pro nihil epicurei tincidunt ne, est oratio invidunt disputationi et."
    
    let text3 = "In vel partiendo ocurreret, has cibo gloriatur constituto ea, et eos alii animal. Ad oportere urbanitas vim, sed eu unum probo timeam. Vel omnium erroribus incorrupte an, duo ad euismod mediocrem reprimique, pri eu duis torquatos abhorreant. \n Et malis prodesset vis, per illum utamur sanctus te."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
        setUpDismissButton(self.view)
      
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
     
        label1.text = "Name1"
        label2.text = "Name2"
        label3.text = text
        label4.text = "Name4"
        label5.text = "Name5"
        label6.text = "Name6"
        label7.text = text2
        label8.text = text3
        label9.text = "End"
        
        setUpLabels()
        
  
    }
    
    override func viewDidAppear(animated: Bool) {
        
        bringLabels()
        
        setUpLabelConstraints()
    }
    
    func setUpLabelConstraints(){
        let labels = [self.label1, self.label2, self.label3, self.label4, self.label5, self.label6, self.label7, self.label8, self.label9]
        
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
        
        let topLabel4 = NSLayoutConstraint(item: label4, attribute: .Top, relatedBy: .Equal, toItem: label3, attribute: .Bottom, multiplier: 1, constant: 10)
        
        let topLabel5 = NSLayoutConstraint(item: label5, attribute: .Top, relatedBy: .Equal, toItem: label4, attribute: .Bottom, multiplier: 1, constant: 10)
        
        let topLabel6 = NSLayoutConstraint(item: label6, attribute: .Top, relatedBy: .Equal, toItem: label5, attribute: .Bottom, multiplier: 1, constant: 10)
        
        let topLabel7 = NSLayoutConstraint(item: label7, attribute: .Top, relatedBy: .Equal, toItem: label6, attribute: .Bottom, multiplier: 1, constant: 10)
        
        let topLabel8 = NSLayoutConstraint(item: label8, attribute: .Top, relatedBy: .Equal, toItem: label7, attribute: .Bottom, multiplier: 1, constant: 10)
        
        let topLabel9 = NSLayoutConstraint(item: label9, attribute: .Top, relatedBy: .Equal, toItem: label8, attribute: .Bottom, multiplier: 1, constant: 10)
        
        let bottomLabel9 = NSLayoutConstraint(item: label9, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1, constant: 10)
        
        constraints.append(topLabel)
        constraints.append(topLabel2)
        constraints.append(topLabel3)
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
        
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        contentView.addSubview(label3)
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
        
      
    }
    
    func bringLabels(){
        
        let labels = [self.label1, self.label2, self.label3, self.label4, self.label5, self.label6, self.label7, self.label8, self.label9]
        
        for label in labels {
            
            var delay = 0.1
            
            UIView.animateWithDuration(1, delay: delay, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: [.CurveEaseInOut], animations: { () -> Void in
                
                label.center.x -= self.view.bounds.width
                label.alpha = 1
                delay += 0.1
                
                }, completion: nil )
          
        }
        
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
