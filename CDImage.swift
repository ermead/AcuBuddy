//
//  Image.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/27/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation
import CoreData


class CDImage: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    convenience init(reference: String?, imageData: NSData?){
        
        self.init()
        self.reference = reference
        self.image = imageData
    }

}
