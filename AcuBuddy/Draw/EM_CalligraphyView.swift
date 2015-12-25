//
//  CalligraphyView.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/24/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

class EM_CalligraphyView: UIView, UIGestureRecognizerDelegate {

    static let sharedInstance = EM_CalligraphyView()
    
    let tapRecognizer = UITapGestureRecognizer()
    let moveRecognizer = UIPanGestureRecognizer()
    let pressRecognizer = UILongPressGestureRecognizer()
    let doubleTapRecognizer = UITapGestureRecognizer()
    var linesInProgress = NSMutableDictionary()
    var finishedLines = NSMutableArray()
    var selectedLine = EM_Line?()
    
    convenience init (linesInProgress: NSMutableDictionary?, finishedLines: NSMutableArray?) {
        
        self.init()
        
        //self.linesInProgress = linesInProgress
        //self.finishedLines = finishedLines
        self.backgroundColor = UIColor.lightGrayColor()
        self.multipleTouchEnabled = true
        
        
        doubleTapRecognizer.addTarget(self, action: "doubleTap:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        
        self.addGestureRecognizer(doubleTapRecognizer)
        
        tapRecognizer.addTarget(self, action: "tap:")
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
        self.addGestureRecognizer(tapRecognizer)
        
        pressRecognizer.addTarget(self, action: "longPress:")
        self.addGestureRecognizer(pressRecognizer)
        
        
        self.moveRecognizer.addTarget(self, action: "moveLine:")
        self.moveRecognizer.delegate = self
        self.moveRecognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(self.moveRecognizer)
        
        
    }
    
    func lineAtPoint (p: CGPoint) -> EM_Line? {
        
        for line in self.finishedLines {
            
            let start: CGPoint = line.begin
            let end: CGPoint = line.end
            
            for var i: CGFloat = 0.0; i <= 1.0; i += 0.05 {
                
                let x: CGFloat = start.x + (i * (end.x - start.x))
                let y: CGFloat = start.y  + (i * (end.y - start.y))
                
                if (hypot(x-p.x, y - p.y) < 20.0) {
                    return line as! EM_Line
                }
            }
        }
        return nil
    }
    
    
    func doubleTap (gr: UITapGestureRecognizer) {
        print("Recognized Double Tap")
        self.linesInProgress.removeAllObjects()
        self.finishedLines.removeLastObject()
        self.setNeedsDisplay()
    }
    
    
    func tap (gr: UITapGestureRecognizer){
    
        print("Recognized tap")
    
        let point: CGPoint  = gr.locationInView(self)
        self.selectedLine = self.lineAtPoint(point)
    
        if self.selectedLine != nil {
            self.becomeFirstResponder()
            let menu = UIMenuController.sharedMenuController()
            let deleteItem = UIMenuItem.init(title: "Delete", action: "deleteLine")
            menu.menuItems = [deleteItem]
            menu.setTargetRect(CGRectMake(point.x, point.y, 2, 2), inView: self)
            menu.setMenuVisible(true, animated: true)
            
            } else {
            
            UIMenuController.sharedMenuController().setMenuVisible(false, animated: true)
            
            }
    
            self.setNeedsDisplay()
    }
    
    func deleteLine(){
        
        self.finishedLines.removeObject(self.selectedLine!)
        self.setNeedsDisplay()
        
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == self.moveRecognizer {
            return true
        } else {
            return false
        }
        
    }
    
    func longPress( gr: UILongPressGestureRecognizer) {
    
        if gr.state == UIGestureRecognizerState.Began {
            
            let point: CGPoint = gr.locationInView(self)
            
            self.selectedLine = self.lineAtPoint(point)
    
            if self.selectedLine != nil {
                self.linesInProgress.removeAllObjects()
            }
            
        } else if gr.state == UIGestureRecognizerState.Ended {
            
            self.selectedLine = nil
            
            }
        
        self.setNeedsDisplay()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        for t: UITouch in touches {
            
            let location: CGPoint = t.locationInView(self)
            let line = EM_Line(begin: location, end: location)
            let key: NSValue = NSValue(nonretainedObject: t)
            self.linesInProgress[key] = line

        }
    
        self.setNeedsDisplay()
    
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for t: UITouch in touches {
            
            let key: NSValue = NSValue(nonretainedObject: t)
            let line = self.linesInProgress[key] as! EM_Line
            line.end = t.locationInView(self)
            
        }
        
        self.setNeedsDisplay()
        
        
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for t: UITouch in touches {
            
            let key: NSValue = NSValue(nonretainedObject: t)
            let line = self.linesInProgress[key]
            self.finishedLines.addObject(line!)
            self.linesInProgress.removeObjectForKey(key)
            
        }
        
        self.setNeedsDisplay()
        
    }
    
    
    func strokeLine(line: EM_Line) {
    
        let bp = UIBezierPath()
        bp.lineWidth = 10
        bp.lineCapStyle = CGLineCap.Round
        bp.moveToPoint(line.begin)
        bp.addLineToPoint(line.end)
        bp.stroke()
    
    }
    
    override func drawRect(rect: CGRect){

        UIColor.blackColor().set()
        
        for line in self.finishedLines{
            
           self.strokeLine(line as! EM_Line)
            
        }
        
        UIColor.redColor().set()
        
        for key in self.linesInProgress {
            
//            let line = self.linesInProgress[key as! NSValue]
//            
//            self.strokeLine(line as! EM_Line)
            
        }
        
        
        if self.selectedLine != nil {
            UIColor.greenColor().set()
            
            self.strokeLine(self.selectedLine!)
        }
  
    }
    
    
    func moveLine(gr: UIPanGestureRecognizer){
        
        if self.selectedLine == nil {
            return
        }
        
        if gr.state == UIGestureRecognizerState.Changed {
            
            let translation: CGPoint = gr.translationInView(self)
            var begin = self.selectedLine?.begin
            var end = self.selectedLine?.end
            
            begin!.x += translation.x
            begin!.y += translation.y
            
            end!.x += translation.x
            end!.y += translation.y
            
            self.selectedLine?.begin = begin!
            self.selectedLine?.end = end!
            
            self.setNeedsDisplay()
            
            gr.setTranslation(CGPoint.zero, inView: self)
        }
            
        
        
    }
   
}
