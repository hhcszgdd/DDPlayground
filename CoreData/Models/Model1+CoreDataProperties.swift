//
//  Model1+CoreDataProperties.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/2/29.
//  Copyright © 2020 JohnConnor. All rights reserved.
//
//

import Foundation
import CoreData


extension Model1 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Model1> {
        return NSFetchRequest<Model1>(entityName: "Model1")
    }

    @NSManaged public var name: String?

}
