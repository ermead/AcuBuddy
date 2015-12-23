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
    var questions: [String] = []
    var answers: [String] = []
    
    var questions1 = ["From what is cognac made?", "what is 7 + 7?", "What is the capital of Vermont?"]
    var answers1 = ["Grapes", "14", "Montpelier"]
    
    func showQuestion(){
        
            self.currentQuestionIndex++
            if self.currentQuestionIndex == self.questions.count {
                self.currentQuestionIndex = 0;
            }
        
            let question = self.questions[self.currentQuestionIndex]
        
            self.label1.text = question
            self.label2.text = "???"
        
        
    }
    
    func showAnswer(){
        
        let answer = self.answers[self.currentQuestionIndex]
        self.label2.text = answer
    
        
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
        
        questions = questions1
        answers = answers1
        
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
    

    /*
 d
    
    @implementation QuizViewController
    
    -(IBAction)showQuestion:(id)sender
    {
    self.currentQuestionIndex++;
    if (self.currentQuestionIndex == [self.questions count]){
    self.currentQuestionIndex = 0;
    }
    NSString *question = self.questions[self.currentQuestionIndex];
    self.questionLabel.text = question;
    self.answerLabel.text = @"???";
    }
    
    -(IBAction)showAnswer:(id)sender
    {
    NSString *answer = self.answers[self.currentQuestionIndex];
    self.answerLabel.text = answer;
    }
    
    -(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
    {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)   {
    self.questions = @[@"From what is cognac made?", @"what is 7 + 7?", @"What is the capital of Vermont?"];
    self.answers = @[@"Grapes", @"14", @"Montpelier"];
    }
    return self;
    }
    @end
    */

}
