//
//  Lines.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/24/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

class EM_Line: NSObject {
    
    var begin: CGPoint
    var end: CGPoint
    
    init(begin: CGPoint, end: CGPoint) {
        
        self.begin = begin
        self.end = end
    }

}
