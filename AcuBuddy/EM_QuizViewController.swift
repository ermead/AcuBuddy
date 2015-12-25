//
//  ViewController.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/22/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

class EM_QuizViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var button2: UIButton!
    
    let dismissButton = UIButton()
    
    var currentQuestionIndex: Int = 0

    var QuestionsAndAnswers: NSDictionary = ["From what is cognac made?":"Grapes", "what is 7 + 7?": "14", "What is the capital of Vermont?": "Montpelier"]
    
    var thisAnswer: String?
    
    func showQuestion(){
        
        self.currentQuestionIndex++
        
        let allKeys = self.QuestionsAndAnswers.allKeys
        
        if self.currentQuestionIndex == allKeys.count {
            self.currentQuestionIndex = 0;
        }
        let key = allKeys[self.currentQuestionIndex] as! String
        let answer = self.QuestionsAndAnswers[key] as! String
        self.thisAnswer = answer
        
        self.label1.text = key
        self.label2.text = "???"
        
    }
    
    func showAnswer(){
         self.label2.text = self.thisAnswer
        
    }
    
    
    @IBAction func button1Tapped(sender: AnyObject) {
        //show question
        showQuestion()
    }
    
    @IBAction func button2Tapped(sender: AnyObject) {
        //show answer
        showAnswer()
    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setUpDismissButton(self.view)

        // Do any additional setup after loading the view.
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
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.postNotificationName(dismissNotification, object: self)
        UIView.animateWithDuration(0.3) { () -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
    }

}
