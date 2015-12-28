//
//  Image.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/27/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation


var kImageViewToPresent: UIImageView?


class Image: NSObject {
    
    var image: UIImage?
    
    convenience init(image: UIImage){
        
        self.init()
        self.image = image
    
    }
    
}