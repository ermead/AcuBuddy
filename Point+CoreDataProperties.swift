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

    @NSManaged var reference: String?
    @NSManaged var pinyin: String?
    @NSManaged var english: String?
    @NSManaged var channel: String?
    @NSManaged var number: String?

}
