//
//  VariousFunctions.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/16/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit


class VariousFunctions  {
    
    func expandAndDisappear(button: UIButton, view: UIView){
        UIView.animateWithDuration(0.5, delay: 0.2, options: .CurveEaseOut, animations: { () -> Void in
            button.center = view.center
            button.bounds.size.height = button.bounds.size.height * 10
            button.bounds.size.width = button.bounds.size.width * 10
            button.alpha = 0
            
            }, completion: nil )
        
    }
    
    
    
    
}

