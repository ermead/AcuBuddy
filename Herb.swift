//
//  Herb.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/27/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation
import CoreData

@objc(Herb)
class Herb: NSManagedObject {
    
    // Insert code here to add functionality to your managed object subclass
    
    convenience init(pinyinName: String? = nil, pharmName: String? = nil, commonName: String? = nil, botanicalName: String? = nil, englishName: String?, chineseCharacter: String? = nil, category: String? = nil, temp: String? = nil, meridians: String? = nil, uses: String? = nil, uses1: String? = nil, earliestRecord: String? = nil, gatheringInfo: String? = nil, dosage: String? = nil, majorFormulas: String? = nil, images: NSSet? = [], context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Herb", inManagedObjectContext: context)
        
        self.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        self.pinyinName = pinyinName
        self.pharmName = pharmName
        self.commonName = commonName
        self.botanicalName = botanicalName
        self.englishName = englishName
        self.chineseCharacter = chineseCharacter
        self.category = category
        self.temp = temp
        self.meridians = meridians
        self.uses = uses
        self.uses1 = uses1
        self.earliestRecord = earliestRecord
        self.gatheringInfo = gatheringInfo
        self.dosage = dosage
        self.majorFormulas = majorFormulas
        //self.images = images
        
    }
    
    func completeDetails() -> String{
        
        return "\(pinyinName), \(englishName), \(pharmName), \(botanicalName), \(uses), \(category), \(temp), \(meridians)"
    }
    
}



