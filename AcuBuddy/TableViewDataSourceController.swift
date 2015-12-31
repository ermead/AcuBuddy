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

var ahc: [String] = [
    "Release Wind-Cold Exterior",
    "Release Wind-Heat Exterior",
    "Clear Damp-Heat",
    "Clear Blood Heat",
    "Purge Heat",
    "Clear Toxic Heat",
    "Clear Deficiency-Heat",
    "Drain Dampness",
    "Laxative",
    "Dispel Wind-Damp",
    "Dissolve Hot Phlegm",
    "Dissolve Cold Phlegm",
    "Stop Cough",
    "Aromatics to Resolve Dampness",
    "Promote Digestion",
    "Regulate Qi Flow",
    "Stop Bleeding",
    "Move the Blood",
    "Warm the Interior"
]

var apc: [String] = [
    "LU", "LI", "ST", "SP", "HT", "SI", "BL", "KI", "PC", "SJ", "GB", "LR", "REN", "DU"
]

var selectedSections: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

class EM_TableViewDataController: NSObject, UITableViewDataSource {

    let microsystems = ["Ear", "Eye", "Scalp", "Tongue", "Face", "Hand", "Abdomen", "Foot"]
    let diets = ["Anti-inflammatory & Cooling", "Warming & Strengthening"]
    let moxaInfoCategories = ["moxa charts", "moxa recipes"]
    
    //Array of herb categories
    
    //these are herb arrays per category
    var herbsArray: [Herb] = []
    var herbsArray1: [Herb] = []
    var herbsArray2: [Herb] = []
    var herbsArray3: [Herb] = []
    var herbsArray4: [Herb] = []
    var herbsArray5: [Herb] = []
    var herbsArray6: [Herb] = []
    var herbsArray7: [Herb] = []
    var herbsArray8: [Herb] = []
    var herbsArray9: [Herb] = []
    var herbsArray10: [Herb] = []
    var herbsArray11: [Herb] = []
    var herbsArray12: [Herb] = []
    var herbsArray13: [Herb] = []
    var herbsArray14: [Herb] = []
    var herbsArray15: [Herb] = []
    var herbsArray16: [Herb] = []
    var herbsArray17: [Herb] = []
    var herbsArray18: [Herb] = []
    var herbsArray19: [Herb] = []
    // All Herb Arrays:
    var aha: [[Herb]] = []
    
