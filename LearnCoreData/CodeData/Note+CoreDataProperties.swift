//
//  Note+CoreDataProperties.swift
//  LearnCoreData
//
//  Created by Ngoduc on 6/13/20.
//  Copyright © 2020 com.techmaster.D. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: String
    @NSManaged public var username: String?
    @NSManaged public var content: String?
    @NSManaged public var date: String?
    @NSManaged public var isSelected: Bool

}
