//
//  Item.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 11/5/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
class Item: NSManagedObject {

    @NSManaged var desc: String
    @NSManaged var identifier: String
    @NSManaged var name: String
    @NSManaged var longitude: Double
    @NSManaged var latitude: Double
    @NSManaged var constructionType: String
    @NSManaged var address: String
    @NSManaged var subConstructionType: String
    @NSManaged var builder: String
    @NSManaged var startBuildDate: NSDate
    @NSManaged var endBuildDate: NSDate
    @NSManaged var whyBuild: String
    @NSManaged var image: NSSet

}