    //Array of point categories (channels)
   
    
    var pointsArray: [Point] = []
    var pointsArray1: [Point] = []
    var pointsArray2: [Point] = []
    var pointsArray3: [Point] = []
    var pointsArray4: [Point] = []
    var pointsArray5: [Point] = []
    var pointsArray6: [Point] = []
    var pointsArray7: [Point] = []
    var pointsArray8: [Point] = []
    var pointsArray9: [Point] = []
    var pointsArray10: [Point] = []
    var pointsArray11: [Point] = []
    var pointsArray12: [Point] = []
    var pointsArray13: [Point] = []
    var pointsArray14: [Point] = []
    //All Point Arrays
    var apa: [[Point]] = []
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var number = 1
        if kDataSet == "All Herbs" {
            number = ahc.count
        }
        if kDataSet == "All Points" {
            number = apc.count
        }
        return number
    }
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Test!"
//    }
    
        


    
    //    //MARK: Section titles
    //    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
    //
    //        var string: [String] = []
    //        if kDataSet == "All Herbs" {
    //            string = self.ahc
    //        }
    //        if kDataSet == "All Points" {
    //            string = self.apc
    //        }
    //
    //        return string
    //    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! EM_CustomTableViewCell
        
        // Keys: "Microsystems", "Acupuncture", "Diet", "Herbs", "Moxa"
        
        
        var herbsArray: [Herb] = []
        var pointsArray: [Point] = []
      
        if kDataSet == "All Herbs" {
          
            kArray = aha[indexPath.section]
            let herb = kArray[indexPath.row] as! Herb
            
            cell.textLabel?.text = herb.pinyinName
          
        } else if kDataSet == "Favorite Herbs" {
            
            kArray = EM_HerbsController.sharedController.getHerbsByCategory("Release Wind-Heat Exterior")
            let herb = kArray[indexPath.row] as! Herb
            
            cell.textLabel?.text = herb.pinyinName
            
            
        } else if kDataSet == "Favorite Points" {
            
            
            
            kArray = EM_PointsController.sharedController.getPointsByChannel("LU")
            let point = kArray[indexPath.row]
            
            cell.textLabel?.text = point.pinyinName
            
            
        }  else if kDataSet == "All Points" {
            
            setupPointData()
            
            kArray = apa[indexPath.section]
            let point = kArray[indexPath.row]
            
            cell.textLabel?.text = point.pinyinName
            
            
        } else if kDataSet == "Acupuncture" {
            
            
            kArray = EM_PointsController.sharedController.pointsByPinyin
            let point = kArray[indexPath.row]
            
            cell.textLabel?.text = point.pinyinName
            
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
        
        let favoriteHerbs = EM_HerbsController.sharedController.getHerbsByCategory("Release Wind-Heat Exterior")
        let favoritePoints = EM_PointsController.sharedController.getPointsByChannel("LU")
        _ = EM_HerbsController.sharedController.herbs
        let points = EM_PointsController.sharedController.points
        
        var count: Int?
        
        setupHerbData()
        setupPointData()
        
        if selectedSections.contains(section) {
            
            if kDataSet == "All Herbs" {
                
                count = self.aha[section].count
                
                
            }  else if kDataSet == "All Points" {
                
                count = self.apa[section].count
                
                
            }  else if kDataSet == "Favorite Points" {
                
                count = favoritePoints.count
                
                
            } else if kDataSet == "Favorite Herbs" {
                
                count = favoriteHerbs.count
                
                
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
        } else {
            count = 1
        }
        
        return count!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let points = kArray
        let point = points[indexPath.row]
        kEntry = point
        
        print("cell hit")
      
    }
    
    
    //MARK: Set Up Table Arrays
    func setupHerbData() {
        
        self.herbsArray1 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[0])
        self.herbsArray2 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[1])
        self.herbsArray3 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[2])
        self.herbsArray4 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[3])
        self.herbsArray5 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[4])
        self.herbsArray6 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[5])
        self.herbsArray7 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[6])
        self.herbsArray8 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[7])
        self.herbsArray9 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[8])
        self.herbsArray10 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[9])
        self.herbsArray11 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[10])
        self.herbsArray12 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[11])
        self.herbsArray13 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[12])
        self.herbsArray14 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[13])
        self.herbsArray15 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[14])
        self.herbsArray16 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[15])
        self.herbsArray17 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[16])
        self.herbsArray18 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[17])
        self.herbsArray19 = EM_HerbsController.sharedController.getHerbsByCategory(ahc[18])
        /*
        
        "Warm the Interior"
        */
        
        //all herb arrays:
        self.aha = [herbsArray1, herbsArray2,herbsArray3,herbsArray4,herbsArray5,herbsArray6,herbsArray7,herbsArray8,herbsArray9,herbsArray10,herbsArray11,herbsArray12,herbsArray13,herbsArray14,herbsArray15,herbsArray16,herbsArray17,herbsArray18,herbsArray19]
        
        
    }
    
    func setupPointData(){
        
        self.pointsArray = EM_PointsController.sharedController.pointsByPointOnMeridian
        
        self.pointsArray1 = EM_PointsController.sharedController.getPointsByChannel(apc[0]).sort { $0.pointOnMeridian!.localizedStandardCompare($1.pointOnMeridian!) == NSComparisonResult.OrderedAscending }
        self.pointsArray2 = EM_PointsController.sharedController.getPointsByChannel(apc[1]).sort { $0.pointOnMeridian!.localizedStandardCompare($1.pointOnMeridian!) == NSComparisonResult.OrderedAscending }
        self.pointsArray3 = EM_PointsController.sharedController.getPointsByChannel(apc[2]).sort { $0.pointOnMeridian!.localizedStandardCompare($1.pointOnMeridian!) == NSComparisonResult.OrderedAscending }
        self.pointsArray4 = EM_PointsController.sharedController.getPointsByChannel(apc[3]).sort { $0.pointOnMeridian!.localizedStandardCompare($1.pointOnMeridian!) == NSComparisonResult.OrderedAscending }
        self.pointsArray5 = EM_PointsController.sharedController.getPointsByChannel(apc[4]).sort { $0.pointOnMeridian!.localizedStandardCompare($1.pointOnMeridian!) == NSComparisonResult.OrderedAscending }
        self.pointsArray6 = EM_PointsController.sharedController.getPointsByChannel(apc[5]).sort { $0.pointOnMeridian!.localizedStandardCompare($1.pointOnMeridian!) == NSComparisonResult.OrderedAscending }
        self.pointsArray7 = EM_PointsController.sharedController.getPointsByChannel(apc[6]).sort { $0.pointOnMeridian!.localizedStandardCompare($1.pointOnMeridian!) == NSComparisonResult.OrderedAscending }
        self.pointsArray8 = EM_PointsController.sharedController.getPointsByChannel(apc[7]).sort { $0.pointOnMeridian!.localizedStandardCompare($1.pointOnMeridian!) == NSComparisonResult.OrderedAscending }
        self.pointsArray9 = EM_PointsController.sharedController.getPointsByChannel(apc[8]).sort { $0.pointOnMeridian!.localizedStandardCompare($1.pointOnMeridian!) == NSComparisonResult.OrderedAscending }
        self.pointsArray10 = EM_PointsController.sharedController.getPointsByChannel(apc[9]).sort { $0.pointOnMeridian!.localizedStandardCompare($1.pointOnMeridian!) == NSComparisonResult.OrderedAscending }
        self.pointsArray11 = EM_PointsController.sharedController.getPointsByChannel(apc[10]).sort { $0.pointOnMeridian!.localizedStandardCompare($1.pointOnMeridian!) == NSComparisonResult.OrderedAscending }
        self.pointsArray12 = EM_PointsController.sharedController.getPointsByChannel(apc[11]).sort { $0.pointOnMeridian!.localizedStandardCompare($1.pointOnMeridian!) == NSComparisonResult.OrderedAscending }
        self.pointsArray13 = EM_PointsController.sharedController.getPointsByChannel(apc[12]).sort { $0.pointOnMeridian!.localizedStandardCompare($1.pointOnMeridian!) == NSComparisonResult.OrderedAscending }
        self.pointsArray14 = EM_PointsController.sharedController.getPointsByChannel(apc[13]).sort { $0.pointOnMeridian!.localizedStandardCompare($1.pointOnMeridian!) == NSComparisonResult.OrderedAscending }
        //all point arrays:
        self.apa = [pointsArray1, pointsArray2, pointsArray3, pointsArray4, pointsArray5, pointsArray6, pointsArray7, pointsArray8, pointsArray9, pointsArray10, pointsArray11, pointsArray12, pointsArray13, pointsArray14 ]
        
    }
    
}



