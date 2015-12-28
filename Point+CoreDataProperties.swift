//
//  Point+CoreDataProperties.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/27/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Point {

    @NSManaged var channel: String?
    @NSManaged var number: String?
    @NSManaged var pinyinName: String?
    @NSManaged var actions: String?
    @NSManaged var channelAbrev: String?
    @NSManaged var chineseCharacter: String?
    @NSManaged var englishName: String?
    @NSManaged var imageName: String?
    @NSManaged var locationDescription: String?
    @NSManaged var meeting: String?
    @NSManaged var needling: String?
    @NSManaged var neuroAnatomy: String?
    @NSManaged var pointOnMeridian: String?
    @NSManaged var specialCategories: String?
    @NSManaged var triggerPointAssociations: String?
    @NSManaged var uses: String?
    @NSManaged var warning: String?
    @NSManaged var images: NSSet?

}
