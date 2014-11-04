//
//  Item.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 10/13/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
class Item: NSManagedObject {

    @NSManaged var desc: String
    @NSManaged var identifier: String
    @NSManaged var location: String
    @NSManaged var name: String
    @NSManaged var image: NSSet
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
}
