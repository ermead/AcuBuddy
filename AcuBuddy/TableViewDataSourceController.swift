//
//  TableViewDataSource.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/17/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

var kIsHerbs: Bool?
var kDataSet: String?

class EM_TableViewDataController: NSObject, UITableViewDataSource {
    

    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! EM_CustomTableViewCell
        
      
        
        if kIsHerbs == true {
            //it is a herb
            
            let herbs = EM_HerbsController.sharedInstance.herbs
            
            let herb = herbs[indexPath.row]
            let name = herb.name
            
            cell.textLabel?.text = name
            
        } else {
            // it is a point
            let points = EM_PointsController.sharedInstance.points
        
            let point = points[indexPath.row]
            let channel = point.channel
            let number = point.number
        
            cell.textLabel?.text = channel! + number!
        }
        
        if kDataSet == "Microsystems" {
            
            cell.textLabel?.text = "Microsystems"
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count: Int?
        
        if kIsHerbs == true {
            
            count = EM_HerbsController.sharedInstance.herbs.count
        } else {
            count = EM_PointsController.sharedInstance.points.count
        }
        
        if kDataSet == "Microsystems" {
            
           
        }
        
        return count!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let points = EM_PointsController.sharedInstance.points
        let point = points[indexPath.row]
        
        print("cell hit")
        
        kEntry = point
        
    }
    

}

