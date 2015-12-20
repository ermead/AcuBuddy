//
//  TableViewDataSource.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/17/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTableViewCell
        
        let points = PointsController.sharedInstance.points
        let point = points[indexPath.row]
        let channel = point.channel
        let number = point.number
        
        
        cell.textLabel?.text = channel! + number!
        
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            let count = PointsController.sharedInstance.points.count
        
            return count
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let points = PointsController.sharedInstance.points
        let point = points[indexPath.row]
        
        print("cell hit")
        
        kEntry = point
        
    }
    

}

