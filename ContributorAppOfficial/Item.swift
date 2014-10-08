//
//  Item.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 10/1/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import Foundation
import CoreData

class Item: NSManagedObject {

    @NSManaged var identifier: String
    @NSManaged var name: String
    @NSManaged var desc: String
    @NSManaged var location: String
    //@NSManaged var image: NSSet

}
