//
//  HerbsController.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/20/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit
import CoreData

class EM_HerbsController: NSObject {
    
    private let HerbKey = "herbs"
    
    static let sharedController = EM_HerbsController()
    
    var defaultHerbs: [Herb] {
        
        var array: [Herb] = []
        
        let windCold = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.DisperseWindCold)
        let windHeat = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.DisperseWindHeat)
        let PurgeHeat = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.PurgeHeat)
        let ClearBloodHeat = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.ClearBloodHeat)
        let ClearDampHeat = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.ClearDampHeat)
        let ClearToxicHeat = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.ClearToxicHeat)
        let ClearDeficiencyHeat = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.ClearDeficiencyHeat)
        let Laxatives = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.Laxatives)
        let DrainDamp = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.DrainDamp)
        let DispelWindDamp = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.DispelWindDamp)
        let DissolveHotPhlegm = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.DissolveHotPhlegm)
        let DissolveColdPhlegm = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.DissolveColdPhlegm)
        let StopCough = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.StopCough)
        let AromaticsDispelDamp = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.AromaticsDispelDamp)
        let Digestives = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.Digestives)
        let RegulateQi = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.RegulateQi)
        let StopBleeding = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.StopBleeding)
        let MoveBlood = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.MoveBlood)
        let WarmInterior = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.WarmInterior)
        let TonifyQi = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.TonifyQi)
        let TonifyBlood = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.TonifyBlood)
        let TonifyYang = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.TonifyYang)
        let TonifyYin = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.TonifyYin)
        let Astringents = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.Astringents)
        let CalmShen = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.CalmShen)
        let NourishShen = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.NourishShen)
        let ExtinguishLiverWind = HerbSets.sharedController.getHerbSet(HerbSets.HerbSetType.ExtinguishLiverWind)
        
        
        let array0 = [windCold, windHeat]
        let array1 = [PurgeHeat, ClearBloodHeat, ClearDampHeat, ClearToxicHeat, ClearDeficiencyHeat]
        let array2 = [Laxatives,  DrainDamp]
        let array3 = [DispelWindDamp, AromaticsDispelDamp]
        let array4 = [DissolveHotPhlegm, DissolveColdPhlegm, StopCough]
        let array5 = [Digestives, RegulateQi]
        let array6 = [StopBleeding, MoveBlood]
        let array7 = [WarmInterior]
        let array8 = [TonifyQi, TonifyBlood, TonifyYin, TonifyYang]
        let array9 = [Astringents, CalmShen, NourishShen]
        let array10 = [ExtinguishLiverWind]
        
        let allCategories = [array0, array1, array2, array3, array4, array5, array6, array7, array8, array9, array10]
        
        let flattenedAllCategories = allCategories.flatMap{$0}
        let flattenedFlattenedAllCategories = flattenedAllCategories.flatMap{$0}
        
        array = flattenedFlattenedAllCategories
        
        return array
        
    }
    
    var herbs: [Herb] {
        
        let request = NSFetchRequest(entityName: "Herb")
        
        do {
            let herbsArray = try Stack.sharedStack.managedObjectContext.executeFetchRequest(request) as! [Herb]
            
            return herbsArray
            
        } catch {
            return []
        }
    }
    
    var windColdHerbs: [Herb] {
        
        let windCold = self.herbs.filter({ $0.category!.containsString("Release Wind-Cold Exterior") })
        
        return windCold
        
    }
    
    var herbsByPinyin: [Herb] {
        
        let array = herbs.sort { $0.pinyinName!.localizedCaseInsensitiveCompare($1.pinyinName!) == NSComparisonResult.OrderedAscending }
        
        return array
        
    }
    
    var herbsByEnglish: [Herb] {
        
        let array = herbs.sort { $0.englishName!.localizedCaseInsensitiveCompare($1.englishName!) == NSComparisonResult.OrderedAscending }
        
        return array
        
    }
    
    var herbsByCategory: [Herb] {
        
        let array = herbs.sort { $0.category!.localizedCaseInsensitiveCompare($1.category!) == NSComparisonResult.OrderedAscending }
        
        return array
    }
    
    func getHerbsByCategory(category: String) -> [Herb] {
        
        let theseHerbs = self.herbs.filter({ $0.category!.containsString(category) })
        
        return theseHerbs
        
    }
    
    func addHerb(herb: Herb) {
        saveToPersistentStorage()
    }
    
    func removeHerb( herb: Herb) {
        herb.managedObjectContext?.deleteObject(herb)
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