//
//  TypeEvent+CoreDataProperties.swift
//  pketmoi
//
//  Created by Hugo Maitre on 26/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//
//

import Foundation
import CoreData


extension TypeEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TypeEvent> {
        return NSFetchRequest<TypeEvent>(entityName: "TypeEvent")
    }

    @NSManaged public var name: String?

}
