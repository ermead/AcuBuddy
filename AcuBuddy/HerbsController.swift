//
//  HerbsController.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/20/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation

class HerbsController {
    
    static let sharedInstance = HerbsController()
    
    var herbs: [Herb] {
        
        let guiZhi = Herb(name: "Gui Zhi")
        
        let array = [guiZhi]
        
        return array
    }
    
}