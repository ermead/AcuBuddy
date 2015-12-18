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
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    @IBOutlet weak var label9: UILabel!
    
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
    
        self.view.alpha = 1
        
                label1.text = "Name1"
                label2.text = "Name2"
                label3.text = "Name3"
                label4.text = "Name4"
                label5.text = "Name5"
                label6.text = "Name6"
                label7.text = text2
                label8.text = text3
                label9.text = "End"
        
        
        let labels = [self.label1, self.label2, self.label3, self.label4, self.label5, self.label6, self.label7, self.label8, self.label9]
        
       
        label1.translatesAutoresizingMaskIntoConstraints = true
        //label1.center.y -= 100
        label1.center.x += self.view.bounds.width
        label1.frame.size.height = label1.requiredHeight()
        label1.alpha = 0
        
        label2.translatesAutoresizingMaskIntoConstraints = true
        label2.center.x += self.view.bounds.width
        label2.frame.size.height = label2.requiredHeight()
        label2.alpha = 0
        
        label3.translatesAutoresizingMaskIntoConstraints = true
        label3.center.x += self.view.bounds.width
        label3.frame.size.height = label3.requiredHeight()
        label3.alpha = 0
        
        label4.translatesAutoresizingMaskIntoConstraints = true
        label4.frame.size.height = label4.requiredHeight()
        label4.alpha = 0
        
        label5.translatesAutoresizingMaskIntoConstraints = true
        label5.frame.size.height = label5.requiredHeight()
        label5.alpha = 0

        label6.translatesAutoresizingMaskIntoConstraints = true
        label6.frame.size.height = label6.requiredHeight()
        label6.alpha = 0
        
        label7.translatesAutoresizingMaskIntoConstraints = true
        label7.frame.size.height = label7.requiredHeight()
        label7.alpha = 0
        
        label8.translatesAutoresizingMaskIntoConstraints = true
        label8.frame.size.height = label8.requiredHeight()
        label8.alpha = 0
        
        label9.translatesAutoresizingMaskIntoConstraints = true
        label9.frame.size.height = label9.requiredHeight()
        label9.alpha = 0
      
    
    }
    
    override func viewDidAppear(animated: Bool) {
        
        bringLabels()
    }
    
    func bringLabels(){
        
        UIView.animateWithDuration(1, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.label1.alpha = 1
            self.label1.translatesAutoresizingMaskIntoConstraints = true
            //self.label1.center.y += 100
            self.label1.center.x -= self.view.bounds.width
            
            }, completion: { _ in
                self.label1.translatesAutoresizingMaskIntoConstraints = false
        } )
        
        UIView.animateWithDuration(1, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.label2.alpha = 1
            self.label2.translatesAutoresizingMaskIntoConstraints = true
            self.label2.center.x -= self.view.bounds.width
            
            }, completion: { _ in
                self.label2.translatesAutoresizingMaskIntoConstraints = false
        } )
        
       
        UIView.animateWithDuration(1, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.label3.alpha = 1
            self.label3.translatesAutoresizingMaskIntoConstraints = true
            self.label3.center.x -= self.view.bounds.width
            
            }, completion: { _ in
                self.label3.translatesAutoresizingMaskIntoConstraints = false
        } )
        
        self.label4.translatesAutoresizingMaskIntoConstraints = false
        self.label5.translatesAutoresizingMaskIntoConstraints = false
        self.label6.translatesAutoresizingMaskIntoConstraints = false
        self.label7.translatesAutoresizingMaskIntoConstraints = false
        self.label8.translatesAutoresizingMaskIntoConstraints = false
        self.label9.translatesAutoresizingMaskIntoConstraints = false
        
        UIView.animateWithDuration(3, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.label4.alpha = 1
            self.label5.alpha = 1
            self.label6.alpha = 1
            self.label7.alpha = 1
            self.label8.alpha = 1
            self.label9.alpha = 1
            }, completion: { _ in
               
        } )
        
       
        
        
        
    }
    

    func bringInLabels(){
       
        UIView.animateWithDuration(1) { () -> Void in
            self.view.alpha = 1
        }
        
        let labels = [self.label1, self.label2, self.label3, self.label4, self.label5, self.label6, self.label7, self.label8, self.label9]
    
        let strings = ["Name", text2, "Header2", text3, "Header 3", text, text2, text3, "End"]

        
        var delay = 0.1
        var i = 0
        for label in labels {
            
            UIView.animateWithDuration(1, delay: delay, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
                    label.text = strings[i]
                    label.translatesAutoresizingMaskIntoConstraints = true
                    label.center.x += self.view.bounds.width
                    label.frame.size.height = label.requiredHeight()
                    label.alpha = 1
                    delay += 0.2
                    i++
                }, completion: { _ in
                    for label in labels{
                    label.translatesAutoresizingMaskIntoConstraints = false
                    }
            })
            
        }
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
