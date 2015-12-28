//
//  TableViewDataSource.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/17/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit
import CoreData

var kIsHerbs: Bool?
var kDataSet: String?
var kIsFirstPage: Bool?

class EM_TableViewDataController: NSObject, UITableViewDataSource {
    
    
    
        let microsystems = ["Ear", "Eye", "Scalp", "Tongue", "Face", "Hand", "Abdomen", "Foot"]
        let diets = ["Anti-inflammatory & Cooling", "Warming & Strengthening"]
        let moxaInfoCategories = ["moxa charts", "moxa recipes"]

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! EM_CustomTableViewCell
        
        // Keys: "Microsystems", "Acupuncture", "Diet", "Herbs", "Moxa"
        
//        if kIsFirstPage == true {
//            
//            if indexPath.row == 0 {
//                cell.textLabel?.text = "Favorites"
//            } else if indexPath.row == 1 {
//                cell.textLabel?.text = "All"
//            }
//            
//            return cell
//        }
        
        if kDataSet == "All Herbs" {
            
            var herbs: [AnyObject] = []
            
            herbs = EM_HerbsController.sharedController.herbs
            let herb = herbs[indexPath.row] as! Herb
            
            cell.textLabel?.text = herb.pinyinName
           
         
            
        }  else if kDataSet == "All Points" {
            var points: [AnyObject] = []
            
            points = EM_PointsController.sharedController.points
            let point = points[indexPath.row] 
            
            cell.textLabel?.text = point.pinyinName
            
        
        } else if kDataSet == "Acupuncture" {
            // it is a point
           
//            let point = points[indexPath.row] as! Point
//            let name = point.pinyinName
//        
//            cell.textLabel?.text = name
            
        } else if kDataSet == "Microsystems" {
            
            
            let microsystem = microsystems[indexPath.row]
            
            cell.textLabel?.text = microsystem
            
        } else if kDataSet == "Diet" {
            
           
            let diet = diets[indexPath.row]
            
            cell.textLabel?.text = diet
            
        } else if kDataSet == "Moxa" {
            
            
            
            let info = moxaInfoCategories[indexPath.row]
            
            cell.textLabel?.text = info
            
        } else {
            
            cell.textLabel?.text = "Error"
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        var herbs = EM_HerbsController.sharedController.herbs
        var points = EM_PointsController.sharedController.points
        var count: Int?
        
//        if kIsFirstPage == true {
//           
//            return 2
//        }
        
        if kIsHerbs == true {
            
            count = herbs.count
            //count = EM_HerbsController.sharedInstance.herbs.count
            
        } else if kDataSet == "All Herbs" {
            
            count = herbs.count
           
            
        }  else if kDataSet == "All Points" {
    
            count = points.count
    
    
        } else if kDataSet == "Acupuncture" {
            
            count = points.count
            //count = EM_PointsController.sharedInstance.points.count
            
        } else if kDataSet == "Microsystems" {
            
            count = microsystems.count
            
        } else if kDataSet == "Diet" {
            
            count = diets.count
            
        } else if kDataSet == "Moxa" {
            
            count = moxaInfoCategories.count
            
        } else {
            
            count = 8
        }
        
        return count!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        let points = EM_PointsController.sharedController.points
        let point = points[indexPath.row]
         kEntry = point
        
        print("cell hit")
       
        
       
        
    }
    

}

