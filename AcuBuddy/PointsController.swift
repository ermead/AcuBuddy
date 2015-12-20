//
//  PointsController.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/19/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation


class EM_PointsController {
    
    static let sharedInstance = EM_PointsController()
    
    var data: [Point] = []
    
    var points: [Point] {
        
        let lu1 = Point(channel: "LU", number: "1")
        let lu2 = Point(channel: "LU", number: "2")
        let lu3 = Point(channel: "LU", number: "3")
        
        let array = [lu1, lu2, lu3]
        
        self.data = array
        
        return array
    }
    
}