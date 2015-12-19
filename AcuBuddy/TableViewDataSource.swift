//
//  TableViewDataSource.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/17/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var data: [AnyObject] = []
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTableViewCell
        
        cell.textLabel?.text = "Test"
        
        self.data = PointsController.sharedInstance.data
        
        if data.count > 1 {
            
        let entry = data[indexPath.row]
            
        cell.textLabel?.text = entry as? String
            
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if data.count > 1 {
            
            return data.count
            
        } else {
        
            return 5
        }
    }
    
    
}

