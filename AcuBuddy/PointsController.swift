//
//  PointsController.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/19/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation
import CoreData

class EM_PointsController {
    
     private let PointKey = "points"
    
    static let sharedInstance = EM_PointsController()
    
    var data: [Point] = []
    
    var points: [Point] {
        
        let request = NSFetchRequest(entityName: "Point")
        
        do {
            let pointsArray = try Stack.sharedStack.managedObjectContext.executeFetchRequest(request) as! [Point]
            
            return pointsArray
            
        } catch {
            return []
        }
    }
    
    func addPoint(point: Point) {
        saveToPersistentStorage()
        print("did I add it?")
    }
    
    func removePoint( point: Point) {
        point.managedObjectContext?.deleteObject(point)
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage(){
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Error saving Managed Object Context. Items not saved.")
        }
    }
    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsPath: AnyObject = directorySearchResults[0]
        let entriesPath = documentsPath.stringByAppendingString("/\(key).plist")
        
        return entriesPath
    }
    


    
}