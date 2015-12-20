//
//  Point.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/19/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation

class Point {
    
    
    var channel: String?
    var number: String?
    
    convenience init(channel: String, number: String){
        
        self.init()
        
        self.channel = channel
        self.number = number
    }
    
    
    
    
}
