//
//  Image.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 10/1/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import Foundation
import CoreData

@objc(Image)
class Image: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var imageData: NSData
    @NSManaged var url: String
   // @NSManaged var item: Item

}
