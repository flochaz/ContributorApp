//
//  Image.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 10/13/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import Foundation
import CoreData


@objc(Image)
class Image: NSManagedObject {

    @NSManaged var imageData: NSData
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var name: String
    @NSManaged var url: String
    @NSManaged var item: Item

}
